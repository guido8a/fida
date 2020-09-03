package planes

import audita.Auditable

class Indicadores implements Auditable {

    String codigo
    String descripcion

    static auditable = true

    static mapping = {
        table 'inor'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'inor__id'
            codigo column: 'inorcdgo'
            descripcion column: 'inordscr'
        }
    }

    static constraints = {
        codigo(size: 1..15, blank: true, nullable: true)
        descripcion(size: 1..255, nullable: false, blank: false)
    }


}
