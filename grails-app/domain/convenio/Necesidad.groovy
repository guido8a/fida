package convenio

import audita.Auditable
import seguridad.UnidadEjecutora

class Necesidad implements Auditable{

    UnidadEjecutora unidadEjecutora
    TipoNecesidad tipoNecesidad

    static auditable = true

    static mapping = {
        table 'necd'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'necd__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'necd__id'
            unidadEjecutora column: 'unej__id'
            tipoNecesidad column: 'ndfr__id'
        }
    }

    static constraints = {
        unidadEjecutora(blank: false, nullable: false)
        tipoNecesidad(blank: false, nullable: false)
    }


}
