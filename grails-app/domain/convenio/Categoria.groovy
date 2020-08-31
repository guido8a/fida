package convenio

import audita.Auditable
import seguridad.UnidadEjecutora

class Categoria implements Auditable{

    UnidadEjecutora unidadEjecutora
    TipoCategoria tipoCategoria
    String valor

    static auditable = true

    static mapping = {
        table 'ctgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'ctgr__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'ctgr__id'
            unidadEjecutora column: 'unej__id'
            tipoCategoria column: 'tpct__id'
            valor column: 'ctgrvlor'
        }
    }

    static constraints = {
        unidadEjecutora(blank: false, nullable: false)
        tipoCategoria(blank: false, nullable: false)
        valor(size: 1..31, blank: false, nullable: false)
    }


}
