package taller

class Nacionalidad {

    String descripcion

    static mapping = {
        table 'nacn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'nacn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'nacn__id'
            descripcion column: 'nacndscr'
        }
    }
    static constraints = {
        descripcion(size: 4..31, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }

    String toString() {
        this.descripcion
    }
}
