package planes

import audita.Auditable

class IndicadorPlan implements Auditable{

    PlanesNegocio planesNegocio
    Indicadores indicadores

    static auditable = true

    static mapping = {
        table 'inpn'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'inpn__id'
            planesNegocio column: 'plns__id'
            indicadores column: 'inor__id'
        }
    }

    static constraints = {
        planesNegocio(blank:true, nullable: true)
        indicadores(blank:true, nullable: true)
    }

}
