package convenio

import audita.Auditable
import geografia.Parroquia
import planes.PlanesNegocio
import seguridad.UnidadEjecutora

class Convenio implements Auditable{

//    Parroquia parroquia
    PlanesNegocio planesNegocio
//    UnidadEjecutora unidadEjecutora
    String codigo
    String nombre
    String objetivo
    Date fecha
    Date fechaInicio
    Date fechaFin
    int plazo = 0
    Double monto = 0.0
    int periodo = 0
    String estado = 'N'
    String desembolso

    static auditable = true

    static mapping = {
        table 'cnvn'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'cnvn__id'
//            parroquia column: 'parr__id'
            planesNegocio column: 'plns__id'
//            unidadEjecutora column: 'unej__id'
            codigo column: 'cnvncdgo'
            nombre column: 'cnvnnmbr'
            objetivo column: 'cnvnobjt'
            fecha column: 'cnvnfcha'
            fechaInicio column: 'cnvnfcin'
            fechaFin column: 'cnvnfcfn'
            plazo column: 'cnvnplzo'
            monto column: 'cnvnmnto'
            periodo column: 'cnvnprdo'
            estado column: 'cnvnetdo'
            desembolso column: 'cnvndsmb'
        }
    }
    static constraints = {
//        parroquia(blank: false, nullable: false)
        planesNegocio(blank: false, nullable: false)
//        unidadEjecutora(blank: false, nullable: false)
        codigo(size: 0..15, blank: true, nullable: false)
        nombre(size: 3..255, blank: false)
        objetivo(blank: false)
        fecha(blank: false, nullable: false, attributes: [title: 'Fecha de inicio'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'Fecha de inicio'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'Fecha de finalización'])
        plazo(blank: false, nullable: false)
        monto(blank: false, nullable: false)
        periodo(blank: false, nullable: false)
        estado(blank: false, nullable: false)
        desembolso(blank: true, nullable: true)
    }

    String toString() {
        "${this.nombre}"
    }

}
