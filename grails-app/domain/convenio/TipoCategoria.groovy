package convenio

import audita.Auditable

class TipoCategoria implements Auditable{

    String descripcion

    static auditable = true

    static mapping = {
        table 'tpct'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpct__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpct__id'
            descripcion column: 'tpctdscr'
        }
    }

    static constraints = {
        descripcion(size: 1..63, blank: false, nullable: false)
    }

}
