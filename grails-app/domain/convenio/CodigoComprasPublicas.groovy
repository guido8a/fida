package convenio

import audita.Auditable

class CodigoComprasPublicas implements Auditable {

    String numero
    String descripcion
    Date fecha

    static auditable = true

    static mapping = {
        table 'cpac'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'cpac__id'
            numero column: 'cpacnmro'
            descripcion column: 'cpacdscr'
            fecha column: 'cpacfcha'
        }
    }

    static constraints = {
        numero(size: 1..15, nullable: true, blank: true)
        descripcion(size: 1..255, nullable: true, blank: true)
        fecha(nullable: true, blank: true)
    }
}
