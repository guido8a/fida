package taller

class Capacidad {

    String descripcion

    static mapping = {
        table 'cpcd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cpcd__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'cpcd__id'
            descripcion column: 'cpcddscr'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }

    String toString() {
        this.descripcion
    }
}
