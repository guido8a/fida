package convenio


class PlanPeriodo {

    Plan plan
    Periodo periodo
    double valor

    static auditable = true

    static mapping = {
        table 'plpr'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'plpr__id'
            plan column: 'plan__id'
            periodo column: 'prdo__id'
            valor column: 'plprvlor'
        }
    }

    static constraints = {
        plan(nullable: false, blank: false)
        periodo(nullable: false, blank: false)
        valor(nullable: false, blank:false)
    }
}
