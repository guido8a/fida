package seguridad

import audita.Auditable
import convenio.Convenio
import seguridad.Persona

class Representante implements Auditable {

    PersonaOrganizacion personaOrganizacion
    Date fechaInicio
    Date fechaFin
    String observaciones

    static auditable = true

    static mapping = {
        table 'rplg'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'rplg__id'
            personaOrganizacion column: 'pror__id'
            fechaInicio column: 'rplgfcin'
            fechaFin column: 'rplgfcfn'
            observaciones column: 'rplgobsr'
        }
    }

    static constraints = {
        personaOrganizacion(nullable: false, blank: false)
        fechaInicio(nullable: false, blank:false)
        fechaFin(nullable: true, blank:true)
        observaciones(nullable: true, blank: true)
    }

}
