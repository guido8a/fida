package taller

class TipoOrganizacion {

    String descripcion

    static mapping = {
        table 'tpor'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpor__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'tpor__id'
            descripcion column: 'tpordscr'
        }
    }
    static constraints = {
        descripcion(size: 1..31, blank: false, nullable: false, attributes: [title: 'descripcion'])
    }

    @Override
    String toString() {
        return this.descripcion
    }
}
