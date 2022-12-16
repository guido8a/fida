package convenio

import audita.Auditable

class Avance implements Auditable {

    InformeAvance informeAvance
    Plan plan
    String descripcion
    double valor = 0
    double extra = 0
    double multa = 0
    double interes = 0

    static auditable = true

    static mapping = {
        table 'avnc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'avnc__id'
            informeAvance column: 'info__id'
            plan column: 'plan__id'
            descripcion column: 'avncdscr'
            valor column: 'avncvlor'
            extra column: 'avncextr'
            multa column: 'avncmlta'
            interes column: 'avncintr'
        }
    }

    static constraints = {
        informeAvance(nullable: false, blank: false)
        plan(nullable: false, blank: false)
        descripcion(size: 1..1023, nullable: false, blank: false)
        valor(nullable: false, blank:false)
        extra(nullable: true, blank:true)
        multa(nullable: true, blank:true)
        interes(nullable: true, blank:true)
    }
}
