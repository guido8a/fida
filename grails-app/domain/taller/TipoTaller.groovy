package taller

class TipoTaller {

    String descripcion

    static mapping = {
        table 'tptl'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tptl__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tptl__id'
            descripcion column: 'tptldscr'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }

    @Override
    String toString() {
        return this.descripcion
    }
}
