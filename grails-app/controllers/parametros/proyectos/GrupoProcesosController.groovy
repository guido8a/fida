package parametros.proyectos

import org.springframework.dao.DataIntegrityViolationException

class GrupoProcesosController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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
            def c = GrupoProcesos.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = GrupoProcesos.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return grupoProcesosInstanceList: la lista de elementos filtrados, grupoProcesosInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def grupoProcesosInstanceList = getList(params, false)
        def grupoProcesosInstanceCount = getList(params, true).size()
        return [grupoProcesosInstanceList: grupoProcesosInstanceList, grupoProcesosInstanceCount: grupoProcesosInstanceCount]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return grupoProcesosInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def grupoProcesosInstance = GrupoProcesos.get(params.id)
            if (!grupoProcesosInstance) {
                render "ERROR*No se encontró GrupoProcesos."
                return
            }
            return [grupoProcesosInstance: grupoProcesosInstance]
        } else {
            render "ERROR*No se encontró GrupoProcesos."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return grupoProcesosInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def grupoProcesosInstance = new GrupoProcesos()
        if (params.id) {
            grupoProcesosInstance = GrupoProcesos.get(params.id)
            if (!grupoProcesosInstance) {
                render "ERROR*No se encontró GrupoProcesos."
                return
            }
        }
        grupoProcesosInstance.properties = params
        return [grupoProcesosInstance: grupoProcesosInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def grupoProcesosInstance = new GrupoProcesos()
        if (params.id) {
            grupoProcesosInstance = GrupoProcesos.get(params.id)
            if (!grupoProcesosInstance) {
                render "ERROR*No se encontró GrupoProcesos."
                return
            }
        }
        grupoProcesosInstance.properties = params
        if (!grupoProcesosInstance.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar GrupoProcesos: " + renderErrors(bean: grupoProcesosInstance)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de GrupoProcesos exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def grupoProcesosInstance = GrupoProcesos.get(params.id)
            if (!grupoProcesosInstance) {
                render "ERROR*No se encontró GrupoProcesos."
                return
            }
            try {
                grupoProcesosInstance.delete(flush: true)
                render "SUCCESS*Eliminación de GrupoProcesos exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar GrupoProcesos"
                return
            }
        } else {
            render "ERROR*No se encontró GrupoProcesos."
            return
        }
    } //delete para eliminar via ajax


}
