package taller

class Institucion {

    String descripcion

    static mapping = {
        table 'inst'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'inst__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'inst__id'
            descripcion column: 'instdscr'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
