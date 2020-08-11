package proyectos

import audita.Auditable
import parametros.Anio
//import seguridad.UnidadEjecutora

/*Proyecto*/
/**
 * Clase para conectar con la tabla 'proy' de la base de datos
 */
class Proyecto implements Auditable{
    /**
     * Unidad ejecutora del proyecto
     */
//    UnidadEjecutora unidadEjecutora
    /**
     * Código del proyecto
     */
    String codigoProyecto
    /**
     * Fecha de registro del proyecto
     */
    Date fechaRegistro
    /**
     * Fecha de modificación del proyecto
     */
    Date fechaModificacion
    /**
     * Nombre del proyecto
     */
    String nombre
    /**
     * Monto del proyecto
     */
    Double monto
    /**
     * Producto del proyecto
     */
    String producto
    /**
     * Descripción del proyecto
     */
    String descripcion
    /**
     * Fecha de inicio planificada del proyecto
     */
    Date fechaInicioPlanificada
    /**
     * Fecha de inicio real del proyecto
     */
    Date fechaInicio
    /**
     * Fecha de fin planificada del proyecto
     */
    Date fechaFinPlanificada
    /**
     * Fecha de fin real del proyecto
     */
    Date fechaFin
    /**
     * Mes
     */
    Integer mes = 1
    /**
     * Problema del proyecto
     */
    String problema
    /**
     * Información días
     */
    Integer informacionDias = 0
    /**
     * Subprograma del proyecto
     */
    String subPrograma
    /**
     * Aprobado
     */
    String aprobado
    /**
     * Aprobado POA
     */
    String aprobadoPoa
    /**
     * Código ESIGEF del proyecto
     */
    String codigoEsigef

    /**
     * Unidad administradora
     */
//    UnidadEjecutora unidadAdministradora
    /**
     Código
     */
    String codigo
    /**
     * Justificación
     */
    String justificacion
    /**
     * Poblacion beneficiaria del proyecto
     */
    String poblacion
    /**
     * Objetivo general del proyecto
     */
    String objetivoGeneral

    static auditable = true

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'proy'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'proy__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'proy__id'
//            unidadEjecutora column: 'unej__id'
            codigoProyecto column: 'proy_cup'
            fechaRegistro column: 'proyfcrg'
            fechaModificacion column: 'proyfcmf'
            nombre column: 'proynmbr'
            monto column: 'proymnto'
            producto column: 'proyprdt'
            descripcion column: 'proydscr'
            fechaInicioPlanificada column: 'proyfipl'
            fechaInicio column: 'proyfcin'
            fechaFinPlanificada column: 'proyffpl'
            fechaFin column: 'proyfcfn'
            mes column: 'proymess'
            problema column: 'proyprbl'
            informacionDias column: 'proyifdd'
            subPrograma column: 'proysbpr'
            aprobado column: 'proyapbd'
            aprobadoPoa column: 'proyappa'

            codigoEsigef column: 'proysigf'

//            unidadAdministradora column: 'proyunad'
            codigo column: 'proycdgo'
            justificacion column: 'proyjust'

            poblacion column: 'proypbbn'
            objetivoGeneral column: 'proyobgn'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
//        unidadEjecutora(blank: true, nullable: true, attributes: [mensaje: 'Unidad Ejecutora'])
        codigoProyecto(unique: true, size: 1..24, blank: true, nullable: true, attributes: [mensaje: 'CUP (código único del proyecto según la Senplades)'])
        fechaRegistro(blank: true, nullable: true, attributes: [mensaje: 'Fecha de Registro en la SENPLADES'])
        fechaModificacion(blank: true, nullable: true, attributes: [mensaje: 'Fecha de Modificación del proyecto'])
        nombre(size: 1..255, blank: false, nullable: false, attributes: [mensaje: 'Nombre del proyecto'])
        monto(blank: true, nullable: true, attributes: [mensaje: 'Monto total del proyecto'])
        producto(size: 1..1023, blank: true, nullable: true, attributes: [mensaje: 'Producto principal del proyecto'])
        descripcion(size: 1..1024, blank: true, nullable: true, attributes: [mensaje: 'Descripción del proyecto'])
        fechaInicioPlanificada(blank: true, nullable: true, attributes: [mensaje: 'Fecha de inicio según el plan o programada'])
        fechaInicio(blank: true, nullable: true, attributes: [mensaje: 'Fecha de Inicio real'])
        fechaFinPlanificada(blank: true, nullable: true, attributes: [mensaje: 'Fecha de finalización según el plan o programada'])
        fechaFin(blank: true, nullable: true, attributes: [mensaje: 'Fecha de finalización real'])
        mes(blank: true, nullable: true, attributes: [mensaje: 'Duración del proyecto en meses'])
        problema(size: 1..1024, blank: true, nullable: true, attributes: [mensaje: 'Problema que ataca el proyecto'])
        informacionDias(blank: true, nullable: true, attributes: [mensaje: 'Periodo de información en días para control de informes que debe enviar el responsable'])
        subPrograma(size: 1..2, blank: true, nullable: true, attributes: [mensaje: 'Subprograma al que pertenece, según el ESIGEF'])
        aprobado(size: 0..1, blank: true, nullable: true, attributes: [mensaje: 'Aprobado o no'])
        aprobadoPoa(size: 0..1, blank: true, nullable: true, attributes: [mensaje: 'Aprobado poa'])

