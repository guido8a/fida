package convenio

import audita.Auditable

class TipoGarantia implements Auditable {

    String descripcion

    static auditable = true
    static mapping = {
        table 'tpgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpgr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpgr__id'
            descripcion column: 'tpgrdscr'
        }
    }

    static constraints = {
        descripcion(size: 1..30, blank: true, nullable: true, attributes: [title: 'descripción'])
    }
}
