package taller

import audita.Auditable
import geografia.Comunidad
import geografia.Parroquia
import seguridad.PersonaOrganizacion

class Asiste implements Auditable {

    Taller taller
    PersonaOrganizacion personaOrganizacion
    Date fecha

    static auditable = true

    def permisos = []

    static mapping = {
        table 'asst'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'asst__id'
            taller column: 'tllr__id'
            personaOrganizacion column: 'pror__id'
            fecha column: 'asstfcha'
        }
    }
    static constraints = {
        taller(blank: false, nullable: false, attributes: [title: 'Taller'])
        personaOrganizacion(blank: false, nullable: false, attributes: [title: 'Persona'])
        fecha(blank: false, nullable: false, attributes: [title: 'Fecha de inicio'])
    }

    String toString() {
        "${this.personaOrganizacion.nombre} ${this.personaOrganizacion.apellido}"
    }

}
