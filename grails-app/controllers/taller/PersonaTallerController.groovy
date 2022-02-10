package taller

import geografia.Comunidad
import geografia.Parroquia
import grails.validation.ValidationException
import org.springframework.dao.DataIntegrityViolationException
import proyectos.Proyecto

import static org.springframework.http.HttpStatus.*

class PersonaTallerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /**
     * Acción llamada con ajax que muestra y permite modificar los prsnTallers de un proyecto
     */
    def listPrtl() {
//        println "listPrtl--> $params"
        def taller = Taller.get(params.id)
        return [taller: taller,unidad: taller.unidadEjecutora]
    }

    /**
     * Acción llamada con ajax que llena la tabla de los prsnTallers de un proyecto
     */
    def tablaPrtl_ajax() {
        def taller = Taller.get(params.id)
        def prsnTaller = PersonaTaller.withCriteria {
            eq("taller",taller)
            if (params.search && params.search != "") {
                or {
                    ilike("nombre", "%" + params.search + "%")
                    ilike("apellido", "%" + params.search + "%")
                }
            }
            order("nombre", "asc")
        }
        return [prsnTaller: prsnTaller]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return prtlInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        println "show_ajax: $params"
        if (params.id) {
            def prtlInstance = PersonaTaller.get(params.id)
            if (!prtlInstance) {
                render "ERROR*No se encontró PersonaTaller."
                return
            }
//            println ".... show_ajax ${prtlInstance?.proyecto.nombre}"
            return [prtlInstance: prtlInstance]
        } else {
            render "ERROR*No se encontró PersonaTaller."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return prtlInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formPersonaTaller_ajax() {
        println "formPersonaTaller_ajax: $params"
        def taller = Taller.get(params.taller)
        def lugar = ""
        def prtlInstance = new PersonaTaller()
        if (params.id) {
            prtlInstance = PersonaTaller.get(params.id)
            if (!prtlInstance) {
//                render "ERROR*No se encontró PersonaTaller."
//                return
                prtlInstance = new PersonaTaller()
            }
        }
        prtlInstance.properties = params
        if(prtlInstance?.parroquia){
            lugar = "${prtlInstance.parroquia.nombre} " +
                    "(${prtlInstance.parroquia.canton.provincia.nombre})"
        }

        return [prtlInstance: prtlInstance, lugar: lugar, taller: taller]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def personaTaller
        def texto
        def cmnd = null

        if(params.parroquia){
            def parroquia = Parroquia.get(params.parroquia)

            if(params.comunidad != "null"){
                cmnd = Comunidad.get(params.comunidad.toInteger())
            }

            params.fechaInicio = params.fechaInicio ? new Date().parse("dd-MM-yyyy", params.fechaInicio) : null
            params.fechaFin = params.fechaFin ? new Date().parse("dd-MM-yyyy", params.fechaFin) : null

            if(params.id){
                personaTaller = PersonaTaller.get(params.id)
                texto = "Persona actualizada correctamente"
            }else{
                personaTaller = new PersonaTaller()
                texto = "Persona creada correctamente"
            }

            if(!params.edad){
                params.edad = 0
            }

            personaTaller.properties = params
            personaTaller.fecha = new Date()
            personaTaller.parroquia = parroquia
            personaTaller.comunidad = cmnd

            if(!personaTaller.save(flush:true)){
                println "Error en save de persona taller\n" + personaTaller.errors
                render "no*Error al guardar la persona"
            }else{
                render "SUCCESS*" + texto
            }
        }else{
            render "er*Seleccione una parroquia!"
        }
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def prtlInstance = PersonaTaller.get(params.id)
            if (!prtlInstance) {
                render "ERROR*No se encontró PersonaTaller."
                return
            }
            try {
                prtlInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Persona del taller exitosa."
            } catch (DataIntegrityViolationException e) {
                println("error al borrar la persona del taller " + e)
                render "ERROR*Ha ocurrido un error al eliminar PersonaTaller"
            }
        } else {
            render "ERROR*No se encontró PersonaTaller."
        }
    } //delete para eliminar via ajax


}
