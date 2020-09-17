package preguntas

import org.springframework.dao.DataIntegrityViolationException
import proyectos.Indicador
import proyectos.MarcoLogico
import proyectos.Proyecto

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
        def pregunta = Pregunta.withCriteria {
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
     * @return pregInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
//        println "show_ajax: $params"
        if (params.id) {
            def pregInstance = Pregunta.get(params.id)
            if (!pregInstance) {
                render "ERROR*No se encontró Pregunta."
                return
            }
//            println ".... show_ajax ${pregInstance?.nombre}"
            return [pregInstance: pregInstance]
        } else {
            render "ERROR*No se encontró Pregunta."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return pregInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formPregunta_ajax() {
        println "formPregunta_ajax: $params"
        def proy = Proyecto.get(1)
        def tpel = parametros.proyectos.TipoElemento.get(4)
        def mrlg = MarcoLogico.findAllByProyectoAndTipoElemento(proy, tpel)
        def pregInstance = new Pregunta()
        def indicador = Indicador.findAllByMarcoLogico(mrlg, [sort: 'descripcion'])
        if (params.id) {
            pregInstance = Pregunta.get(params.id)
            if (!pregInstance) {
                pregInstance = new Pregunta()
            }
        }

        println "indicador: ${indicador?.size()}"
        return [pregInstance: pregInstance, marcoLogico: mrlg, indicadores: indicador]
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
//    def delete_ajax() {
//        if (params.id) {
//            def pregInstance = Pregunta.get(params.id)
//            if (!pregInstance) {
//                render "ERROR*No se encontró Pregunta."
//                return
//            }
//            try {
//                def path = servletContext.getRealPath("/") + "tallersProyecto/" + pregInstance.pregunta
//                pregInstance.delete(flush: true)
//                println path
//                def f = new File(path)
//                println f.delete()
//                render "SUCCESS*Eliminación de Pregunta exitosa."
//                return
//            } catch (DataIntegrityViolationException e) {
//                render "ERROR*Ha ocurrido un error al eliminar Pregunta"
//                return
//            }
//        } else {
//            render "ERROR*No se encontró Pregunta."
//            return
//        }
//    } //delete para eliminar via ajax


    def borrarPregunta_ajax(){
        if(params.id){
            def pregunta = Pregunta.get(params.id)
            def respuestaExiste = RespuestaPregunta.findAllByPregunta(pregunta)

            if(respuestaExiste){
             render "er"
            }else{
                try{
                   pregunta.delete(flush:true)
                    render "ok"
                }catch(e){
                    println("Error al borrar la pregunta " + pregunta.errors)
                    render "no"
                }
            }
        }else{
            render "no"
        }
    }

//    def indicador_ajax(){
////        println("params indi " + params)
//        def pregunta = Pregunta.get(params.id)
//        def actividad = MarcoLogico.get(params.marco)
//        def indicadores = Indicador.findAllByMarcoLogico(actividad, [sort: 'descripcion'])
//        return[indicadores:indicadores, pregunta: pregunta]
//    }

    def respuestas_ajax(){
        def pregunta = Pregunta.get(params.id)
        return[pregunta:pregunta]
    }

    def tablaRespuesta_ajax(){
        def pregunta = Pregunta.get(params.id)
        def respuestas = RespuestaPregunta.findAllByPregunta(pregunta).sort{it.respuesta}
        return[respuestas: respuestas]
    }

    def borrarRespuestaSeleccionada_ajax(){
        def respuesta = RespuestaPregunta.get(params.id)

        try{
            respuesta.delete(flush:true)
            render"ok"
        }catch(e){
            println("error al borrar la respuesta seleccionada " + respuesta.errors)
        }
    }

    def agregarRespuestaSeleccionada_ajax(){
        def pregunta = Pregunta.get(params.id)
        def respuesta = Respuesta.get(params.respuesta)

        def existe = RespuestaPregunta.findAllByPreguntaAndRespuesta(pregunta, respuesta)

        if(existe){
            render "er"
        }else{
            def respuestaSel = new RespuestaPregunta()
            respuestaSel.respuesta = respuesta
            respuestaSel.pregunta = pregunta

            if(!respuestaSel.save(flush:true)){
                println("Error al guardar la respuesta" + respuestaSel.errors)
                render "no"
            }else{
                render "ok"
            }
        }

    }


}
