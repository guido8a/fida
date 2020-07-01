package parametros.convenios

import grails.validation.ValidationException
import parametros.convenios.UnidadCompras
import parametros.convenios.UnidadComprasService

import static org.springframework.http.HttpStatus.*

class UnidadComprasController {

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
            def c = UnidadCompras.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = UnidadCompras.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return tipoElementoInstanceList: la lista de elementos filtrados, tipoElementoInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        def unidadComprasInstanceList = getList(params, false)
        def unidadComprasInstanceCount = getList(params, true).size()
        return [unidadComprasInstanceList: unidadComprasInstanceList, unidadComprasInstanceCount: unidadComprasInstanceCount]
    }


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond UnidadComprasService.list(params), model:[UnidadComprasCount: UnidadComprasService.count()]
    }


    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return tipoElementoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def unidadComprasInstance = new UnidadCompras()
        if (params.id) {
            unidadComprasInstance = UnidadCompras.get(params.id)
            if (!unidadComprasInstance) {
                render "ERROR*No se encontró Unidad Compras Públicas."
                return
            }
        }
        unidadComprasInstance.properties = params
        return [unidadComprasInstance: unidadComprasInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        println "---> $params"
        withForm {
            def unidadComprasInstance = new UnidadCompras()
            if (params.id) {
                unidadComprasInstance = UnidadCompras.get(params.id)
                if (!unidadComprasInstance) {
                    notFound_ajax()
                    return
                }
            } //update
            params.codigo = params.codigo.toString().toUpperCase()
            unidadComprasInstance.properties = params
            if (!unidadComprasInstance.save(flush: true)) {
                def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tema."
                msg += renderErrors(bean: unidadComprasInstance)
                render msg
                return
            }
            render "OK_${params.id ? 'Actualización' : 'Creación'} de Tema exitosa."
        }.invalidToken {
            response.status = 405
        }
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def unidadComprasInstance = UnidadCompras.get(params.id)
            if (unidadComprasInstance) {
                try {
                    unidadComprasInstance.delete(flush: true)
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
     * @return Unidad Compras PúblicasInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def unidadComprasInstance = UnidadCompras.get(params.id)
            if (!unidadComprasInstance) {
                render "ERROR*No se encontró Unidad Compras Públicas."
                return
            }
            return [unidadComprasInstance: unidadComprasInstance]
        } else {
            render "ERROR*No se encontró Unidad Compras Públicas."
        }
    } //show para cargar con ajax en un dialog


}
