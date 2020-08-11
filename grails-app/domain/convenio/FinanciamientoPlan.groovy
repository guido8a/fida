package convenio

import parametros.proyectos.Fuente

class FinanciamientoPlan {

    Plan plan
    Fuente fuente
    double valor

    static mapping = {
        table 'fnpl'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'fnpl__id'
            plan column: 'plan__id'
            fuente column: 'fnte__id'
            valor column: 'fnplvlor'
        }
    }

    static constraints = {
        plan(nullable: false, blank: false)
        fuente(nullable: false, blank: false)
        valor(nullable: false, blank: false)
    }
}
