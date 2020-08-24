package convenio

import audita.Auditable
import seguridad.UnidadEjecutora

class DatosOrganizacion implements Auditable{

    UnidadEjecutora unidadEjecutora
    String financiera
    String cuenta
    String tipoCuenta
    int legales
    int noLegales
    int familiasLegales
    int familiasNoLegales
    int socios
    int mujeresSocias
    int hombresSocios
    int jovenes
    int obreros
    int dirigentes
    int dirigentesHombres
    int dirigentesMujeres
    int sociosJovenes
    int sociosJovenesHombres
    int sociosJovenesMujeres
    int adultosMayores
    int adultosMayoresMujeres
    int adultosMayoresHombres
    int discapacitados
    int discapacitadosMujeres
    int discapacitadosHombres
    int usuariosBono
    int usuariosBonoMujeres
    int usuariosBonoHombres
    int usuariosCredito
    int usuariosCreditoHombres
    int usuariosCreditoMujeres
    int mujeresCabezaHogar

    static auditable = true

    static mapping = {
        table 'dtor'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtor__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dtor__id'
            unidadEjecutora column: 'unej__id'
            financiera column: 'dtorfina'
            cuenta column: 'dtorcnta'
            tipoCuenta column: 'dtorcntp'
            legales column: 'dtornmsl'
            noLegales column: 'dtornmsn'
            familiasLegales column: 'dtornmfa'
            familiasNoLegales column: 'dtornmfn'
            socios column: 'dtornmso'
            mujeresSocias column: 'dtornmmj'
            hombresSocios column: 'dtornmhh'
            jovenes column: 'dtornmjv'
            obreros column: 'dtornmob'
            dirigentes column:'dtornmsd'
            dirigentesHombres column: 'dtorndhh'
            dirigentesMujeres column: 'dtorndmj'
            sociosJovenes column: 'dtornsjv'
            sociosJovenesMujeres column: 'dtornsjm'
            sociosJovenesHombres column: 'dtornsjh'
            adultosMayores column: 'dtornsam'
            adultosMayoresMujeres column: 'dtornamj'
            adultosMayoresHombres column: 'dtornahh'
            discapacitados column: 'dtornsds'
            discapacitadosMujeres column: 'dtordsmj'
            discapacitadosHombres column: 'dtordshh'
            usuariosBono column: 'dtornmbn'
            usuariosBonoMujeres column: 'dtornmbm'
            usuariosBonoHombres column: 'dtornmbh'
            usuariosCredito column: 'dtorncdh'
            usuariosCreditoHombres column: 'dtornchh'
            usuariosCreditoMujeres column: 'dtorncmj'
            mujeresCabezaHogar column: 'dtornmch'
        }
    }
    static constraints = {
        unidadEjecutora(blank:false, nullable: false)
        financiera(size: 1..127, blank: true, nullable: true, attributes: [title: 'financiera'])
        cuenta(size: 1..20, blank: true, nullable: true, attributes: [title: 'cuenta'])
        tipoCuenta(blank: true, nullable: true, attributes: [title: 'tipocuenta'])
        legales(blank: true, nullable: true)
        noLegales(blank: true, nullable: true)
        familiasLegales(blank: true, nullable: true)
        familiasNoLegales(blank: true, nullable: true)
        socios(blank: true, nullable: true)
        mujeresSocias(blank: true, nullable: true)
        hombresSocios(blank: true, nullable: true)
        jovenes(blank: true, nullable: true)
        obreros(blank: true, nullable: true)
        dirigentes(blank: true, nullable: true)
        dirigentesMujeres(blank: true, nullable: true)
        dirigentesHombres(blank: true, nullable: true)
        sociosJovenes(blank: true, nullable: true)
        sociosJovenesHombres(blank: true, nullable: true)
        sociosJovenesMujeres(blank: true, nullable: true)
        adultosMayores(blank: true, nullable: true)
        adultosMayoresHombres(blank: true, nullable: true)
        adultosMayoresMujeres(blank: true, nullable: true)
        discapacitados(blank: true, nullable: true)
        discapacitadosMujeres(blank: true, nullable: true)
        discapacitadosHombres(blank: true, nullable: true)
        usuariosBono(blank: true, nullable: true)
        usuariosBonoHombres(blank: true, nullable: true)
        usuariosBonoMujeres(blank: true, nullable: true)
        usuariosCredito(blank:true, nullable:true)
        usuariosCreditoHombres(blank:true, nullable:true)
        usuariosCreditoMujeres(blank:true, nullable:true)
        mujeresCabezaHogar(blank:true, nullable:true)
    }
}
