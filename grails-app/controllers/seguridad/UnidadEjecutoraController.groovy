package seguridad

import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class UnidadEjecutoraController {

    UnidadEjecutoraService unidadEjecutoraService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond unidadEjecutoraService.list(params), model:[unidadEjecutoraCount: unidadEjecutoraService.count()]
    }

    def show(Long id) {
        respond unidadEjecutoraService.get(id)
    }

    def create() {
        respond new UnidadEjecutora(params)
    }

    def save(UnidadEjecutora unidadEjecutora) {
        if (unidadEjecutora == null) {
            notFound()
            return
        }

        try {
            unidadEjecutoraService.save(unidadEjecutora)
        } catch (ValidationException e) {
            respond unidadEjecutora.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), unidadEjecutora.id])
                redirect unidadEjecutora
            }
            '*' { respond unidadEjecutora, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond unidadEjecutoraService.get(id)
    }

    def update(UnidadEjecutora unidadEjecutora) {
        if (unidadEjecutora == null) {
            notFound()
            return
        }

        try {
            unidadEjecutoraService.save(unidadEjecutora)
        } catch (ValidationException e) {
            respond unidadEjecutora.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), unidadEjecutora.id])
                redirect unidadEjecutora
            }
            '*'{ respond unidadEjecutora, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        unidadEjecutoraService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def arbol(){

    }
}
