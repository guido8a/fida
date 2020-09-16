package preguntas

import convenio.*
import org.springframework.dao.DataIntegrityViolationException
import seguridad.UnidadEjecutora

class PreguntaController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]


    /**
     * Acción llamada con ajax que muestra y permite modificar los tallers de un proyecto
     */
    def pregunta() {
        def pregunta = Pregunta.get(1)
        return [pregunta: pregunta]
    }

    /**
     * Acción llamada con ajax que llena la tabla de los tallers de un proyecto
     */
    def tablaPregunta_ajax() {
        println "tablaPregunta_ajax $params"
        def convenio = UnidadEjecutora.get(params.id)
        def pregunta = Pregunta.withCriteria {
            eq("convenio", convenio)
            if (params.search && params.search != "") {
                or {
                    ilike("descripcion", "%" + params.search + "%")
//                    ilike("objetivo", "%" + params.search + "%")
                }
            }
            order("descripcion", "asc")
        }
        return [pregunta: pregunta]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return dsmbInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
//        println "show_ajax: $params"
        if (params.id) {
            def dsmbInstance = Pregunta.get(params.id)
            if (!dsmbInstance) {
                render "ERROR*No se encontró Pregunta."
                return
            }
//            println ".... show_ajax ${dsmbInstance?.nombre}"
            return [dsmbInstance: dsmbInstance]
        } else {
            render "ERROR*No se encontró Pregunta."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return dsmbInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formPregunta_ajax() {
        println "formPregunta_ajax: $params"
        def convenio = Convenio.get(params.convenio)
        def vigente = EstadoGarantia.get(1)
        def dsmbInstance = new Pregunta()
        def garantias = Garantia.findAllByConvenioAndEstado(convenio, vigente, [sort: 'fechaInicio', order: 'desc'])
        if (params.id) {
            dsmbInstance = Pregunta.get(params.id)
            if (!dsmbInstance) {
                dsmbInstance = new Pregunta()
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
        def pregunta
        def texto
        def cmnd = null
        def validaPreguntas = true
        if(validaPreguntas){

            params.fecha = params.fecha ? new Date().parse("dd-MM-yyyy", params.fecha) : null

            if(params.id){
                pregunta = Pregunta.get(params.id)
                texto = "Pregunta actualizada correctamente"
            }else{
                pregunta = new Pregunta()
                texto = "Pregunta creado correctamente"
            }

            params.cur = params.cur.toString().toUpperCase()
            pregunta.properties = params
            pregunta.valor = params.valor.toDouble()

            println "pregunta: ${pregunta.properties}"

            if(!pregunta.save(flush:true)){
                println "Error en save de pregunta ejecutora\n" + pregunta.errors
                render "no*Error al guardar la pregunta"
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
            def dsmbInstance = Pregunta.get(params.id)
            if (!dsmbInstance) {
                render "ERROR*No se encontró Pregunta."
                return
            }
            try {
                def path = servletContext.getRealPath("/") + "tallersProyecto/" + dsmbInstance.pregunta
                dsmbInstance.delete(flush: true)
                println path
                def f = new File(path)
                println f.delete()
                render "SUCCESS*Eliminación de Pregunta exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Pregunta"
                return
            }
        } else {
            render "ERROR*No se encontró Pregunta."
            return
        }
    } //delete para eliminar via ajax


    def borrarPregunta_ajax(){
        if(params.id){
            def pregunta = Pregunta.get(params.id)
            def infoExiste = InformeAvance.findAllByPregunta(pregunta)

            if(infoExiste){
             render "er"
            }else{
                try{
                   pregunta.delete(flush:true)
                    render "ok"
                }catch(e){
                    println("Error al borrar el pregunta " + pregunta.errors)
                    render "no"
                }
            }
        }else{
            render "no"
        }
    }


}
