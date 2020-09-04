package planes

import audita.Auditable

class GrupoActividad implements Auditable {

    GrupoActividad padre
    PlanesNegocio planesNegocio
    String numero
    String descripcion

    static auditable = true

    static mapping = {
        table 'grac'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'grac__id'
            padre column: 'gracpdre'
            planesNegocio column: 'plns__id'
            numero column: 'gracnmro'
            descripcion column: 'gracdscr'
        }
    }

    static constraints = {
        numero(size: 1..7, blank: false, nullable: false)
        padre(blank: true, nullable: true)
        planesNegocio(blank: false, nullable: false)
        descripcion(size: 1..255, nullable: false, blank: false)
    }

    String toString() {
        "${this.numero} ${this.descripcion}"
    }

}
