package convenio

import audita.Auditable
import seguridad.Persona

class AdministradorConvenio implements Auditable {

    Persona persona
    Convenio convenio
    Date fechaInicio
    Date fechaFin
    String observaciones

    static auditable = true

    static mapping = {
        table 'adcv'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'adcv__id'
            persona column: 'prsn__id'
            convenio column: 'cnvn__id'
            fechaInicio column: 'adcvfcin'
            fechaFin column: 'adcvfcfn'
            observaciones column: 'adcvobsr'
        }
    }

    static constraints = {
        persona(nullable: false, blank: false)
        convenio(nullable: false, blank: false)
        fechaInicio(nullable: false, blank:false)
        fechaFin(nullable: true, blank:true)
        observaciones(nullable: true, blank: true)
    }

}
