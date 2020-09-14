package convenio


import geografia.Comunidad
import geografia.Parroquia
import org.springframework.dao.DataIntegrityViolationException
import seguridad.UnidadEjecutora
import convenio.Desembolso
import taller.Taller

class DesembolsoController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    /**
     * Acción llamada con ajax que muestra y permite modificar los tallers de un proyecto
     */
    def desembolso() {
        def convenio = Convenio.get(params.id)
        return [convenio: convenio]
    }

    /**
     * Acción llamada con ajax que llena la tabla de los tallers de un proyecto
     */
    def tablaDesembolso_ajax() {
        println "tablaDesembolso_ajax $params"
        def convenio = UnidadEjecutora.get(params.id)
        def desembolso = Desembolso.withCriteria {
            eq("convenio", convenio)
            if (params.search && params.search != "") {
                or {
                    ilike("descripcion", "%" + params.search + "%")
//                    ilike("objetivo", "%" + params.search + "%")
                }
            }
            order("descripcion", "asc")
        }
        return [desembolso: desembolso]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return dsmbInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
//        println "show_ajax: $params"
        if (params.id) {
            def dsmbInstance = Desembolso.get(params.id)
            if (!dsmbInstance) {
                render "ERROR*No se encontró Desembolso."
                return
            }
//            println ".... show_ajax ${dsmbInstance?.nombre}"
            return [dsmbInstance: dsmbInstance]
        } else {
            render "ERROR*No se encontró Desembolso."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return dsmbInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formDesembolso_ajax() {
        println "formDesembolso_ajax: $params"
        def convenio = Convenio.get(params.convenio)
        def dsmbInstance = new Desembolso()
        def garantias = Garantia.findAllByConvenio(convenio, [sort: 'fechaInicio', order: 'desc'])
        if (params.id) {
            dsmbInstance = Desembolso.get(params.id)
            if (!dsmbInstance) {
                dsmbInstance = new Desembolso()
            }
        }

        println "convenio: ${convenio}"
        return [dsmbInstance: dsmbInstance, convenio: convenio, garantias: garantias]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        println "save_ajax: $params"
        def desembolso
        def texto
        def cmnd = null
        def validaDesembolsos = true
        if(validaDesembolsos){

            params.fecha = params.fecha ? new Date().parse("dd-MM-yyyy", params.fecha) : null

            if(params.id){
                desembolso = Desembolso.get(params.id)
                texto = "Desembolso actualizada correctamente"
            }else{
                desembolso = new Desembolso()
                texto = "Desembolso creado correctamente"
            }

            params.cur = params.cur.toString().toUpperCase()
            desembolso.properties = params
            desembolso.valor = params.valor.toDouble()

            println "desembolso: ${desembolso.properties}"

            if(!desembolso.save(flush:true)){
                println "Error en save de desembolso ejecutora\n" + desembolso.errors
                render "no*Error al guardar la desembolso"
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
            def dsmbInstance = Desembolso.get(params.id)
            if (!dsmbInstance) {
                render "ERROR*No se encontró Desembolso."
                return
            }
            try {
                def path = servletContext.getRealPath("/") + "tallersProyecto/" + dsmbInstance.desembolso
                dsmbInstance.delete(flush: true)
                println path
                def f = new File(path)
                println f.delete()
                render "SUCCESS*Eliminación de Desembolso exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Desembolso"
                return
            }
        } else {
            render "ERROR*No se encontró Desembolso."
            return
        }
    } //delete para eliminar via ajax

}