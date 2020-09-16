package preguntas

import audita.Auditable

class RespuestaPregunta implements Auditable {

    Respuesta respuesta
    Pregunta pregunta

    static auditable = true

    static mapping = {
        table 'rspg'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'rspg__id'
            pregunta column: 'preg__id'
            respuesta column: 'resp__id'
        }
    }

    static constraints = {
        pregunta(blank: false, nullable: false)
        respuesta(blank: false, nullable: false)
    }

    String toString() {
        "${this.pregunta.descripcion} ${this.respuesta.opcion}"
    }

}
