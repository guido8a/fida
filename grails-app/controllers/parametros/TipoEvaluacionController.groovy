package parametros


import org.springframework.dao.DataIntegrityViolationException
import parametros.convenios.TipoEvaluacion

class TipoEvaluacionController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /**
     * Acción que redirecciona a la lista (acción "list")
     */
    def index() {
        redirect(action: "list", params: params)
    }

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    def getList(params, all) {
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = TipoEvaluacion.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = TipoEvaluacion.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return tipoEvaluacionInstanceList: la lista de elementos filtrados, tipoEvaluacionInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def tipoEvaluacionInstanceList = getList(params, false)
        def tipoEvaluacionInstanceCount = getList(params, true).size()
        return [tipoEvaluacionInstanceList: tipoEvaluacionInstanceList, tipoEvaluacionInstanceCount: tipoEvaluacionInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return tipoEvaluacionInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def tipoEvaluacionInstance = TipoEvaluacion.get(params.id)
            if (!tipoEvaluacionInstance) {
                render "ERROR*No se encontró TipoEvaluacion."
                return
            }
            return [tipoEvaluacionInstance: tipoEvaluacionInstance]
        } else {
            render "ERROR*No se encontró TipoEvaluacion."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return tipoEvaluacionInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def tipoEvaluacionInstance = new TipoEvaluacion()
        if (params.id) {
            tipoEvaluacionInstance = TipoEvaluacion.get(params.id)
            if (!tipoEvaluacionInstance) {
                render "ERROR*No se encontró TipoEvaluacion."
                return
            }
        }
        tipoEvaluacionInstance.properties = params
        return [tipoEvaluacionInstance: tipoEvaluacionInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def tipoEvaluacionInstance = new TipoEvaluacion()
        if (params.id) {
            tipoEvaluacionInstance = TipoEvaluacion.get(params.id)
            if (!tipoEvaluacionInstance) {
                render "ERROR*No se encontró TipoEvaluacion."
                return
            }
        }
        tipoEvaluacionInstance.properties = params
        if (!tipoEvaluacionInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar TipoEvaluacion: " + renderErrors(bean: tipoEvaluacionInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de TipoEvaluacion exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def tipoEvaluacionInstance = TipoEvaluacion.get(params.id)
            if (!tipoEvaluacionInstance) {
                render "ERROR*No se encontró TipoEvaluacion."
                return
            }
            try {
                tipoEvaluacionInstance.delete(flush: true)
                render "SUCCESS*Eliminación de TipoEvaluacion exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar TipoEvaluacion"
                return
            }
        } else {
            render "ERROR*No se encontró TipoEvaluacion."
            return
        }
    } //delete para eliminar via ajax


}
