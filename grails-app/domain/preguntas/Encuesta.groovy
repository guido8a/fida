package preguntas

import audita.Auditable
import proyectos.Indicador
import seguridad.UnidadEjecutora

class Encuesta implements Auditable {

    UnidadEjecutora unidadEjecutora
    Date fecha
    String observaciones

    static auditable = true

    static mapping = {
        table 'encu'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'encu__id'
            unidadEjecutora column: 'unej__id'
            fecha column: 'encufcha'
            observaciones column: 'encuobsr'
        }
    }

    static constraints = {
        unidadEjecutora(blank: false, nullable: false)
        fecha(blank: false, nullable: false)
        observaciones(size: 1..255, nullable: false, blank: false)
    }

    String toString() {
        "${this.observaciones}"
    }

}
