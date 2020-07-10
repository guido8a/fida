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
        if(prtlInstance.comunidad) {
            lugar = "${prtlInstance.comunidad.nombre} Parr: ${prtlInstance.parroquia.nombre} " +
                    "(${prtlInstance.parroquia.canton.provincia.nombre})"
        }
        return [prtlInstance: prtlInstance, lugar: lugar]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def taller
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
                taller = Taller.get(params.id)
                texto = "Taller actualizada correctamente"
            }else{
                taller = new Taller()
                texto = "Taller creado correctamente"
            }

            taller.properties = params
            taller.fecha = new Date()
            taller.valor = params.valor.toDouble()
            taller.parroquia = parroquia
            taller.comunidad = cmnd

            if(!taller.save(flush:true)){
                println "Error en save de taller ejecutora\n" + taller.errors
                render "no*Error al guardar la taller"
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
                def path = servletContext.getRealPath("/") + "prsnTallersProyecto/" + prtlInstance.prsnTaller
                prtlInstance.delete(flush: true)
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
