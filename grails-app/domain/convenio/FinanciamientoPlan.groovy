package convenio

import audita.Auditable
import planes.FinanciamientoPlanNegocio

class FinanciamientoPlan implements Auditable {

    Plan plan
    FinanciamientoPlanNegocio financiamientoPlanNegocio
    double valor

    static auditable = true

    static mapping = {
        table 'fnpl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'fnpl__id'
            plan column: 'plan__id'
            financiamientoPlanNegocio column: 'fnpn__id'
            valor column: 'fnplvlor'
        }
    }

    static constraints = {
        plan(nullable: false, blank: false)
        financiamientoPlanNegocio(nullable: false, blank: false)
        valor(nullable: false, blank: false)
    }
}
