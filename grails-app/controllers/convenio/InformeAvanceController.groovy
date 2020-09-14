package convenio

import convenio.InformeAvance
import org.springframework.dao.DataIntegrityViolationException
import seguridad.UnidadEjecutora

class InformeAvanceController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    /**
     * Acción llamada con ajax que muestra y permite modificar los tallers de un proyecto
     */
    def informe() {
        def convenio = Convenio.get(params.id)
        return [convenio: convenio]
    }

    /**
     * Acción llamada con ajax que llena la tabla de los tallers de un proyecto
     */
    def tablaInforme_ajax() {
        println "tablaInforme_ajax $params"
        def convenio = Convenio.get(params.id)
        def administrador = AdministradorConvenio.findByConvenioAndFechaFinIsNull(convenio)
        def informe = InformeAvance.withCriteria {
            eq("administradorConvenio", administrador)
            if (params.search && params.search != "") {
                or {
                    ilike("informeAvance", "%" + params.search + "%")
//                    ilike("objetivo", "%" + params.search + "%")
                }
            }
            order("informeAvance", "asc")
        }
        return [informe: informe]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return infoInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
//        println "show_ajax: $params"
        if (params.id) {
            def infoInstance = InformeAvance.get(params.id)
            if (!infoInstance) {
                render "ERROR*No se encontró InformeAvance."
                return
            }
//            println ".... show_ajax ${infoInstance?.nombre}"
            return [infoInstance: infoInstance]
        } else {
            render "ERROR*No se encontró InformeAvance."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return infoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formInforme_ajax() {
        println "formInforme_ajax: $params"
        def convenio = Convenio.get(params.convenio)
        def infoInstance = new InformeAvance()
        def desembolso = Desembolso.findAllByConvenio(convenio)
        def administrador = AdministradorConvenio.findAllByConvenio(convenio)
        if (params.id) {
            infoInstance = InformeAvance.get(params.id)
            if (!infoInstance) {
                infoInstance = new InformeAvance()
            }
        }

        println "convenio: ${convenio}, admn: ${administrador}"
        return [infoInstance: infoInstance, convenio: convenio, administrador: administrador, desembolso: desembolso]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        println "informe save_ajax: $params"
        def informe
        def texto
        def validaInformes = true

        if(validaInformes){

            params.fecha = params.fecha ? new Date().parse("dd-MM-yyyy", params.fecha) : null

            if(params.id){
                informe = InformeAvance.get(params.id)
                texto = "InformeAvance actualizada correctamente"
            }else{
                informe = new InformeAvance()
                texto = "InformeAvance creado correctamente"
            }

            informe.properties = params
            informe.porcentaje = params.porcentaje.toDouble()

            println "informe: ${informe.properties}"

            if(!informe.save(flush:true)){
                println "Error en save de informe ejecutora\n" + informe.errors
                render "no*Error al guardar la informe"
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
            def infoInstance = InformeAvance.get(params.id)
            if (!infoInstance) {
                render "ERROR*No se encontró InformeAvance."
                return
            }
            try {
                def path = servletContext.getRealPath("/") + "tallersProyecto/" + infoInstance.informe
                infoInstance.delete(flush: true)
                println path
                def f = new File(path)
                println f.delete()
                render "SUCCESS*Eliminación de InformeAvance exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar InformeAvance"
                return
            }
        } else {
            render "ERROR*No se encontró InformeAvance."
            return
        }
    } //delete para eliminar via ajax

}
