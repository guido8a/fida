package convenio

import audita.Auditable

class Aseguradora implements Auditable {

    String nombre
    String telefono
    String mail
    String responsable
    String direccion
    String observaciones
    static auditable = true

    static mapping = {

        table 'asgr'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'asgr__id'
        id generator: 'identity'
        version false

        columns {
            id column: 'asgr__id'
            nombre column: 'asgrnmbr'
            telefono column: 'asgrtelf'
            mail column: 'asgrmail'
            responsable column: 'asgrrspn'
            direccion column: 'asgrdire'
            observaciones column: 'asgrobsr'
        }
    }


    static constraints = {
        nombre(size: 1..61, blank: true, attributes: [title: 'nombre'])
        telefono(size: 1..63, blank: true, nullable: true, attributes: [title: 'telefonos'])
        mail(size: 1..63, blank: true, nullable: true, attributes: [title: 'mail'])
        responsable(size: 1..63, blank: true, nullable: true, attributes: [title: 'responsable'])
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        observaciones(size: 1..127, blank: true, nullable: true, attributes: [title: 'observaciones'])
    }
}
