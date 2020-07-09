package taller

import geografia.Comunidad
import grails.validation.ValidationException
import org.springframework.dao.DataIntegrityViolationException
import proyectos.Proyecto

import static org.springframework.http.HttpStatus.*

class PersonaTallerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return prsnTallerInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formPrsnTaller_ajax() {
        def prsnTaller = prsnTallerEjecutora.get(params.prsnTaller.toLong())
        def prsnTallerInstance = new PersonaTaller()
        if (params.id) {
            prsnTallerInstance = PersonaTaller.get(params.id)
            if (!prsnTallerInstance) {
//                render "ERROR*No se encontró PersonaTaller."
//                return
                prsnTallerInstance = new PersonaTaller()
            }
        }
        prsnTallerInstance.properties = params
        prsnTallerInstance.prsnTallerEjecutora = prsnTaller
        return [prsnTallerInstance: prsnTallerInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra y permite modificar los prsnTallers de un proyecto
     */
    def listPrtl() {
        println "listPrtl--> $params"
        def taller = Taller.get(params.id)
        return [taller: taller]
    }

    /**
     * Acción llamada con ajax que llena la tabla de los prsnTallers de un proyecto
     */
    def tablaPrtl_ajax() {
        def prsnTaller = PersonaTaller.withCriteria {
            if (params.search && params.search != "") {
                or {
                    ilike("nombre", "%" + params.search + "%")
                    ilike("objetivo", "%" + params.search + "%")
                }
            }
            order("nombre", "asc")
        }
        return [prsnTaller: prsnTaller]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return prsnTallerInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        println "show_ajax: $params"
        if (params.id) {
            def prsnTallerInstance = PersonaTaller.get(params.id)
            if (!prsnTallerInstance) {
                render "ERROR*No se encontró PersonaTaller."
                return
            }
//            println ".... show_ajax ${prsnTallerInstance?.proyecto.nombre}"
            return [prsnTallerInstance: prsnTallerInstance]
        } else {
            render "ERROR*No se encontró PersonaTaller."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return prsnTallerInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formPersonaTaller_ajax() {
        println "formPersonaTaller_ajax: $params"
        def lugar = ""
        def prsnTallerInstance = new PersonaTaller()
        if (params.id) {
            prsnTallerInstance = PersonaTaller.get(params.id)
            if (!prsnTallerInstance) {
//                render "ERROR*No se encontró PersonaTaller."
//                return
                prsnTallerInstance = new PersonaTaller()
            }
        }
        prsnTallerInstance.properties = params
        if(prsnTallerInstance.comunidad) {
            lugar = "${prsnTallerInstance.comunidad.nombre} Parr: ${prsnTallerInstance.parroquia.nombre} " +
                    "(${prsnTallerInstance.parroquia.canton.provincia.nombre})"
        }
        return [prsnTallerInstance: prsnTallerInstance, lugar: lugar]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def prsnTaller
        def texto
        def cmnd = Comunidad.get(params.comunidad.toInteger())

        params.fechaInicio = params.fechaInicio ? new Date().parse("dd-MM-yyyy", params.fechaInicio) : null
        params.fechaFin = params.fechaFin ? new Date().parse("dd-MM-yyyy", params.fechaFin) : null

        if(params.id){
            prsnTaller = PersonaTaller.get(params.id)
            texto = "prsnTaller actualizada correctamente"
        }else{
            prsnTaller = new PersonaTaller()
            texto = "prsnTaller creada correctamente"
        }

        prsnTaller.properties = params
        prsnTaller.fecha = new Date()
        prsnTaller.valor = params.valor.toDouble()
        println "Comunidad --> ${cmnd.nombre}, ${cmnd.parroquia.id}"
        prsnTaller.parroquia = cmnd.parroquia

        if(!prsnTaller.save(flush:true)){
            println "Error en save de prsnTaller ejecutora\n" + prsnTaller.errors
            render "no*Error al guardar la prsnTaller"
        }else{
            render "SUCCESS*" + texto
        }

    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def prsnTallerInstance = PersonaTaller.get(params.id)
            if (!prsnTallerInstance) {
                render "ERROR*No se encontró PersonaTaller."
                return
            }
            try {
                def path = servletContext.getRealPath("/") + "prsnTallersProyecto/" + prsnTallerInstance.prsnTaller
                prsnTallerInstance.delete(flush: true)
                println path
                def f = new File(path)
                println f.delete()
                render "SUCCESS*Eliminación de PersonaTaller exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar PersonaTaller"
                return
            }
        } else {
            render "ERROR*No se encontró PersonaTaller."
            return
        }
    } //delete para eliminar via ajax


}
