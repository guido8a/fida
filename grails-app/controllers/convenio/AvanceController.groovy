package convenio

import convenio.Avance
import org.springframework.dao.DataIntegrityViolationException
import planes.DetalleEvaluacion
import planes.Evaluacion
import planes.IndicadorPlan
import seguridad.UnidadEjecutora

class AvanceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def dbConnectionService

    /**
     * Acción llamada con ajax que muestra y permite modificar los tallers de un proyecto
     */
    def detalle() {
        println "detalle: $params"
        def informe = InformeAvance.get(params.id)
        return [informe: informe]
    }

    /* de cada actividad planificada mostrar cantida e inversión organizado por componente */
    def tabla() {
        println "tabla " + params
        def sql = "select * from avance(${params.info})"
        println("sql " + sql)

        def cn = dbConnectionService.getConnection()
        def data = cn.rows(sql.toString())

//        def par = [oblg:7, controller:'vivienda', format:null, action:'tabla']
        [avance: data, informe: params.info]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return dsmbInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
//        println "show_ajax: $params"
        if (params.id) {
            def dsmbInstance = Avance.get(params.id)
            if (!dsmbInstance) {
                render "ERROR*No se encontró Avance."
                return
            }
//            println ".... show_ajax ${dsmbInstance?.nombre}"
            return [dsmbInstance: dsmbInstance]
        } else {
            render "ERROR*No se encontró Avance."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return dsmbInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formAvance_ajax() {
        println "formAvance_ajax: $params"
        def convenio = Convenio.get(params.convenio)
        def vigente = EstadoGarantia.get(1)
        def dsmbInstance = new Avance()
        def garantias = Garantia.findAllByConvenioAndEstado(convenio, vigente, [sort: 'fechaInicio', order: 'desc'])
        if (params.id) {
            dsmbInstance = Avance.get(params.id)
            if (!dsmbInstance) {
                dsmbInstance = new Avance()
            }
        }

        println "convenio: ${convenio}, garantías: ${garantias}"
        return [dsmbInstance: dsmbInstance, convenio: convenio, garantias: garantias]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        println "save_ajax: $params"
        def avance
        def texto
        def cmnd = null
        def validaAvances = true
        if(validaAvances){

            params.fecha = params.fecha ? new Date().parse("dd-MM-yyyy", params.fecha) : null

            if(params.id){
                avance = Avance.get(params.id)
                texto = "Avance actualizada correctamente"
            }else{
                avance = new Avance()
                texto = "Avance creado correctamente"
            }

            params.cur = params.cur.toString().toUpperCase()
            avance.properties = params
            avance.valor = params.valor.toDouble()

            println "avance: ${avance.properties}"

            if(!avance.save(flush:true)){
                println "Error en save de avance ejecutora\n" + avance.errors
                render "no*Error al guardar la avance"
            }else{
                render "SUCCESS*" + texto
            }
        }else{
            render "er*Validacion de desemboplsos"
        }
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def dsmbInstance = Avance.get(params.id)
            if (!dsmbInstance) {
                render "ERROR*No se encontró Avance."
                return
            }
            try {
                def path = servletContext.getRealPath("/") + "tallersProyecto/" + dsmbInstance.avance
                dsmbInstance.delete(flush: true)
                println path
                def f = new File(path)
                println f.delete()
                render "SUCCESS*Eliminación de Avance exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Avance"
                return
            }
        } else {
            render "ERROR*No se encontró Avance."
            return
        }
    } //delete para eliminar via ajax


    def actualizar() {
        println "actualizar AV: $params"

        if (params.item instanceof java.lang.String) {
            params.item = [params.item]
        }
        if (params.obsr instanceof java.lang.String) {
            params.obsr = [params.obsr]
        }

        def oks = "", nos = ""

        def info = InformeAvance.get(params.info)

        println "info: ${info.informeAvance}"

        if(params.item) {
            params.item.each {
                def parts = it.split("_")

                def plan = parts[0]
                def valor  = parts[1].toDouble()
                def obsr = null
                if(it.contains('_ob')) {
                    obsr   = parts[3]
                    if(obsr.size() > 2) {
                        obsr = obsr[2..-1]
                    } else {
                        obsr = null
                    }
                }

                println "info: ${params.info}, plan: $plan, valor: $valor, obsr: $obsr"

                /* consultar si hay que actualizar DTEV */
                def evaluacion = Evaluacion.get(params.eval);
                def planificacion = Plan.get(plan);
                def avance = convenio.Avance.findByInformeAvanceAndPlan(info, planificacion)

                println "evaluacion: ${evaluacion?.id}, informe: ${info.id} plan: ${planificacion.id}"

                if(!avance) {
                    avance = new Avance()
                    avance.informeAvance = info
                    avance.plan = planificacion
                }
                avance.valor = valor
                avance.descripcion = obsr

//                if (!avance.save(flush: true)) {
//                    println "error $parts, --> ${avance.errors}"
//                    if (nos != "") {
//                        nos += ","
//                    }
//                    nos += "#" + plan
//                } else {
//                    if (oks != "") {
//                        oks += ","
//                    }
//                    oks += "#" + plan
//                }
            }
        }
        println "--> ${oks}"
        render oks + "_" + nos
    }

    def formValores_ajax (){

        def info = InformeAvance.get(params.informe)
        def planificacion = Plan.get(params.plan)
        def avance = Avance.findByInformeAvanceAndPlan(info, planificacion)

        return [avance: avance, informe: info, plan: planificacion]
    }

    def saveValores_ajax() {

        def avance

        if(params.id){
            avance = Avance.get(params.id)
        }else{
            avance = new Avance()
        }
        avance.properties = params

        if(!avance.save(flush: true)){
            render "no"
            println("error al guardar los valores del avance " + avance.errors)
        }else{
            render "ok"
        }
    }

}
