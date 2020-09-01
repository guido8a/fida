package planes

import audita.Auditable

class Evaluacion implements Auditable{

    Date fecha
    Date fechaInicio
    Date fechaFin
    String descripcion

    static auditable = true

    static mapping = {
        table 'eval'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'eval__id'
            fecha column: 'evalfcha'
            fechaInicio column: 'evalfcin'
            fechaFin column: 'evalfcfn'
            descripcion column: 'evaldscr'
        }
    }

    static constraints = {
        fecha(nullable: false, blank: false)
        fechaInicio(nullable: false, blank: false)
        fechaFin(nullable: true, blank: true)
        descripcion(size: 1..25, nullable: false, blank: false)
    }
}
