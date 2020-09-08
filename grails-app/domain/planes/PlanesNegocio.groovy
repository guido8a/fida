package planes

import audita.Auditable
import geografia.Parroquia
import seguridad.UnidadEjecutora

class PlanesNegocio implements Auditable{

    UnidadEjecutora unidadEjecutora
//    Parroquia parroquia
    String nombre
    String objeto
    String nudoCritico
    Date fechaPresentacion
    Date fechaComite
    Date fechaAprobacion
    int calificacion
    double monto
    double numeroSocios
    double venta
    double costo
    double excedente
    double van
    double tir
    double tasa
    double capitalTrabajo
    double inversiones
    double terreno
    double maquinaria
    double muebles
    int plazo = 0
    String estado = 'N'

    static auditable = true

    static mapping = {
        table 'plns'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'plns__id'
            unidadEjecutora column: 'unej__id'
//            parroquia column: 'parr__id'
            nombre column: 'plnsnmbr'
            objeto column: 'plnsobjt'
            nudoCritico column: 'plnsndcr'
            fechaPresentacion column: 'plnsfcpr'
            fechaComite column: 'plnsfccm'
            fechaAprobacion column: 'plnsfcap'
            calificacion column: 'plnscalf'
            monto column: 'plnsmnto'
            numeroSocios column: 'plnsnmso'
            venta column: 'plnsvnta'
            costo column: 'plnscsto'
            excedente column: 'plnsexcd'
            van column: 'plns_van'
            tir column: 'plns_tir'
            tasa column: 'plnstasa'
            capitalTrabajo column: 'plnscptr'
            inversiones column: 'plnsinpr'
            terreno column: 'plnstrcn'
            maquinaria column: 'plnsmqeq'
            muebles column: 'plnsmbeq'
            plazo column: 'plnsplzo'
            estado column: 'plnsetdo'
        }
    }

    static constraints = {
        unidadEjecutora(nullable: false, blank: false)
//        parroquia(nullable: false, blank: false)
        nombre(size: 1..255, nullable: false, blank: false)
        objeto(nullable: true, blank: true)
        nudoCritico(nullable: true, blank: true)
        fechaPresentacion(nullable: true, blank: true)
        fechaAprobacion(nullable: true, blank: true)
        fechaComite(nullable: true, blank: true)
        calificacion(nullable: true, blank: true)
        monto(nullable: true, blank: true)
        numeroSocios(nullable: true, blank: true)
        venta(nullable: true, blank: true)
        costo(nullable: true, blank: true)
        excedente(nullable: true, blank: true)
        van(nullable: true, blank: true)
        tir(nullable: true, blank: true)
        tasa(nullable: true, blank: true)
        capitalTrabajo(nullable: true, blank: true)
        inversiones(nullable: true, blank: true)
        terreno(nullable: true, blank: true)
        maquinaria(nullable: true, blank: true)
        muebles(nullable: true, blank: true)
        estado(nullable: false, blank: false)
    }
}
