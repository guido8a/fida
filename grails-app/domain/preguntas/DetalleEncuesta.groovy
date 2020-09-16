package preguntas

import audita.Auditable
import seguridad.UnidadEjecutora

class DetalleEncuesta implements Auditable {

    Encuesta encuesta
    RespuestaPregunta respuestaPregunta
    String valor

    static auditable = true

    static mapping = {
        table 'dtec'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dtec__id'
            encuesta column: 'encu__id'
            respuestaPregunta column: 'rspg__id'
            valor column: 'dtecvlor'
        }
    }

    static constraints = {
        encuesta(blank: false, nullable: false)
        respuestaPregunta(blank: false, nullable: false)
        valor(nullable: false, blank: false)
    }

    String toString() {
        "${this.valor}"
    }

}
