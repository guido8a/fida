package convenio

import audita.Auditable


class Modificacion implements Auditable {

    Plan plan
    Periodo periodo
    Date fecha
    Date fechaModificacion
    double valor

    static auditable = true

    static mapping = {
        table 'mdcv'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mdcv__id'
            plan column: 'plan__id'
            periodo column: 'prdo__id'
            fechaModificacion column: 'mdcvfcmd'
            fecha column: 'mdcvfcha'
            valor column: 'mdcvvlor'
        }
    }

    static constraints = {
        plan(nullable: false, blank: false)
        periodo(nullable: false, blank: false)
        fecha(nullable: false, blank:false)
        fechaModificacion(nullable: false, blank:false)
        valor(nullable:false, blank:false)
    }
}
