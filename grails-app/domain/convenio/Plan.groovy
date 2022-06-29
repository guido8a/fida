package convenio

import audita.Auditable
import planes.GrupoActividad
import planes.PlanesNegocio
import poa.Presupuesto
import proyectos.MarcoLogico

class Plan implements Auditable {

    PlanesNegocio planesNegocio
    GrupoActividad grupoActividad
    Presupuesto presupuesto
    UnidadComprasPublicas unidadComprasPublicas
    TipoProcesoComprasPublicas tipoProcesoComprasPublicas
    CodigoComprasPublicas codigoComprasPublicas
    String descripcion
    double cantidad
    double costo
    double ejecutado
    String estado

    static auditable = true

    static mapping = {
        table 'plan'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'plan__id'
            planesNegocio column: 'plns__id'
            grupoActividad column: 'grac__id'
            unidadComprasPublicas column: 'uncp__id'
            tipoProcesoComprasPublicas column: 'tppc__id'
            codigoComprasPublicas column: 'cpac__id'
            presupuesto column: 'prsp__id'
            descripcion column: 'plandscr'
            cantidad column: 'plancntd'
            costo column: 'plancsto'
            ejecutado column: 'planejec'
            estado column: 'planetdo'
        }
    }

    static constraints = {
        planesNegocio(nullable: false, blank: false)
        grupoActividad(nullable: false, blank: false)
        unidadComprasPublicas(nullable: true, blank: true)
        tipoProcesoComprasPublicas(nullable: true, blank: true)
        codigoComprasPublicas(nullable: true, blank: true)
        presupuesto(nullable: true, blank: true)
        descripcion(size: 1..255, nullable: false, blank: false)
        cantidad(nullable: true, blank: true)
        costo(nullable:true, blank:true)
        ejecutado(nullable: true, blank: true)
        estado(nullable: true, blank: true)
    }
}
