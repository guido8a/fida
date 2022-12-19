package seguridad

import audita.Auditable
import geografia.Parroquia
import geografia.Provincia
import parametros.Anio
import poa.Asignacion
import proyectos.MarcoLogico
import proyectos.Proyecto
import taller.TipoOrganizacion

class UnidadEjecutora implements Auditable{

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
    int zona = 0
    int orden = 0
    Parroquia parroquia
    String referencia
    String legal
    String ruc
    String rup
    int anio = 0
    String sector
    String institucion
    String actividad
    String actividadSecundaria
    String fortaleza
    TipoOrganizacion tipoOrganizacion
    String plan
    String fortalecimiento
    String financiacion

    static auditable = true

    static mapping = {
        table 'unej'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'unej__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'unej__id'
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
            zona column: 'unejnmsr'
            orden column: 'unejordn'
            parroquia column: 'parr__id'
            referencia column: 'unejrefe'
            legal column: 'unejlgal'
            ruc column: 'unej_ruc'
            rup column: 'unej_rup'
            anio column: 'unejanio'
            sector column: 'unejsctr'
            institucion column: 'unejinst'
            actividad column: 'unejactv'
            actividadSecundaria column: 'unejacsc'
            fortaleza column: 'unejfort'
            tipoOrganizacion column: 'tpor__id'
            plan column: 'unej_pns'
            fortalecimiento column: 'unej_pfi'
            financiacion column: 'unej_fin'

        }
    }
    static constraints = {
        nombre(size: 1..255, blank: false, nullable: false, attributes: [title: 'nombre'])
        codigo(size: 1..4, blank: true, nullable: true, attributes: [title: 'codigo'])
        direccion(size: 1..127, blank: true, nullable: true, attributes: [title: 'direccion'])
        sigla(size: 0..7, blank: true, nullable: true, attributes: [title: 'sigla'])
        objetivo(size: 0..255, blank: true, nullable: true, attributes: [title: 'objetivo'])
        telefono(size: 0..63, blank: true, nullable: true, attributes: [title: 'telefono'])
        observaciones(size: 0..127, blank: true, nullable: true, attributes: [title: 'observaciones'])
        zona(blank: true, nullable: true, attributes: [title: 'numero'])
        orden(blank: true, nullable: true, attributes: [title: 'orden'])
        padre(blank: true, nullable: true)
        mail(blank: true, nullable: true)
        fechaInicio(blank: true, nullable: true)
        fechaFin(blank: true, nullable: true)
        parroquia(blank:true, nullable: true)
        referencia(size: 1..255, blank: true, nullable: true)
        legal(blank:true, nullable: true)
        ruc(size: 1..13, blank: true, nullable: true)
        rup(size: 1..13, blank: true, nullable: true)
        anio(blank:true, nullable:true)
        tipoInstitucion(blank:true, nullable: true)
        sector(size: 0..127,blank: true, nullable: true)
        provincia(blank:true, nullable:true)
        institucion(blank: true, nullable: true)
        actividad(blank: true, nullable: true)
        actividadSecundaria(blank: true, nullable: true)
        fortaleza(blank: true, nullable: true)
        tipoOrganizacion(blank: false, nullable: false)
        plan(blank: true, nullable: true)
        fortalecimiento(blank: true, nullable: true)
        financiacion(blank: true, nullable: true)
    }

    @Override
    String toString() {
        return this.nombre
    }

//    def getUnidadesPorPerfil(String perfilCodigo) {
//        def perfilesAll = ["GAF", "ASPL", "GP", "DP", "OBS"]
//        //gerencia administrativa financiera, Analista de Planificación, Gerencia de Planificación
//        def unidades = []
//        if (perfilesAll.contains(perfilCodigo)) {
//            unidades = UnidadEjecutora.list()
//        } else {
//            def padre = this.padre
//            unidades = [this]
////            def codigosNo = ['343', 'GG', 'GT'] // yachay, Gerencia general, Gerencia tecnica
////            if (!codigosNo.contains(padre.codigo)) {
//                unidades += padre
//                unidades += UnidadEjecutora.findAllByPadre(padre)
////            } else {
////                unidades += UnidadEjecutora.findAllByPadre(this)
////            }
//        }
//
//        println("unidades " + unidades)
//
//        return unidades.unique().sort { it.nombre }
//    }

    def getAsignacionesUnidad(Anio anio, String perfilCodigo) {
//        def unidades = this.getUnidadesPorPerfil(perfilCodigo)
        def unidades = UnidadEjecutora.list()
//        println "unidades: ${unidades.nombre} ${unidades.id}"
        def asignaciones = Asignacion.withCriteria {
            eq("anio", anio)
            inList("unidad", unidades)
            isNotNull("marcoLogico")
        }

        return asignaciones.unique()
    }

    List<Proyecto> getProyectosUnidad(Anio anio, String perfilCodigo) {
//        println "anio " + anio + " perf " + perfilCodigo
        def asignaciones = this.getAsignacionesUnidad(anio, perfilCodigo)
        def proyectos = []
        def proyectos2 = []
        def i

        asignaciones.each { e ->
            i = e.marcoLogico?.proyecto?.id
            if (!proyectos2.contains(i)) {
                proyectos2.add(i)
            }
        }
        proyectos2.each {
            proyectos += Proyecto.get(it)
        }

        return proyectos.unique().sort { it.nombre }
    }

    def getComponentesUnidadProyecto(Anio anio, Proyecto proyecto, String perfilCodigo) {
//        println "anio: $anio, proyecto: ${proyecto.id}, perfil: $perfilCodigo"
        def asignaciones = this.getAsignacionesUnidad(anio, perfilCodigo)
        def componentes = []
        def componentes2 = []

        println("asigna " + asignaciones)

//        println "getComponentesUnidadProyecto asignaciones: ${asignaciones.marcoLogico.objeto}"
        asignaciones.each { f ->
            def p2 = f.marcoLogico.proyecto
            def c2 = f.marcoLogico.marcoLogico.id
            if (p2.id == proyecto.id && !componentes2.contains(c2)) {
                componentes2.add(c2)
            }
        }

        componentes2.each {
            componentes += MarcoLogico.get(it)
        }

        return componentes.unique().sort { it.objeto }
    }

    def getActividadesUnidadComponente(Anio anio, MarcoLogico componente, String perfilCodigo) {
        def asignaciones = this.getAsignacionesUnidad(anio, perfilCodigo)
        def actividades = []
        def actividades2 = []
//        println "asignaciones: ${asignaciones.id}"
        asignaciones.each { b ->
            def c3 = b.marcoLogico.marcoLogico
            def act2 = b.marcoLogico.id
            if (c3.id == componente.id && !actividades2.contains(act2)) {
                actividades2.add(act2)
            }
        }
        actividades2.each {
            actividades += MarcoLogico.get(it)
        }
        return actividades.unique().sort { it.numero }
    }

    def getAsignacionesUnidadActividad(Anio anio, MarcoLogico actividad, String perfilCodigo) {
        def asignaciones = this.getAsignacionesUnidad(anio, perfilCodigo)
        def asg = []
        asignaciones.each { a ->
            def act = a.marcoLogico
            if (act.id == actividad.id && !asg.contains(act)) {
                asg.add(a)
            }
        }
        return asg.unique()
    }


}
