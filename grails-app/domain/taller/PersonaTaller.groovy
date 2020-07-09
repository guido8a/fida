package taller

import audita.Auditable
import geografia.Comunidad
import geografia.Parroquia
import seguridad.UnidadEjecutora

class PersonaTaller implements Auditable{

    Parroquia parroquia
    Comunidad comunidad
    Taller taller

    String cedula
    String nombre
    String apellido
    Date fecha
    String titulo
    String cargo
    String mail
    String sexo
    String discapacidad
    String direccion

    static auditable = true

    def permisos = []

    static mapping = {
        table 'prtl'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'prtl__id'
            parroquia column: 'parr__id'
            comunidad column: 'cmnd__id'
            taller column: 'tllr__id'
            cedula column: 'prtlcdla'
            nombre column: 'prtlnmbr'
            apellido column: 'prtlapll'
            fecha column: 'prtlfcha'
            titulo column: 'prtltitl'
            cargo column: 'prtlcrgo'
            mail column: 'prtlmail'
            sexo column: 'prtlsexo'
            discapacidad column: 'prtldscp'
            direccion column: 'prtldire'
        }
    }
    static constraints = {
        comunidad(blank: true, nullable: true)
        parroquia(blank: false, nullable: false)
        cedula(size: 3..10, blank: false)
        nombre(size: 3..255, blank: false)
        apellido(size: 3..255, blank: false)
        fecha(blank: false, nullable: false, attributes: [title: 'Fecha de inicio'])
        titulo(blank: true, nullable: true)
        cargo(blank: true, nullable: true)
        sexo(blank: false, nullable: false)
        discapacidad(blank: false, nullable: false)
        direccion(blank: true, nullable: true)
    }

    String toString() {
        "${this.nombre}"
    }

}