        codigoEsigef(size: 0..3, blank: true, nullable: true, attributes: [mensaje: 'Número proyecto eSIGEF'])

//        unidadAdministradora(blank: true, nullable: true, attributes: [mensaje: 'Unidad administradora'])
        codigo(blank: true, nullable: true, attributes: [mensaje: 'Código'])
        justificacion(size: 0..1023, blank: true, nullable: true, attributes: [mensaje: 'Justificación del Proyecto'])

        poblacion(blank: true, nullable: true, maxSize: 1023, attributes: [mensaje: 'Población beneficiaria'])
        objetivoGeneral(blank: true, nullable: true, maxSize: 1023, attributes: [mensaje: 'Objetivo general'])
    }

    /**
     * Genera un string para mostrar
     * @return el nombre limitado a 20 caracteres
     */
    String toString() {
        if (nombre.size() > 20) {
            def partes = nombre.split(" ")
            def cont = 0
            def des = ""
            partes.each {
                cont += it.size()
                if (cont < 22) {
                    des += " " + it
                }
            }
            return des + "... "

        } else {
            return "${this.nombre}"
        }

    }

    /**
     * Genera un string para mostrar
     * @return el nombre limitado a 40 caracteres
     */
    String toStringMedio() {
        if (nombre.size() > 40) {
            def partes = nombre.split(" ")
            def cont = 0
            def des = ""
            partes.each {
                cont += it.size()
                if (cont < 40) {
                    des += " " + it
                }
            }
            return des + "... "

        } else {
            return "${this.nombre}"
        }

    }

    /**
     * Genera un string para mostrar
     * @return el nombre limitado a 65 caracteres
     */
    String toStringLargo() {
        if (nombre.size() > 65) {
            def partes = nombre.split(" ")
            def cont = 0
            def des = ""
            partes.each {
                cont += it.size()
                if (cont < 65) {
                    des += " " + it
                }
            }
            return des + "... "

        } else {
            return "${this.nombre}"
        }

    }

    /**
     * Genera un string para mostrar
     * @return el nombre completo
     */
    String toStringCompleto() {
        return this.nombre
    }

    /**
     * Busca las metas de un proyecto
     * @return un mapa: [metasCoords: las coordenadas de las metas, metasTotal: las metas]
     */
    def getMetas() {
        def metas = [], metasCoords = []
        MarcoLogico.findAllByProyectoAndTipoElemento(this, TipoElemento.get(2)).each { ml ->
            metas += Meta.findAllByMarcoLogico(ml)
            metasCoords += Meta.withCriteria {
                eq('marcoLogico', ml)
                or {
                    ne('latitud', 0.toDouble())
                    ne('longitud', 0.toDouble())
                }
            }
        }
        return [metasCoords: metasCoords, metasTotal: metas]
    }

    def getValorPriorizado() {
        def total = 0
        def marcos = MarcoLogico.findAllByProyectoAndTipoElemento(this, TipoElemento.get(3))
        if (marcos.size() > 0) {
            marcos.each { m ->
                total += m.getTotalPriorizado()
            }
//            Asignacion.findAllByMarcoLogicoInList(marcos).each { a ->
//                total += a.priorizado
//            }
            return total
        } else {
            return 0
        }
    }

    def getValorPlanificado() {
        def total = 0
        def marcos = MarcoLogico.findAllByProyectoAndTipoElemento(this, TipoElemento.get(3))
        if (marcos.size() > 0) {
            marcos.each { m ->
                total += m.getTotalPlanificado()
            }
            return total
        } else {
            return 0
        }
    }

    def getValorPlanificadoAnio(Anio anio) {
//        println "PROYECTO " + this.nombre
        def total = 0
        def marcos = MarcoLogico.findAllByProyectoAndTipoElemento(this, TipoElemento.get(3))
        if (marcos.size() > 0) {
            marcos.each { m ->
                total += m.getTotalPlanificadoAnio(anio)
            }
//            println "TOTAL = " + total
            return total
        } else {
            return 0
        }
    }

    def getValorPriorizadoAnio(Anio anio) {
//        println "PROYECTO " + this.nombre
        def total = 0
        def marcos = MarcoLogico.findAllByProyectoAndTipoElemento(this, TipoElemento.get(3))
        if (marcos.size() > 0) {
            marcos.each { m ->
                total += m.getTotalPriorizadoAnio(anio)
            }
//            println "TOTAL = " + total
            return total
        } else {
            return 0
        }
    }

}