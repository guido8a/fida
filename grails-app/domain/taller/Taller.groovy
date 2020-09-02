package taller

import audita.Auditable
import geografia.Comunidad
import geografia.Parroquia
import seguridad.UnidadEjecutora

class Taller implements Auditable {

    Parroquia parroquia
    Comunidad comunidad
    UnidadEjecutora unidadEjecutora
    UnidadEjecutora unidadEps
    TipoTaller tipoTaller
//    Institucion institucion
    Capacidad capacidad
//    String codigo
    String nombre
    String objetivo
    Date fecha
    Date fechaInicio
    Date fechaFin
    Double valor = 0.0
    String instructor
    String documento
    String modulo
    String fichaTecnica
    String observaciones

    static auditable = true

    def permisos = []

    static mapping = {
        table 'tllr'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'tllr__id'
            parroquia column: 'parr__id'
            comunidad column: 'cmnd__id'
            unidadEjecutora column: 'unej__id'
            unidadEps column: 'unej_eps'
            tipoTaller column: 'tptl__id'
//            institucion column: 'inst__id'
            capacidad column: 'cpcd__id'
//            codigo column: 'tllrcdgo'
            nombre column: 'tllrnmbr'
            objetivo column: 'tllrobjt'
            fecha column: 'tllrfcha'
            fechaInicio column: 'tllrfcin'
            fechaFin column: 'tllrfcfn'
            valor column: 'tllrvlor'
            instructor column: 'tllrinst'
            documento column: 'tllrdcmt'
            modulo column: 'tllrmdlo'
            fichaTecnica column: 'tllrfctc'
            observaciones column: 'tllrobsr'
        }
    }
    static constraints = {
        comunidad(blank: true, nullable: true)
        parroquia(blank: false, nullable: false)
        unidadEjecutora(blank: false, nullable: false)
        unidadEps(blank: false, nullable: false)
        tipoTaller(blank: false, nullable: false)
//        institucion(blank: true, nullable: true)
        capacidad(blank: true, nullable: true)
//        codigo(blank: true, nullable: true)
        nombre(size: 3..255, blank: false)
        objetivo(blank: false)
        fecha(blank: true, nullable: true, attributes: [title: 'Fecha de inicio'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'Fecha de inicio'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'Fecha de finalización'])
        valor(blank: true, nullable: true)
        instructor(blank: true, nullable: true)
        documento(blank: true, nullable: true)
        modulo(blank: true, nullable: true)
        observaciones(blank: true, nullable: true)
        fichaTecnica(blank: true, nullable: true)
    }

    String toString() {
        "${this.nombre}"
    }

}
