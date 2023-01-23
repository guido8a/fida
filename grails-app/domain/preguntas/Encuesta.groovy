package preguntas

import audita.Auditable
import proyectos.Indicador
import seguridad.PersonaOrganizacion
import seguridad.UnidadEjecutora

class Encuesta implements Auditable {

    UnidadEjecutora unidadEjecutora
    Date fecha
    String observaciones
    String estado = 'N'
    PersonaOrganizacion personaOrganizacion

    static auditable = true

    static mapping = {
        table 'encu'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'encu__id'
            unidadEjecutora column: 'unej__id'
            fecha column: 'encufcha'
            observaciones column: 'encuobsr'
            estado column: 'encuetdo'
            personaOrganizacion column: 'pror__id'
        }
    }

    static constraints = {
        unidadEjecutora(blank: false, nullable: false)
        fecha(blank: false, nullable: false)
        estado(nullable: false, blank: false)
        personaOrganizacion(nullable: true, blank: true)
        observaciones(size: 1..255, nullable: true, blank: true)
    }

    String toString() {
        "${this.observaciones}"
    }

}
