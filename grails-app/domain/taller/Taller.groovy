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
    Institucion institucion
    Capacidad capacidad

//    String codigo
    String nombre
    String objetivo
    Date fecha
    Date fechaInicio
    Date fechaFin
    Double valor = 0.0
    String instructor

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
            institucion column: 'inst__id'
            capacidad column: 'cpcd__id'
//            codigo column: 'tllrcdgo'
            nombre column: 'tllrnmbr'
            objetivo column: 'tllrobjt'
            fecha column: 'tllrfcha'
            fechaInicio column: 'tllrfcin'
            fechaFin column: 'tllrfcfn'
            valor column: 'tllrvlor'
            instructor column: 'tllrinst'
        }
    }
    static constraints = {
        comunidad(blank: true, nullable: true)
        parroquia(blank: false, nullable: false)
        unidadEjecutora(blank: false, nullable: false)
        unidadEps(blank: false, nullable: false)
        tipoTaller(blank: false, nullable: false)
        institucion(blank: true, nullable: true)
        capacidad(blank: false, nullable: false)
//        codigo(size: 0..15, blank: true, nullable: false)
        nombre(size: 3..255, blank: false)
        objetivo(blank: false)
        fecha(blank: false, nullable: false, attributes: [title: 'Fecha de inicio'])
        fechaInicio(blank: true, nullable: true, attributes: [title: 'Fecha de inicio'])
        fechaFin(blank: true, nullable: true, attributes: [title: 'Fecha de finalización'])
        valor(blank: false, nullable: false)
        instructor(blank: false, nullable: false)
    }

    String toString() {
        "${this.nombre}"
    }

}
