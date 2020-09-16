package preguntas

import audita.Auditable
import proyectos.Indicador

class Respuesta implements Auditable {

    String opcion

    static auditable = true

    static mapping = {
        table 'resp'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'resp__id'
            opcion column: 'respdscr'
        }
    }

    static constraints = {
        opcion(size: 1..255, nullable: false, blank: false)
    }

    String toString() {
        "${this.opcion}"
    }

}
