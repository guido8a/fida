package seguridad

import audita.Auditable

class PersonaOrganizacion implements Auditable{

    UnidadEjecutora unidadEjecutora
    String cedula
    String nombre
    String apellido
    Date fechaInicio
    Date fechaFin
//    String titulo
    String cargo
    String mail
    Date fecha
    String telefono
    String sexo
    String discapacidad
    String direccion
    String referencia

    static auditable = true

    static mapping = {
        table 'pror'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'pror__id'
            unidadEjecutora column: 'unej__id'
            cedula column: 'prorcdla'
            nombre column: 'prornmbr'
            apellido column: 'prorapll'
            fechaInicio column: 'prorfcin'
            fechaFin column: 'prorfcfn'
//            titulo column: 'prortitl'
            cargo column: 'prorcrgo'
            mail column: 'prormail'
            telefono column: 'prortelf'
            fecha column: 'prorfcps'
            sexo column: 'prorsexo'
            discapacidad column: 'prordscp'
            direccion column: 'prordire'
            referencia column: 'prorrefe'
//            representante column: 'prsnrplg'
        }
    }
    static constraints = {
        cedula(blank: false, nullable: false)
        nombre(size: 3..31, blank: false)
        apellido(size: 3..31, blank: false)
        fechaInicio(blank: true, nullable: true, attributes: [title: 'Fecha de inicio'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'Fecha de finalización'])
//        titulo(size: 0..4, blank: true, nullable: true)
        cargo(blank: true, nullable: true, size: 1..127, attributes: [mensaje: 'Cargo'])
        sexo(inList: ["F", "M"], size: 1..1, blank: false, attributes: ['mensaje': 'Sexo de la persona'])
        mail(size: 3..63, blank: true, nullable: true)
        fecha(blank: true, nullable: true)
        telefono(size: 0..31, blank: true, nullable: true, attributes: [title: 'teléfono'])
        discapacidad(size: 0..15, blank: true, nullable: true)
        direccion(size: 0..255, blank: true, nullable: true)
        referencia(size: 0..255, blank: true, nullable: true)
//        representante(blank: true, nullable: true)
    }

    String toString() {
        "${this.id}: ${this.nombre} ${this.apellido}"
    }

    def getNombreCompleto() {
        if(this.titulo) {
            return "${this?.titulo} ${this.nombre} ${this.apellido}"
        } else {
            return "${this.nombre} ${this.apellido}"
        }

    }

}
