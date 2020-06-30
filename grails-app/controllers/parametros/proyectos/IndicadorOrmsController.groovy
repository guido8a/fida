package parametros.proyectos

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class IndicadorOrmsController {

//    IndicadorOrmsService indicadorOrmsService

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
            def c = IndicadorOrms.createCriteria()
            list = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */

                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            list = IndicadorOrms.list(params)
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
        def indicadorOrmsInstanceList = getList(params, false)
        def indicadorOrmsInstanceCount = getList(params, true).size()
        return [indicadorOrmsInstanceList: indicadorOrmsInstanceList, indicadorOrmsInstanceCount: indicadorOrmsInstanceCount]
    }


    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond IndicadorOrmsService.list(params), model:[IndicadorOrmsCount: IndicadorOrmsService.count()]
    }


    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return tipoElementoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def indicadorOrmsInstance = new IndicadorOrms()
        if (params.id) {
            indicadorOrmsInstance = IndicadorOrms.get(params.id)
            if (!indicadorOrmsInstance) {
                render "ERROR*No se encontró Indicador ORMS."
                return
            }
        }
        indicadorOrmsInstance.properties = params
        return [indicadorOrmsInstance: indicadorOrmsInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        println "---> $params"
        withForm {
            def indicadorOrmsInstance = new IndicadorOrms()
            if (params.id) {
                indicadorOrmsInstance = IndicadorOrms.get(params.id)
                if (!indicadorOrmsInstance) {
                    notFound_ajax()
                    return
                }
            } //update
//            params.codigo = params.codigo.toString().toUpperCase()
            indicadorOrmsInstance.properties = params
            if (!indicadorOrmsInstance.save(flush: true)) {
                def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tema."
                msg += renderErrors(bean: indicadorOrmsInstance)
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
            def indicadorOrmsInstance = IndicadorOrms.get(params.id)
            if (indicadorOrmsInstance) {
                try {
                    indicadorOrmsInstance.delete(flush: true)
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
     * @return Indicador ORMSInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def indicadorOrmsInstance = IndicadorOrms.get(params.id)
            if (!indicadorOrmsInstance) {
                render "ERROR*No se encontró Indicador ORMS."
                return
            }
            return [indicadorOrmsInstance: indicadorOrmsInstance]
        } else {
            render "ERROR*No se encontró Indicador ORMS."
        }
    } //show para cargar con ajax en un dialog


}
