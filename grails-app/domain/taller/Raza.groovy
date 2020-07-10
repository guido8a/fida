package taller

class Raza {

    String descripcion

    static mapping = {
        table 'raza'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'raza__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'raza__id'
            descripcion column: 'razadscr'
        }
    }
    static constraints = {
        descripcion(size: 4..31, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }

    String toString() {
        this.descripcion
    }
}
