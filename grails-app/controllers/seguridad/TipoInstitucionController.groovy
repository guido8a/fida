package seguridad

import base.Tema
import grails.validation.ValidationException
import parametros.proyectos.TipoElemento

import static org.springframework.http.HttpStatus.*

class TipoInstitucionController {

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
            def c = TipoInstitucion.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = TipoInstitucion.list(params)
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
        def tipoInstitucionInstanceList = getList(params, false)
        def tipoInstitucionInstanceCount = getList(params, true).size()
        return [tipoInstitucionInstanceList: tipoInstitucionInstanceList, tipoInstitucionInstanceCount: tipoInstitucionInstanceCount]
    }


    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return tipoElementoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def tipoInstitucionInstance = new TipoInstitucion()
        if (params.id) {
            tipoInstitucionInstance = TipoInstitucion.get(params.id)
            if (!tipoInstitucionInstance) {
                render "ERROR*No se encontró TipoElemento."
                return
            }
        }
        tipoInstitucionInstance.properties = params
        return [tipoInstitucionInstance: tipoInstitucionInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        println "---> $params"
        withForm {
            def tipoInstitucionInstance = new TipoInstitucion()
            if (params.id) {
                tipoInstitucionInstance = TipoInstitucion.get(params.id)
                if (!tipoInstitucionInstance) {
                    notFound_ajax()
                    return
                }
            } //update
            tipoInstitucionInstance.properties = params
            if (!tipoInstitucionInstance.save(flush: true)) {
                def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tema."
                msg += renderErrors(bean: tipoInstitucionInstance)
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
            def tipoInstitucionInstance = TipoInstitucion.get(params.id)
            if (tipoInstitucionInstance) {
                try {
                    tipoInstitucionInstance.delete(flush: true)
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
     * @return tipoElementoInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def tipoInstitucionInstance = TipoInstitucion.get(params.id)
            if (!tipoInstitucionInstance) {
                render "ERROR*No se encontró TipoElemento."
                return
            }
            return [tipoInstitucionInstance: tipoInstitucionInstance]
        } else {
            render "ERROR*No se encontró TipoElemento."
        }
    } //show para cargar con ajax en un dialog


}
