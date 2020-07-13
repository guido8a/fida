package taller

import geografia.Canton
import geografia.Comunidad
import geografia.Parroquia
import grails.validation.ValidationException
import org.springframework.dao.DataIntegrityViolationException
import taller.Taller
import proyectos.Proyecto

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

import static java.awt.RenderingHints.KEY_INTERPOLATION
import static java.awt.RenderingHints.VALUE_INTERPOLATION_BICUBIC
import static org.springframework.http.HttpStatus.*

class TallerController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    /**
     * Acción llamada con ajax que muestra y permite modificar los tallers de un proyecto
     */
    def listTaller() {
        def proyecto = Proyecto.get(1)
        return [proyecto: proyecto]
    }

    /**
     * Acción llamada con ajax que llena la tabla de los tallers de un proyecto
     */
    def tablaTaller_ajax() {
        def taller = Taller.withCriteria {
            if (params.search && params.search != "") {
                or {
                    ilike("nombre", "%" + params.search + "%")
                    ilike("objetivo", "%" + params.search + "%")
                }
            }
            order("nombre", "asc")
        }
        return [taller: taller]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return tallerInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        println "show_ajax: $params"
        if (params.id) {
            def tallerInstance = Taller.get(params.id)
            if (!tallerInstance) {
                render "ERROR*No se encontró Taller."
                return
            }
//            println ".... show_ajax ${tallerInstance?.proyecto.nombre}"
            return [tallerInstance: tallerInstance]
        } else {
            render "ERROR*No se encontró Taller."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return tallerInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formTaller_ajax() {
        println "formTaller_ajax: $params"
        def lugar = ""
        def tallerInstance = new Taller()
        if (params.id) {
            tallerInstance = Taller.get(params.id)
            if (!tallerInstance) {
//                render "ERROR*No se encontró Taller."
//                return
                tallerInstance = new Taller()
            }
        }
//        tallerInstance.properties = params
//        if(tallerInstance.comunidad) {
//            lugar = "${tallerInstance.comunidad.nombre} Parr: ${tallerInstance.parroquia.nombre} " +
//                    "(${tallerInstance.parroquia.canton.provincia.nombre})"

        if(tallerInstance?.parroquia){
            lugar = "${tallerInstance.parroquia.nombre} " +
                    "(${tallerInstance.parroquia.canton.provincia.nombre})"
        }

//        }
        return [tallerInstance: tallerInstance, lugar: lugar]
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
            def tallerInstance = Taller.get(params.id)
            if (!tallerInstance) {
                render "ERROR*No se encontró Taller."
                return
            }
            try {
                def path = servletContext.getRealPath("/") + "tallersProyecto/" + tallerInstance.taller
                tallerInstance.delete(flush: true)
                println path
                def f = new File(path)
                println f.delete()
                render "SUCCESS*Eliminación de Taller exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Taller"
                return
            }
        } else {
            render "ERROR*No se encontró Taller."
            return
        }
    } //delete para eliminar via ajax

    def comunidad_ajax(){
        def parroquia = Parroquia.get(params.id)
        def cantones = Comunidad.findAllByParroquia(parroquia)
        def taller
        if(params.tipo == '3'){
            taller = PersonaTaller.get(params.taller)
        }else{
           taller = Taller.get(params.taller)
        }
        return [cantones: cantones, taller: taller]
    }

}
