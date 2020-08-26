package convenio

import audita.Auditable

class TipoNecesidad implements Auditable{

    String descripcion

    static auditable = true

    static mapping = {
        table 'ndfr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'ndfr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'ndfr__id'
            descripcion column: 'ndfrdscr'
        }
    }

    static constraints = {
        descripcion(size: 1..63, blank: false, nullable: false)
    }

}
