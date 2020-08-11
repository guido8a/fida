package convenio

import proyectos.Documento

class Desembolso {

    Plan plan
    Documento documento
    String descripcion
    double valor
    Date fecha

    static mapping = {
        table 'dsmb'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dsmb__id'
            plan column: 'plan__id'
            documento column: 'dcmt__id'
            descripcion column: 'dsmbdscr'
            fecha column: 'dsmbfcha'
            valor column: 'dsmbvlor'
        }
    }

    static constraints = {
        plan(nullable: false, blank: false)
        documento(nullable: true, blank: true)
        descripcion(nullable: false, blank:false)
        valor(nullable: false, blank:false)
        fecha(nullable: false, blank:false)
    }
}
