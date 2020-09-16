package preguntas

import audita.Auditable
import proyectos.Indicador

class Pregunta implements Auditable {

    Indicador indicador
    String numero
    String descripcion

    static auditable = true

    static mapping = {
        table 'preg'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'preg__id'
            indicador column: 'indi__id'
            numero column: 'pregnmro'
            descripcion column: 'pregdscr'
        }
    }

    static constraints = {
        numero(size: 1..7, blank: false, nullable: false)
        indicador(blank: false, nullable: false)
        descripcion(size: 1..255, nullable: false, blank: false)
    }

    String toString() {
        "${this.numero} ${this.descripcion}"
    }

}
