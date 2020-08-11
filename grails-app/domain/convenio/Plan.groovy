package convenio

import proyectos.MarcoLogico

class Plan {

    Convenio convenio
    MarcoLogico marcoLogico
    UnidadComprasPublicas unidadComprasPublicas
    TipoProcesoComprasPublicas tipoProcesoComprasPublicas
    Periodo periodo
    CodigoComprasPublicas codigoComprasPublicas
    String descripcion
    double cantidad
    double costo
    double ejecutado
    String estado


    static mapping = {
        table 'plan'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'plan__id'
            convenio column: 'cnvn__id'
            marcoLogico column: 'mrlg__id'
            unidadComprasPublicas column: 'uncp__id'
            tipoProcesoComprasPublicas column: 'tppc__id'
            periodo column: 'prdo__id'
            codigoComprasPublicas column: 'cpac__id'
            descripcion column: 'plandscr'
            cantidad column: 'plancntd'
            costo column: 'plancsto'
            ejecutado column: 'planejec'
            estado column: 'planetdo'
        }
    }

    static constraints = {
        convenio(nullable: false, blank: false)
        marcoLogico(nullable: false, blank: false)
        unidadComprasPublicas(nullable: false, blank: false)
        tipoProcesoComprasPublicas(nullable: false, blank: false)
        periodo(nullable: false, blank: false)
        codigoComprasPublicas(nullable: false, blank: false)
        descripcion(size: 1..255, nullable: false, blank: false)
        cantidad(nullable: true, blank: true)
        costo(nullable:true, blank:true)
        ejecutado(nullable: true, blank: true)
        estado(size: 1, nullable: true, blank: true)
    }
}
