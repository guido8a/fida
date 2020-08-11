package convenio

class Avance {

    InformeAvance informeAvance
    Plan plan
    String descripcion
    double valor

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
        }
    }

    static constraints = {
        informeAvance(nullable: false, blank: false)
        plan(nullable: false, blank: false)
        descripcion(size: 1..1023, nullable: false, blank: false)
        valor(nullable: false, blank:false)
    }
}
