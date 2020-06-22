package seguridad

import fida.Provincia

class UnidadEjecutora {

    UnidadEjecutora unidadEjecutora
    UnidadEjecutora padre
    TipoInstitucion tipoInstitucion
    Provincia provincia
    String codigo
    Date fechaInicio
    Date fechaFin
    String nombre
    String direccion
    String sigla
    String objetivo
    String telefono
    String mail
    String observaciones
    int numero
    int orden

    static mapping = {
        table 'unej'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'unej__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'unej__id'
            unidadEjecutora column: 'unej_unej__id'
            tipoInstitucion column: 'tpin__id'
            provincia column: 'prov__id'
            padre column: 'unejpdre'
            codigo column: 'unejcdgo'
            fechaInicio column: 'unejfcin'
            fechaFin column: 'unejfcfn'
            nombre column: 'unejnmbr'
            direccion column: 'unejdire'
            sigla column: 'unejsgla'
            objetivo column: 'unejobjt'
            telefono column: 'unejtelf'
            mail column: 'unejmail'
            observaciones column: 'unejobsr'
            numero column: 'unejnmsr'
            orden column: 'unejordn'
        }
    }
    static constraints = {
        nombre(size: 1..63, blank: false, nullable: false, attributes: [title: 'nombre'])
        codigo(size: 1..4, blank: false, nullable: false, attributes: [title: 'codigo'])
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        sigla(size: 0..7, blank: true, nullable: true, attributes: [title: 'sigla'])
        objetivo(size: 0..63, blank: true, nullable: true, attributes: [title: 'objetivo'])
        telefono(size: 0..63, blank: true, nullable: true, attributes: [title: 'telefono'])
        observaciones(size: 0..127, blank: true, nullable: true, attributes: [title: 'observaciones'])
        numero(blank: true, nullable: true, attributes: [title: 'numero'])
        orden(blank: true, nullable: true, attributes: [title: 'orden'])

    }
}
