package proyectos

import org.springframework.dao.DataIntegrityViolationException
import parametros.proyectos.IndicadorOrms
import parametros.proyectos.TipoElemento
//import vesta.poa.Asignacion


/**
 * Controlador que muestra las pantallas de manejo de MarcoLogico
 */
class MarcoLogicoController {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]

    /**
     * Acción que redirecciona a la lista (acción "list")
     */
    def index() {
        redirect(action: "list", params: params)
    }

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = MarcoLogico.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("numeroComp", "%" + params.search + "%")
                    ilike("objeto", "%" + params.search + "%")
                    ilike("tieneAsignacion", "%" + params.search + "%")
                }
            }
        } else {
            list = MarcoLogico.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return marcoLogicoInstanceList: la lista de elementos filtrados, marcoLogicoInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def marcoLogicoInstanceList = getList(params, false)
        def marcoLogicoInstanceCount = getList(params, true).size()
        return [marcoLogicoInstanceList: marcoLogicoInstanceList, marcoLogicoInstanceCount: marcoLogicoInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return marcoLogicoInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def marcoLogicoInstance = MarcoLogico.get(params.id)
            if (!marcoLogicoInstance) {
                render "ERROR*No se encontró MarcoLogico."
                return
            }
            return [marcoLogicoInstance: marcoLogicoInstance]
        } else {
            render "ERROR*No se encontró MarcoLogico."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return marcoLogicoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def marcoLogicoInstance = new MarcoLogico()
        if (params.id) {
            marcoLogicoInstance = MarcoLogico.get(params.id)
            if (!marcoLogicoInstance) {
                render "ERROR*No se encontró MarcoLogico."
                return
            }
        }
        marcoLogicoInstance.properties = params
        return [marcoLogicoInstance: marcoLogicoInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def marcoLogicoInstance = new MarcoLogico()
        if (params.id) {
            marcoLogicoInstance = MarcoLogico.get(params.id)
            if (!marcoLogicoInstance) {
                render "ERROR*No se encontró MarcoLogico."
                return
            }
        }
        marcoLogicoInstance.properties = params
        if (!marcoLogicoInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar MarcoLogico: " + renderErrors(bean: marcoLogicoInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de MarcoLogico exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def marcoLogicoInstance = MarcoLogico.get(params.id)
            if (!marcoLogicoInstance) {
                render "ERROR*No se encontró MarcoLogico."
                return
            }
            try {
                marcoLogicoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de MarcoLogico exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar MarcoLogico"
                return
            }
        } else {
            render "ERROR*No se encontró MarcoLogico."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción que muestra el marco lógico de un proyecto
     */
    def marcoLogicoProyecto() {
        def proyecto = Proyecto.get(params.id.toLong())

        def tipoElementoFin = TipoElemento.findByDescripcion("Fin")
        def tipoElementoProposito = TipoElemento.findByDescripcion("Proposito")
        def tipoElementoComponente = TipoElemento.findByDescripcion("Componente")

        def fin = MarcoLogico.withCriteria {
            eq("proyecto", proyecto)
            eq("tipoElemento", tipoElementoFin)
            eq("estado", 0)
        }
        def proposito = MarcoLogico.withCriteria {
            eq("proyecto", proyecto)
            eq("tipoElemento", tipoElementoProposito)
            eq("estado", 0)
        }
        def componentes = MarcoLogico.withCriteria {
            eq("proyecto", proyecto)
            eq("tipoElemento", tipoElementoComponente)
            eq("estado", 0)
            order("numero", "asc")
        }

        if (!params.show) {
            params.show = 0
        }
        def reqParams = params.clone()
        reqParams.remove('show')

        return [fin: fin, proposito: proposito, proyecto: proyecto, componentes: componentes, reqParams: reqParams]
    }

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un componente
     * @return marcoLogicoInstance el objeto a modificar cuando se encontró el componente
     * @render ERROR*[mensaje] cuando no se encontró el componente
     */
    def form_componente_ajax() {
//        println "Form componente: " + params

        def marcoLogicoInstance = new MarcoLogico()
        if (params.id) {
            marcoLogicoInstance = MarcoLogico.get(params.id)
            if (!marcoLogicoInstance) {
                render "ERROR*No se encontró Componente."
                return
            }
        }
        marcoLogicoInstance.properties = params
        return [marcoLogicoInstance: marcoLogicoInstance, show: params.show]
    }

    /**
     * Acción llamada con ajax que guarda la información de un componente
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_componente_ajax() {

        def proyecto = Proyecto.get(params."proyecto.id")
        def marcoLogicoInstance

        if(params.id){
            if(proyecto.fechaRegistro){
                println("con registro")

                marcoLogicoInstance = MarcoLogico.get(params.id)

                def modificacion = new ModificacionMarcoLogico()
                modificacion.marcoLogico = marcoLogicoInstance
                modificacion.objetivo = marcoLogicoInstance.objeto
                modificacion.numero = marcoLogicoInstance.numero
                modificacion.monto = marcoLogicoInstance.monto
                modificacion.fecha = new Date()


                if(!modificacion.save(flush:true)){
                    println("error al guardar la modificacion " + modificacion.errors)
                    render"ERROR*Error al generar la modificación"
                }else{
                    marcoLogicoInstance.properties = params
                }

            }else{
                marcoLogicoInstance = new MarcoLogico()
                if (params.id) {
                    marcoLogicoInstance = MarcoLogico.get(params.id)
                    if (!marcoLogicoInstance) {
                        render "ERROR*No se encontró Componente."
                        return
                    }
                }
                marcoLogicoInstance.properties = params
//                if (!marcoLogicoInstance.save(flush: true)) {
//                    render "ERROR*Ha ocurrido un error al guardar Componente: " + renderErrors(bean: marcoLogicoInstance)
//                    return
//                }
//                render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Componente exitosa."
//                return
            }
        }else{
            marcoLogicoInstance = new MarcoLogico()
            marcoLogicoInstance.properties = params
        }

//        marcoLogicoInstance.properties = params
        if (!marcoLogicoInstance.save(flush: true)) {
            println("error al guardar el marco logico " + marcoLogicoInstance.errors)
            render "ERROR*Ha ocurrido un error al guardar Componente"
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Componente exitosa."


    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un componente
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_marcoLogico_ajax() {
        def tipo = "Componente"
        if (params.tipo == "act") {
            tipo = "Actividad"
        }
        if (request.method == 'POST') {
            if (params.id) {
                def marcoLogicoInstance = MarcoLogico.get(params.id)
                if (!marcoLogicoInstance) {
                    render "ERROR*No se encontró " + tipo
                    return
                }
                try {
                    def control = MarcoLogico.findAllByMarcoLogico(marcoLogicoInstance).size()
                    control += Meta.findAllByMarcoLogico(marcoLogicoInstance).size()
//                    control += Asignacion.findAllByMarcoLogico(marcoLogicoInstance).size()
                    if (control < 1) {
                        def indicadores = Indicador.findAllByMarcoLogico(marcoLogicoInstance)
                        indicadores.each { indi ->
                            MedioVerificacion.findAllByIndicador(indi).each { m ->
                                m.delete(flush: true)
                            }
                            indi.delete(flush: true)
                        }
                        Supuesto.findAllByMarcoLogico(marcoLogicoInstance).each { sup ->
                            sup.delete(flush: true)
                        }

                        marcoLogicoInstance.delete(flush: true)
                        render "SUCCESS*Eliminación de ${tipo} exitosa."
                    } else {
                        if (params.tipo == "comp") {
                            render "ERROR*El componente tiene actividades, metas o asignaciones por lo que no puede ser eliminado"
                        } else {
                            render "ERROR*La actividad tiene metas o asignaciones por lo que no puede ser eliminada"
                        }
                    }
                    return
                } catch (DataIntegrityViolationException e) {
                    render "ERROR*Ha ocurrido un error al eliminar " + tipo
                    return
                }
            } else {
                render "ERROR*No se encontró " + tipo
                return
            }
        } else {
            redirect(controller: "shield", action: "unauthorized")
        }
    }

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar una actividad
     * @return marcoLogicoInstance el objeto a modificar cuando se encontró la actividad
     * @render ERROR*[mensaje] cuando no se encontró la actividad
     */
    def form_actividad_ajax() {
//        println "Form actividad: " + params
        def marcoLogicoInstance = new MarcoLogico()
        def totComp = 0
        def totFin = 0
        def totOtros = 0
        if (params.id) {
            marcoLogicoInstance = MarcoLogico.get(params.id)
            if (!marcoLogicoInstance) {
                render "ERROR*No se encontró Actividad."
                return
            }
        }

        marcoLogicoInstance.properties = params

        if (marcoLogicoInstance.marcoLogico) {
            def marcoLogico = marcoLogicoInstance.marcoLogico
            def actividades = MarcoLogico.findAllByMarcoLogicoAndEstado(marcoLogico, 0, [sort: "id"])
            actividades.each {
                totComp += it.monto
            }
            def proyecto = marcoLogico.proyecto
            Financiamiento.findAllByProyecto(proyecto).each {
                totFin += it.monto
            }
            MarcoLogico.withCriteria {
                eq("tipoElemento", TipoElemento.get(2))
                eq("proyecto", proyecto)
                eq("estado", 0)
                order("id", "asc")
            }.each {
                if (it.id.toLong() != marcoLogico.id.toLong()) {
                    MarcoLogico.findAllByMarcoLogicoAndEstado(it, 0, [sort: "id"]).each { ac ->
                        totOtros += ac.monto
                    }
                }
            }
        }


        totComp = Math.round(totComp * 100) / 100
        totFin = Math.round(totFin * 100) / 100
        totOtros = Math.round(totOtros * 100) / 100

        return [marcoLogicoInstance: marcoLogicoInstance, show: params.show, totComp: totComp, totFin: totFin, totOtros: totOtros]
    }

    /**
     * Acción llamada con ajax que guarda la información de una actividad
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_actividad_ajax() {

        def proyecto = Proyecto.get(params."proyecto.id")
        def marcoLogicoInstance

        if(params.id){

            if(proyecto.fechaRegistro){
                println("con registro")
                marcoLogicoInstance = MarcoLogico.get(params.id)

                def modificacion = new ModificacionMarcoLogico()
                modificacion.marcoLogico = marcoLogicoInstance
                modificacion.objetivo = marcoLogicoInstance.objeto
                modificacion.numero = marcoLogicoInstance.numero
                modificacion.monto = marcoLogicoInstance.monto
                modificacion.fecha = new Date()

                if(!modificacion.save(flush:true)){
                    println("error al guardar la modificacion actividad " + modificacion.errors)
                    render"ERROR*Error al generar la modificación"
                }else{
//                    marcoLogicoInstance.properties = params
                }
            }else{
                marcoLogicoInstance = new MarcoLogico()
                if (params.id) {
                    marcoLogicoInstance = MarcoLogico.get(params.id)
                    if (!marcoLogicoInstance) {
                        render "ERROR*No se encontró Componente."
                        return
                    }
                }
            }
        }else{
            marcoLogicoInstance = new MarcoLogico()
        }

        def maxNum = MarcoLogico.list([sort: "numero", order: "desc", max: 1])
        if (maxNum.size() > 0) {
            maxNum = maxNum?.pop()?.numero
            if (maxNum)
                maxNum = maxNum + 1
        } else {
            maxNum = 1
        }
        marcoLogicoInstance.numero = maxNum


//        if (params.id) {
//            marcoLogicoInstance = MarcoLogico.get(params.id)
//            if (!marcoLogicoInstance) {
//                render "ERROR*No se encontró Actividad."
//                return
//            }
//        } else {
//            def maxNum = MarcoLogico.list([sort: "numero", order: "desc", max: 1])
//            if (maxNum.size() > 0) {
//                maxNum = maxNum?.pop()?.numero
//                if (maxNum)
//                    maxNum = maxNum + 1
//            } else {
//                maxNum = 1
//            }
//            marcoLogicoInstance.numero = maxNum
//        }
//        println "1: " + params
        if (!params.monto) {
            params.monto = 0
        }
        params.monto = params.monto.toString().replaceAll(",", "")
        params.fecha = new Date();
        marcoLogicoInstance.properties = params
        marcoLogicoInstance.monto = params.monto.toDouble()
        if (!marcoLogicoInstance.save(flush: true)) {
            println "Error save actividad: " + marcoLogicoInstance.errors
            render "ERROR*Ha ocurrido un error al guardar Actividad"
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Actividad exitosa."
//        return

    }


    def listaRespaldos(){
        def proy = Proyecto.get(params.id)
        def resp = Respaldo.findAllByProyecto(proy)
        [resp:resp,proy:proy]
    }

    def verRespaldo(){
        def resp = Respaldo.get(params.id)
        def comps = MarcoLogicoRespaldo.findAllByRespaldoAndTipoElemento(resp,TipoElemento.get(2),[sort:"numeroComp"])
        [componentes:comps,resp:resp]

    }

    /**
     * cambiar el número d ela actividad
     */
    def cambiaNumero_ajax() {
//        println "cambiaNumero_ajax: " + params
        def marcoLogicoInstance = new MarcoLogico()
        def totComp = 0
        def totFin = 0
        def totOtros = 0
        if (params.id) {
            marcoLogicoInstance = MarcoLogico.get(params.id)
            if (!marcoLogicoInstance) {
                render "ERROR*No se encontró Actividad."
                return
            }
        }

        return [marcoLogicoInstance: marcoLogicoInstance, show: params.show ]
    }

    def cambiaNumeroActividad() {
//        println "params .... $params"
        def mrlg = MarcoLogico.get(params.id)
        mrlg.numero = params.numero.toInteger()
        mrlg.save(flush: true)
        params.id = mrlg.proyecto.id
        render "SUCCESS*"
    }


    def showMarco = {

        println("params " + params)

        def proyecto = Proyecto.get(params.id)
        if(proyecto.aprobado=="a"){
            response.sendError(403)
        }else{
            def fin = MarcoLogico.findByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Fin"))
            def indicadores
            def medios = []
            def sup
            def indiProps
            def mediosProp = []
            def supProp
            if (proyecto) {
                fin = MarcoLogico.findByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Fin"))
                if (fin) {
                    indicadores =  Indicador.findAllByMarcoLogico(fin).sort{it.descripcion}
                    sup = Supuesto.findAllByMarcoLogico(fin).sort{it.descripcion}
                }
                indicadores.each {
                    medios += MedioVerificacion.findAllByIndicador(it).sort{it.descripcion}
                }

            }
            def proposito = MarcoLogico.findByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Proposito"))
            if (proposito) {
                indiProps = Indicador.findAllByMarcoLogico(proposito).sort{it.descripcion}
                indiProps.each {
                    mediosProp += MedioVerificacion.findAllByIndicador(it).sort{it.descripcion}
                }
                supProp = Supuesto.findAllByMarcoLogico(proposito).sort{it.descripcion}
            }

            [fin: fin, indicadores: indicadores, medios: medios, sup: sup, proyecto: proyecto, proposito: proposito, indiProps: indiProps, mediosProp: mediosProp, supProp: supProp]
        }

    }


    def marcoDialog_ajax(){
        def marco = MarcoLogico.get(params.id)
        return[marco: marco]
    }

    def guardarDatosMarco = {
//        println "gdm " + params
        def proyecto = Proyecto.get(params.proyecto)
        def ml = MarcoLogico.findByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion(params.tipo))
        if (ml) {
            ml.objeto = params.datos
            if (ml.save(flush: true)) {
                render "ok"
            } else {
                println "error al guardar el fin en ml " + ml.errors
                render "no"
            }
        } else {
            ml = new MarcoLogico([proyecto: proyecto, objeto: params.datos, tipoElemento: TipoElemento.findByDescripcion(params.tipo)])
            if (ml.save(flush: true)) {
                render "ok"
            } else {
                println "error al guardar el fin en ml " + ml.errors
                render "no"
            }
        }
    }

    def variosDialog_ajax () {

//        println("--> " + params)

        def objeto

        switch(params.tipo){
            case "1":
                objeto = Indicador.get(params.id)
                return[objeto:objeto]
                break
            case "2":
                objeto = MedioVerificacion.get(params.id)
                return[objeto:objeto]
                break
            case "3":
                objeto = Supuesto.get(params.id)
                return[objeto:objeto]
                break
        }

    }

    def guardarDatosIndMedSup = {
        println "gdims " + params
        switch (params.tipo) {
        /*Inidicadores*/ case "1":
                def indicador
                if (params.id && params.id != "" && params.id != " " && params.id != "0") {
                    indicador = Indicador.get(params.id)
                    indicador.descripcion = params.datos
                } else {
                    indicador = new Indicador([marcoLogico: MarcoLogico.get(params.indicador), descripcion: params.datos])
                }

                indicador.indicadorOrms = IndicadorOrms.get(1);

                if(!indicador.save(flush:true)){
                    println("error al guardar el indicador " + indicador.errors)
                    render "no"
                }else{
                    render indicador.id
                }

//                println " indicador " + indicador.errors.getErrorCount()
//                if (indicador.errors.getErrorCount() != 0) {
//                    render "no"
//                } else {
//                    render indicador.id
//                }
                break;
        /*Medios*/ case "2":
                def medio
                if (params.id && params.id != "" && params.id != " " && params.id != "0") {
                    medio = MedioVerificacion.get(params.id)
                    medio.descripcion = params.datos
                } else {

                    medio = new MedioVerificacion([indicador: Indicador.get(params.indicador), descripcion: params.datos])

                }

                if(!medio.save(flush:true)){
                    println("error al guardar el medio " + medio.errors)
                    render "no"
                }else{
                    render medio.id
                }

//                println " medio " + medio.errors.getErrorCount()
//                if (medio.errors.getErrorCount() != 0) {
//                    render "no"
//                } else {
//                    render medio.id
//                }
                break;
        /*Supuestos*/ case "3":
                def supuesto

                if (params.id && params.id != "" && params.id != " " && params.id != "0") {
                    supuesto = Supuesto.get(params.id)
                    supuesto.descripcion = params.datos
                } else {
                    def marco = MarcoLogico.get(params.indicador)
                    supuesto = new Supuesto([descripcion: params.datos, marcoLogico: marco])

                }

                if(!supuesto.save(flush:true)){
                    println("error al guardar el supuesto " + supuesto.errors)
                    render "no"
                }else{
                    render "" + supuesto.id + "&&" + supuesto.descripcion
                }

//                println " supuesto " + supuesto.errors.getErrorCount()
//                if (supuesto.errors.getErrorCount() != 0) {
//                    render "no"
//                } else {
//                    render "" + supuesto.id + "&&" + supuesto.descripcion
//                }
                break;
        }



    }

    def agregarSupuesto = {
        println "as " + params
        def tp = TipoSupuesto.get(params.id)
        def marco = MarcoLogico.get(params.marco)
        def supuesto = new Supuesto([MarcoLogico: marco, tipo: tp])
        supuesto = kerberosService.saveObject(supuesto, Supuesto, session.perfil, session.usuario, "datosSupuesto", "marcoLogico", session)
        if (supuesto.errors.getErrorCount() != 0) {
            render "no"
        } else {
            render "" + supuesto.id + "&&" + supuesto.descripcion
        }
    }

    def verMarco() {
        def proyecto = Proyecto.get(params.id)
        if(proyecto.aprobado=="a"){
            response.sendError(403)
        }else{
            def fin = MarcoLogico.findByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Fin"))
            def indicadores
            def medios = []
            def sup
            def indiProps
            def mediosProp = []
            def supProp
            if (proyecto) {
                fin = MarcoLogico.findByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Fin"))
                if (fin) {
                    indicadores =  Indicador.findAllByMarcoLogico(fin).sort{it.descripcion}
                    sup = Supuesto.findAllByMarcoLogico(fin).sort{it.descripcion}
                }
                indicadores.each {
                    medios += MedioVerificacion.findAllByIndicador(it).sort{it.descripcion}
                }

            }
            def proposito = MarcoLogico.findByProyectoAndTipoElemento(proyecto, TipoElemento.findByDescripcion("Proposito"))
            if (proposito) {
                indiProps = Indicador.findAllByMarcoLogico(proposito).sort{it.descripcion}
                indiProps.each {
                    mediosProp += MedioVerificacion.findAllByIndicador(it).sort{it.descripcion}
                }
                supProp = Supuesto.findAllByMarcoLogico(proposito).sort{it.descripcion}
            }

            [fin: fin, indicadores: indicadores, medios: medios, sup: sup, proyecto: proyecto, proposito: proposito, indiProps: indiProps, mediosProp: mediosProp, supProp: supProp]
        }
    }



    def eliminarMarco () {

//        println("params elm " + params)

        def errores = ''
        def ml = MarcoLogico.get(params.id)
        def indicadores = Indicador.findAllByMarcoLogico(ml)

        if(indicadores){
            def medios = MedioVerificacion.findAllByIndicadorInList(indicadores)

            if(medios){
                medios.each {m->
                    if(!m.delete(flush:true)){
                        errores += m.errors
                    }
                }
            }

            indicadores.each {i->
                if(!i.delete(flush:true)){
                    errores += i.errors
                }
            }
        }

        def supuestos = Supuesto.findAllByMarcoLogico(ml)

        supuestos.each {s->
            if(!s.delete(flush:true)){
                errores += s.errors
            }
        }

        try{
            ml.delete(flush: true)
            render"ok"
        }catch(e){
            println("error al borrar el marco logico " + e + errores)
            render "no"
        }
    }

    def eliminarVarios(){
//        println("params elv " + params)
        def errores = ''
        switch(params.tipo){
            case "1":
                def indicador = Indicador.get(params.id)
                def medios = MedioVerificacion.findAllByIndicador(indicador)

                if(medios){
                    medios.each {m->
                        if(!m.delete(flush:true)){
                            errores += m.errors
                        }
                    }
                }

                try{
                    indicador.delete(flush: true)
                    render"ok"
                }catch(e){
                    println("error al borrar el indicador " + e + errores)
                    render "no"
                }
                break
            case "2":
                def medio = MedioVerificacion.get(params.id)

                try{
                    medio.delete(flush: true)
                    render"ok"
                }catch(e){
                    println("error al borrar el medio de verificacion  " + e)
                    render "no"
                }

                break
            case "3":
                def supuesto = Supuesto.get(params.id)

                try{
                    supuesto.delete(flush: true)
                    render"ok"
                }catch(e){
                    println("error al borrar el supuesto  " + e)
                    render "no"
                }
                break
        }
    }

}
