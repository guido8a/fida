package seguridad

class TipoInstitucion {

    String descripcion

    static mapping = {
        table 'tpin'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpin__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpin__id'
            descripcion column: 'tpindscr'
        }
    }
    static constraints = {
        descripcion(size: 1..63, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }
}
