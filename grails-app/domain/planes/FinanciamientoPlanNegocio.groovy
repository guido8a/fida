package planes

import audita.Auditable
import parametros.proyectos.Fuente

class FinanciamientoPlanNegocio implements Auditable{

    PlanesNegocio planesNegocio
    Fuente fuente
    double valor

    static auditable = true

    static mapping = {
        table 'fnpn'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'fnpn__id'
            planesNegocio column: 'plns__id'
            fuente column: 'fnte__id'
            valor column: 'fnpnvlor'
        }
    }

    static constraints = {
        planesNegocio(nullable: false, blank: false)
        fuente(nullable: false, blank: false)
        valor(nullable: false, blank: false)
    }
}
