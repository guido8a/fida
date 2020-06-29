package base

class TemaController {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def getLista(params, all) {
        params = params.clone()
        if (all) {
            params.remove("offset")
            params.remove("max")
        }
        def lista
        if (params.search) {
            def c = Tema.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Tema.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def temaInstanceList = getLista(params, false)
        def temaInstanceCount = getLista(params, true).size()
        if (temaInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        temaInstanceList = getLista(params, false)
        return [temaInstanceList: temaInstanceList, temaInstanceCount: temaInstanceCount, params: params]
    } //list

    def show_ajax() {
        if (params.id) {
            def temaInstance = Tema.get(params.id)
            if (!temaInstance) {
                notFound_ajax()
                return
            }
            return [temaInstance: temaInstance]
        } else {
            notFound_ajax()
        }
    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def temaInstance = new Tema(params)
        if (params.id) {
            temaInstance = Tema.get(params.id)
            if (!temaInstance) {
                notFound_ajax()
                return
            }
        }
        return [temaInstance: temaInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        println "---> $params"
        withForm {
            def temaInstance = new Tema()
            if (params.id) {
                temaInstance = Tema.get(params.id)
                if (!temaInstance) {
                    notFound_ajax()
                    return
                }
            } //update
            temaInstance.properties = params
            if (!temaInstance.save(flush: true)) {
                def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Tema."
                msg += renderErrors(bean: temaInstance)
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
            def temaInstance = Tema.get(params.id)
            if (temaInstance) {
                try {
                    temaInstance.delete(flush: true)
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

    protected void notFound_ajax() {
        render "NO_No se encontró Tema."
    } //notFound para ajax

}
