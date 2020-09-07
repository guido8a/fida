package seguridad

import geografia.Canton
import geografia.Parroquia
import geografia.Provincia
import parametros.Anio
import proyectos.PresupuestoUnidad

class UnidadEjecutoraController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def dbConnectionService

    def form_ajax(){

        def unidad

        if(params.id){
            unidad = UnidadEjecutora.get(params.id)
        }else{
            unidad =  new UnidadEjecutora()
        }

        return [unidad:unidad]
    }

    def saveUnidad_ajax(){
//        println("params sue " + params)

        def unidad
        def texto

        if(params.fechaInicio){
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }else{
            params.fechaInicio = null
        }

        if(!params.orden){
            params.orden = 0
        }

        if(!params.numero){
            params.numero = 0
        }

        if(params.id){
            unidad = UnidadEjecutora.get(params.id)
            texto = "Unidad actualizada correctamente"
        }else{
            unidad = new UnidadEjecutora()
            texto = "Unidad creada correctamente"
        }

        params.anio = params.anio ? params.anio : 0
        if(!params.provincia){
            params.provincia = Parroquia.get(params.parroquia).canton.provincia
        }

        if(!params.tipoInstitucion){
            params.tipoInstitucion = TipoInstitucion.get(2)
        }

        unidad.properties = params

        if(!unidad.save(flush:true)){
            println("Error en save de unidad ejecutora " + unidad.errors)
            render "no_Error al guardar la unidad"
        }else{
            render "ok_" + texto + "_" + unidad?.id
        }
    }


    def show_ajax(){
        def unidad = UnidadEjecutora.get(params.id)

        return[unidad: unidad]
    }

    def borrarUnidad_ajax(){
        def unidad = UnidadEjecutora.get(params.id)

        def hijos = UnidadEjecutora.findAllByPadre(unidad)
        hijos += Persona.findAllByUnidadEjecutora(unidad)

        if(hijos.size() > 0){
            render "res_La unidad tiene unidades/usuarios asociados a ella "
        }else{
            unidad.fechaFin = new Date()

            if(!unidad.save(flush:true)){
                println("error al borrar la unidad ejecutora " + unidad.error)
                render "no"
            }else{
                render "ok"
            }
        }
    }

    def arbol(){

    }

    def loadTreePart_ajax() {
        render(makeTreeNode(params))
    }

    def makeTreeNode(params) {
//        println "makeTreeNode.. $params"
        def id = params.id
        def tipo = ""
        def liId = ""
        def ico = ""
        def iconoInactivo = ""
        def tam = 0
        String tree = "", clase = "", rel = "", clase2="", clase3=""
        def padre
        def hijos = []

        if(id.contains("_")) {
            id = params.id.split("_")[1]
            tipo = params.id.split("_")[0]
        }

        if (!params.order) {
            params.order = "asc"
        }

//        println "---> id: $id, tipo: $tipo, es #: ${id == '#'}"

        //root
        if (id == "#") {
            def hh = UnidadEjecutora.countByPadreIsNull()

            if (hh > 0) {
                clase = "hasChildren jstree-closed"
            }

            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' data-level='0' >" +
                    "<a href='#' class='label_arbol'>Estructura Principal</a>" +
                    "</li>"
            if (clase == "") {
                tree = ""
            }

        } else if (id == "root") {
//            hijos = UnidadEjecutora.findAllByPadreIsNullAndFechaFinIsNull().sort{it.nombre}
            hijos = geografia.Provincia.findAll().sort{it.nombre}
            def presupuesto = ""
            def data = ""

            ico = ", \"icon\":\"far fa-folder text-success\""
            hijos.each { hijo ->
//                println "procesa ${hijo.nombre}"
//                presupuesto = UnidadEjecutora.findByCodigoAndFechaFinIsNull('FRPS') ? ' presupuesto' : ''
                clase = "jstree-closed hasChildren"
//                clase2 = UnidadEjecutora.findAllByPadreIsNullAndFechaFinIsNull().sort{it.nombre} ? " hasChildren" : ''
                clase2 = UnidadEjecutora.findAllByProvincia(hijo).sort{it.nombre} ? " hasChildren" : ''
                tree += "<li id='prov_" + hijo.id + "' class='" + clase + clase2 + "' ${data} data-jstree='{\"type\":\"${"prov"}\" ${ico}}' >"
                tree += "<a href='#' class='label_arbol'>" + hijo?.nombre + "</a>"
                tree += "</li>"
            }
        } else if (tipo == "prov") {
            def prov = Provincia.get(id)
            def cntn = Canton.findAllByProvincia(prov)
            def parr = Parroquia.findAllByCantonInList(cntn)
            hijos = cntn
            def icono = ""
            def data = ""

            hijos.each { hijo ->
                icono = "fa-parking"
                ico = ", \"icon\":\"fas ${icono} text-warning\""
//                clase =  "jstree-closed hasChildren"
                clase = UnidadEjecutora.findAllByPadreIsNullAndFechaFinIsNull().sort{it.nombre} ? "jstree-closed hasChildren" : "jstree-closed"
//                clase2 = UnidadEjecutora.findAllByPadreIsNullAndFechaFinIsNull().sort{it.nombre} ? " hasChildren" : ''
                tree += "<li id='cnt_" + hijo.id + "' class='" + clase + "' ${data} data-jstree='{\"type\":\"${"canton"}\" ${ico}}' >"
                tree += "<a href='#' class='label_arbol'>" + hijo?.nombre + "</a>"
                tree += "</li>"
            }
        }
//        else if (tipo == "cnt") {
//            def cntn = Canton.get(id)
//            def prov = cntn.provincia
//            def parr = Parroquia.findAllByCanton(cntn)
//            def ieps = UnidadEjecutora.findAllByProvinciaAndPadreIsNullAndFechaFinIsNull(prov).sort{it.nombre}
//            hijos = UnidadEjecutora.findAllByParroquiaInListAndPadreIsNullAndFechaFinIsNull(parr).sort{it.nombre}
//            hijos += ieps
//            def icono = ""
//            def data = ""
//            def presupuesto = ""
//
//            hijos.each { hj ->
//                icono = hj.tipoInstitucion.id == 1 ? "fas fa-warehouse" : "fa-home"
//                ico = ", \"icon\":\"fas ${icono} text-success\""
//                presupuesto = hj.nombre.contains('FAREPS') ? ' presupuesto' : ''
//                clase = UnidadEjecutora.findByPadreAndFechaFinIsNull(hj) ? "jstree-closed hasChildren" : "jstree-closed"
//                clase2 = Persona.findAllByUnidadEjecutora(hj) ? " hasChildren" : ''
//                tree += "<li id='uni_" + hj.id + "' class='" + clase + clase2 + presupuesto + "' ${data} data-jstree='{\"type\":\"${"unidadEjecutora"}\" ${ico}}' >"
//                tree += "<a href='#' class='label_arbol'>" + hj?.nombre + "</a>"
//                tree += "</li>"
//            }
//        }
        else {
            switch(tipo) {
                case "cnt":
                    def cant = Canton.get(id)
                    def prov = cant.provincia
                    def parr = Parroquia.findAllByCanton(cant)
                    def presupuesto = ""
                    def icono = ""
                    def data = ""
                    def ieps = UnidadEjecutora.findAllByProvinciaAndPadreIsNullAndFechaFinIsNull(prov).sort{it.nombre}
                    hijos = UnidadEjecutora.findAllByParroquiaInListAndPadreIsNullAndFechaFinIsNull(parr).sort{it.nombre}
                    hijos += ieps
                    hijos.each { hj ->
                        icono = hj.tipoInstitucion.id == 1 ? "fas fa-warehouse" : "fa-home"
                        ico = ", \"icon\":\"fas ${icono} text-success\""
                        presupuesto = hj.nombre.contains('FAREPS') ? ' presupuesto' : ''
                        clase = UnidadEjecutora.findByPadreAndFechaFinIsNull(hj) ? "jstree-closed hasChildren" : "jstree-closed"
                        clase2 = Persona.findAllByUnidadEjecutora(hj) ? " hasChildren" : ''
                        tree += "<li id='uni_" + hj.id + "' class='" + clase + clase2 + presupuesto + "' ${data} data-jstree='{\"type\":\"${"unidadEjecutora"}\" ${ico}}' >"
                        tree += "<a href='#' class='label_arbol'>" + hj?.nombre + "</a>"
                        tree += "</li>"
                    }
                    break
                case "uni":
                    hijos += UnidadEjecutora.findAllByPadreAndFechaFinIsNull(UnidadEjecutora.get(id), [sort: params.sort])
                    hijos += Persona.findAllByUnidadEjecutora(UnidadEjecutora.get(id), [sort: params.sort, order: params.order])
                    hijos.each { h ->
//                        println "procesa $h"
                        if(h instanceof UnidadEjecutora){
                            ico = ", \"icon\":\"fa fa-building text-success\""
                            clase = UnidadEjecutora.findByPadreAndFechaFinIsNull(h) ? "jstree-closed hasChildren" : "jstree-closed"
                            clase2 = Persona.findAllByUnidadEjecutora(h) ? " hasChildren" : ''
                            tree += "<li id='uni_" + h.id + "' class='" + clase + clase2 + "' data-jstree='{\"type\":\"${"unidadEjecutora"}\" ${ico}}' >"
                            tree += "<a href='#' class='label_arbol'>" + h?.nombre + "</a>"
                            tree += "</li>"
                        }else{
                            ico = ", \"icon\":\"fa fa-user-circle text-info\""
                            iconoInactivo = ", \"icon\":\"fa fa-user-circle text-default\""
                            clase = "jstree-closed"
                            clase3 = "jstree-closed inactivo"
//                            if(Persona.get(h.id).fechaFin == null){
                            if(Persona.get(h.id).activo == 1){
                                tree += "<li id='usu_" + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"persona"}\" ${ico}}'>"
                            }else{
                                tree += "<li id='usu_" + h.id + "' class='" + clase3 + "' data-jstree='{\"type\":\"${"persona"}\" ${iconoInactivo}}'>"
                            }
                            tree += "<a href='#' class='label_arbol'>" + h.nombreCompleto + "</a>"
                            tree += "</li>"
                        }
                    }
                    break
                case "usu":
                    break
            }
        }
        return tree
    }

    def arbolSearch_ajax() {
        println "arbolSearch_ajax $params"
        def search = params.str.trim()
        if (search != "") {
            def c = Persona.createCriteria()
            def find = c.list(params) {
                or {
                    ilike("nombre", "%" + search + "%")
                    ilike("apellido", "%" + search + "%")
                    ilike("login", "%" + search + "%")
                    unidadEjecutora {
                        or {
                            ilike("nombre", "%" + search + "%")
                        }
                    }
                }
            }
//            println find
            def unidades = []
            find.each { pers ->
                if (pers.unidadEjecutora && !unidades.contains(pers.unidadEjecutora)) {
                    unidades.add(pers.unidadEjecutora)
                    def dep = pers.unidadEjecutora
                    def padre = dep.padre
                    while (padre) {
                        dep = padre
                        padre = dep.padre
                        if (!unidades.contains(dep)) {
                            unidades.add(dep)
                        }
                    }
                }
            }
            unidades = unidades.reverse()
            def ids = "["
            if (find.size() > 0) {
                ids += "\"#root\","
                unidades.each { dp ->
                    ids += "\"#lidep_" + dp.id + "\","
                }
                ids = ids[0..-2]
            }
            ids += "]"
            render ids
        } else {
            render ""
        }
    }

    /**
     * Acción llamada con ajax que carga el presupuesto de la entidad
     */
    def presupuestoEntidad_ajax() {
        def unidad = UnidadEjecutora.get(params.id)
        return [unidad: unidad]
    }

    /**
     * Acción llamada con ajax que busca el presupuesto de un año de una unidad ejecutora
     * @param anio el id del año
     * @param unidad el id de la unidad
     */
    def getPresupuestoAnio_ajax() {

        def anio = Anio.get(params.anio)
        def unidad = UnidadEjecutora.get(params.unidad)
        def presupuesto = PresupuestoUnidad.findByAnioAndUnidad(anio, unidad)
        def str = (presupuesto ? util.formatNumber(number: presupuesto.maxInversion, maxFractionDigits: 2, minFractionDigits: 2) : '0.00')
//        def str = (presupuesto ? g.formatNumber(number: presupuesto.maxInversion, maxFractionDigits: 2, minFractionDigits: 2) : '0,00')
        str += "_"
        str += (presupuesto ? util.formatNumber(number: presupuesto?.originalCorrientes, maxFractionDigits: 2, minFractionDigits: 2) : '0.00')
//        str += (presupuesto ? g.formatNumber(number: presupuesto?.originalCorrientes, maxFractionDigits: 2, minFractionDigits: 2) : '0,00')
        render(str)
    }


    /**
     * Acción llamada con ajax que guarda las modificaciones del presupuesto anual de una unidad ejecutora
     */
    def savePresupuestoEntidad_ajax() {
        def unidad = UnidadEjecutora.get(params.unidad)
        def anio = parametros.Anio.get(params.anio)
        def inversion = params.maxInversion
        def corrientes = params.maxCorrientes
        def originalCorrientes = params.originalCorrientes
        def originalInversion = params.originalInversion

        if (!inversion) inversion = 0
        if (!corrientes) corrientes = 0
        if (!originalInversion) originalInversion = 0
        if (!originalCorrientes) originalCorrientes = 0

        inversion = (inversion.toString().replaceAll(",", "")).toDouble()
        corrientes = (corrientes.toString().replaceAll(",", "")).toDouble()
        originalInversion = (originalInversion.toString().replaceAll(",", "")).toDouble()
        originalCorrientes = (originalCorrientes.toString().replaceAll(",", "")).toDouble()

        // se pone valores originales d einversión y corrientes solo cuando estos son ceros
        if(inversion > 0 && originalInversion == 0) {
            originalInversion = inversion
        }
        if(corrientes > 0 && originalCorrientes == 0) {
            originalCorrientes = corrientes
        }

        def presupuestoUnidad = PresupuestoUnidad.findAllByUnidadAndAnio(unidad, anio)
        if (presupuestoUnidad.size() == 1) {
            presupuestoUnidad = presupuestoUnidad.first()
        } else if (presupuestoUnidad.size() == 0) {
            presupuestoUnidad = new PresupuestoUnidad()
            presupuestoUnidad.unidad = unidad
            presupuestoUnidad.anio = anio
        } else {
            println "Hay ${presupuestoUnidad.size()} presupuestos para el anio ${anio.anio}, unidad ${unidad.codigo}"
            presupuestoUnidad = presupuestoUnidad.first()
        }
        presupuestoUnidad.maxCorrientes = corrientes
        presupuestoUnidad.originalCorrientes = originalCorrientes
        presupuestoUnidad.originalInversion = originalInversion
        presupuestoUnidad.maxInversion = inversion

        if (!presupuestoUnidad.save(flush: true)) {
            render "ERROR*" + renderErrors(bean: presupuestoUnidad)
        } else {
            render "SUCCESS*Presupuesto modificado exitosamente"
        }
    }

    def canton_ajax () {
        def provincia = Provincia.get(params.id)
        def cantones = Canton.findAllByProvincia(provincia)
        def unidad
        if(params.unidad){
            unidad = UnidadEjecutora.get(params.unidad)
        }else{
            unidad = new UnidadEjecutora()
        }
        return[cantones: cantones, unidad: unidad]
    }

    def parroquia_ajax(){
        def canton = Canton.get(params.id)
        def parroquias = Parroquia.findAllByCanton(canton)
        def unidad
        if(params.unidad){
            unidad = UnidadEjecutora.get(params.unidad)
        }else{
            unidad = new UnidadEjecutora()
        }
        return[parroquias: parroquias, unidad: unidad]
    }

    def organizacion(){
        def unidad
        if(params.id){
            unidad = UnidadEjecutora.get(params.id)
        }else{
            unidad = new UnidadEjecutora()
        }
        return[unidad: unidad]
    }

    def buscarOrga_ajax() {

    }

    def tablaBuscarOrga_ajax(){
        println "tablaBuscarOrga_ajax: $params"
        def sql = ''
        def operador = ''

        switch (params.operador) {
            case "0":
                operador = "unejnmbr"
                break;
            case '1':
                operador = "provnmbr"
                break;
            case "2":
                operador = "cntnnmbr"
                break;
            case "3":
                operador = "parrnmbr"
                break;
        }

        def cn = dbConnectionService.getConnection()
        sql = "select unej.unej__id, unejnmbr, unejfcin, provnmbr, cntnnmbr, parrnmbr " +
                "from unej, prov, cntn, parr " +
                "where parr.parr__id = unej.parr__id and " +
                "cntn.cntn__id = parr.cntn__id and prov.prov__id = cntn.prov__id and " +
                "unej.unejfcfn is null and ${operador} ilike '%${params.texto}%' " +
                "order by unejnmbr asc limit 20"


        def res = cn.rows(sql.toString())

//        println("sql " + sql)

        return [convenios: res]
    }


}
