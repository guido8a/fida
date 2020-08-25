package convenio

import audita.Auditable
import seguridad.UnidadEjecutora
import taller.Raza

class EtniaOrganizacion implements Auditable{

    UnidadEjecutora unidadEjecutora
    Raza raza
    int numero = 0

    static auditable = true

    static mapping = {
        table 'etor'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'etor__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'etor__id'
            unidadEjecutora column: 'unej__id'
            raza column: 'raza__id'
            numero column: 'etornmro'
        }
    }

    static constraints = {
        unidadEjecutora(blank:false, nullable: false)
        raza(blank:false, nullable: false)
        numero(blank:false, nullable: false)
    }


}
