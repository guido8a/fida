package seguridad

import parametros.Anio
import proyectos.PresupuestoUnidad

class UnidadEjecutoraController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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

        unidad.properties = params

        if(!unidad.save(flush:true)){
            println("Error en save de unidad ejecutora " + unidad.errors)
            render "no_Error al guardar la unidad"
        }else{
            render "ok_" + texto
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
            hijos = UnidadEjecutora.findAllByPadreIsNullAndFechaFinIsNull().sort{it.nombre}
            def presupuesto = ""
            def data = ""

            ico = ", \"icon\":\"fa fa-building text-success\""
            hijos.each { hijo ->
//                println "procesa ${hijo.nombre}"
                presupuesto = UnidadEjecutora.findByCodigoAndFechaFinIsNull('FRPS') ? ' presupuesto' : ''
                clase = UnidadEjecutora.findByPadreAndFechaFinIsNull(hijo) ? "jstree-closed hasChildren" : "jstree-closed"
                clase2 = Persona.findAllByUnidadEjecutora(hijo) ? " hasChildren" : ''
                tree += "<li id='uni_" + hijo.id + "' class='" + clase + clase2 + presupuesto + "' ${data} data-jstree='{\"type\":\"${"unidadEjecutora"}\" ${ico}}' >"
                tree += "<a href='#' class='label_arbol'>" + hijo?.nombre + "</a>"
                tree += "</li>"
            }
        } else {
//            println ("---- no es raiz..." + tipo + " - " + id)
            switch(tipo) {
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
                            iconoInactivo = ", \"icon\":\"fa fa-user-circle text-primary\""
                            clase = "jstree-closed"
                            clase3 = "jstree-closed inactivo"
                            if(Persona.get(h.id).fechaFin == null){
                                tree += "<li id='usu_" + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"persona"}\" ${ico}}'>"
                            }else{
                                tree += "<li id='usu_" + h.id + "' class='" + clase3 + "' data-jstree='{\"type\":\"${"persona"}\" ${iconoInactivo}}'>"
                            }
                            tree += "<a href='#' class='label_arbol'>" + h.nombre + "</a>"
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

        println("guardar " + params)


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

}
