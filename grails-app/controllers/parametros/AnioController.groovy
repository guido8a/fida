package parametros


class AnioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    def getList(params, all) {
        println "params: $params"
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
        if (params.search) {
            def c = Anio.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("anio", "%" + params.search + "%")
                }
            }
        } else {
            list = Anio.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return AñoInstanceList: la lista de elementos filtrados, AñoInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def anioInstanceList = getList(params, false)
        def anioInstanceCount = getList(params, true).size()
        return [anioInstanceList: anioInstanceList, anioInstanceCount: anioInstanceCount]
    }


    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return AñoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def anioInstance = new Anio()
        if (params.id) {
            anioInstance = Anio.get(params.id)
            if (!anioInstance) {
                render "ERROR*No se encontró Año."
                return
            }
        }
        anioInstance.properties = params
        return [anioInstance: anioInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        println "---> $params"
        withForm {
            def anioInstance = new Anio()
            if (params.id) {
                anioInstance = Anio.get(params.id)
                if (!anioInstance) {
                    notFound_ajax()
                    return
                }
            } //update
            anioInstance.properties = params
            println " ... graba "
            if (!anioInstance.save(flush: true)) {
                println "error: ${anioInstance.errors}"
                def msg = "no_No se pudo ${params.id ? 'actualizar' : 'crear'} Año."
                msg += renderErrors(bean: anioInstance)
                render msg
                return
            }
            render "ok_${params.id ? 'Actualización' : 'Creación'} de Año exitosa."
        }.invalidToken {
            response.status = 405
        }
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def anioInstance = Anio.get(params.id)
            if (anioInstance) {
                try {
                    anioInstance.delete(flush: true)
                    render "OK_Eliminación de Tema exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Tema."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax


    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return Año el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def anioInstance = Anio.get(params.id)
            if (!anioInstance) {
                render "ERROR*No se encontró Año."
                return
            }
            return [anioInstance: anioInstance]
        } else {
            render "ERROR*No se encontró Año."
        }
    } //show para cargar con ajax en un dialog



}
