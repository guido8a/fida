package planes

import audita.Auditable
import parametros.convenio.TipoEvaluacion

class DetalleEvaluacion implements Auditable{

//    TipoEvaluacion tipoEvaluacion
    Evaluacion evaluacion
    IndicadorPlan indicadorPlan
    Double valor
    String observaciones

    static auditable = true

    static mapping = {
        table 'dtev'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dtev__id'
//            tipoEvaluacion column: 'tpev'
            evaluacion column: 'eval__id'
            indicadorPlan column: 'inpn__id'
            valor column: 'dtevvlor'
            observaciones column: 'dtevobsr'
        }
    }

    static constraints = {
//        tipoEvaluacion(nullable: false, blank: false)
        evaluacion(nullable: false, blank: false)
        indicadorPlan(nullable: false, blank: false)
        valor(nullable: false, blank: false)
        observaciones(nullable: true, blank: true)
    }
}
