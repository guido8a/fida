package convenio

import convenio.Avance
import org.springframework.dao.DataIntegrityViolationException
import planes.DetalleEvaluacion
import planes.Evaluacion
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
        def sql = "select comp__id, substr(compdscr,1,20), actv__id, actvdscr, plan__id, plandscr, plancntd, " +
                "plancsto, planejec, planetdo from planes(1,1)"
        println("sql " + sql)
        def cn = dbConnectionService.getConnection()
        def evaluacion = Evaluacion.get(params.eval)
        def detalle = DetalleEvaluacion.countByEvaluacion(evaluacion)
        def data

        if(detalle) {
            sql = "select dtev__id id, inpn.inpn__id, inpn.inor__id, inpn.plns__id, inordscr, dtevvlor original, " +
                    " dtevobsr obsr from dtev, inpn, inor where eval__id = ${evaluacion.id} and " +
                    "inpn.inpn__id = dtev.inpn__id and inor.inor__id = inpn.inor__id order by inor__id"
        }
        println "sql: $sql"
        data = cn.rows(sql.toString())

//        def par = [oblg:7, controller:'vivienda', format:null, action:'tabla']
        [indicadores: data, plns: params.plns, eval: params.eval, band: false, cuenta: detalle]
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

}
