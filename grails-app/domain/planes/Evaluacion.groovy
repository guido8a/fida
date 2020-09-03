package planes

import audita.Auditable
import parametros.convenio.TipoEvaluacion

class Evaluacion implements Auditable{

    PlanesNegocio planesNegocio
    TipoEvaluacion tipoEvaluacion
    Date fecha
    Date fechaInicio
    Date fechaFin
    String descripcion

    static auditable = true

    static mapping = {
        table 'eval'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'eval__id'
            planesNegocio column: 'plns__id'
            tipoEvaluacion column: 'tpev__id'
            fecha column: 'evalfcha'
            fechaInicio column: 'evalfcin'
            fechaFin column: 'evalfcfn'
            descripcion column: 'evaldscr'
        }
    }

    static constraints = {
        planesNegocio(blank:false, nullable: false)
        tipoEvaluacion(blank:false, nullable: false)
        fecha(nullable: false, blank: false)
        fechaInicio(nullable: false, blank: false)
        fechaFin(nullable: true, blank: true)
        descripcion(size: 1..25, nullable: false, blank: false)
    }
}
