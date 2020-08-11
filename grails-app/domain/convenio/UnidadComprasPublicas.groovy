package convenio

class UnidadComprasPublicas {

    String codigo
    String descripcion

    static mapping = {
        table 'uncp'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'uncp__id'
            codigo column: 'uncpcdgo'
            descripcion column: 'uncpdscr'
        }
    }

    static constraints = {
        codigo(size: 1..7, nullable: false, blank: false)
        descripcion(size: 1..63, nullable: false, blank: false)
    }
}
