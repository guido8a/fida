package poa

import parametros.Anio
import parametros.proyectos.Fuente
import proyectos.MarcoLogico
import seguridad.UnidadEjecutora


/**
 * Clase para conectar con la tabla 'asgn' de la base de datos
 */
class Asignacion {
    /**
     * Año de la asignación
     */
    Anio anio
    /**
     * Fuente de la asignación
     */
    Fuente fuente
    /**
     * Marco lógico de la asignación
     */
    MarcoLogico marcoLogico
    /**
     * Unidad ejecutora de la asignación
     */
    UnidadEjecutora unidad
    /**
     * Presupuesto de la asignación
     */
    Presupuesto presupuesto
    /**
     * Asignación padre de la asignación actual
     */
    Asignacion padre
    /**
     * Valor planificado de la asignación
     */
    double planificado
    /**
     * Actividad de la asignación
     */
    String actividad
    /**
     * Valor priorizado de la asignación
     */
    double priorizado = 0
    /**
     * Valor priorizado original
     */
    Double priorizadoOriginal = 0
    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]
    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'asgn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'asgn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'asgn__id'
            anio column: 'anio__id'
            fuente column: 'fnte__id'
            marcoLogico column: 'mrlg__id'
            actividad column: 'asgnactv'
            presupuesto column: 'prsp__id'
            planificado column: 'asgnplan'
            unidad column: 'unej__id'
            padre column: 'asgnpdre'
            priorizado column: 'asgnprio'
            priorizadoOriginal column: 'asgnpror'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        anio(blank: true, nullable: true, attributes: [mensaje: 'Año o “ejercicio”'])
        fuente(blank: true, nullable: true, attributes: [mensaje: 'Fuente de financiamiento'])
        marcoLogico(blank: true, nullable: true, attributes: [mensaje: 'Actividad del marco lógico'])
        actividad(blank: true, nullable: true, size: 1..1024, attributes: [mensaje: 'Actividad de gasto corriente'])
        presupuesto(blank: true, nullable: true, attributes: [mensaje: 'Partida presupuestaria'])
        planificado(blank: true, nullable: true, attributes: [mensaje: 'Planificado'])
        unidad(blank: true, nullable: true)
        padre(blank: true, nullable: true)
        priorizado(blank: true, nullable: true)
        priorizadoOriginal(blank: true, nullable: true)
    }

    /**
     * Genera un string para mostrar
     * @return si la asignación tiene marco lógico: el responsable, el monto, el presupuesto, el año concatenados<br/>
     * caso contrario, el monto, el presupuesto, el año concatenados
     */
    String toString() {
        if (this.marcoLogico) {
//            "<b>Responsable:</b> ${this.unidad}<b>  Priorizado: </b>${this.planificado}  <b> Partida Presupuestaria: </b>${this.presupuesto}<b> Año</b>: ${this.anio}"
            "<b>Priorizado: </b>${this.planificado}  <b> Partida Presupuestaria: </b>${this.presupuesto}"
        } else {
            "<b> Priorizado:</b> ${this.planificado}  <b> Partida Presupuestaria: </b>${this.presupuesto}<b> Año</b>: ${this.anio}"
        }
    }

    String getString() {
        if (this.marcoLogico) {
//            "<b>Responsable:</b> ${this.unidad}<b>  Priorizado: </b>${this.planificado}  <b> Partida Presupuestaria: </b>${this.presupuesto}<b> Año</b>: ${this.anio}"
            "<b>Priorizado: </b>${this.priorizado}  <b> Partida Presupuestaria: </b>${this.presupuesto}"
        } else {
            "<b> Priorizado:</b> ${this.priorizado}  <b> Partida Presupuestaria: </b>${this.presupuesto}<b> Año</b>: ${this.anio}"
        }
    }

    String getStringCorriente() {
        if (this.marcoLogico) {
            return "<b>Priorizado: </b>${this.priorizado}  <b> Partida Presupuestaria: </b>${this.presupuesto}"
        } else {
            return "<b> Priorizado:</b> ${this.priorizado}  <b> Partida Presupuestaria: </b>${this.presupuesto}"
        }
    }

    /**
     * Calcula el valor de los hijos de la asignación
     * @param asg asignación
     * @return el valor de los hijos
     */
    def getValorHijo(asg) {
        // println "get valor hijo "+asg.id
        def hijos = Asignacion.findAllByPadre(asg)
        //println "hijos "+hijos
        def val = 0
        hijos.each {
            val += getValorHijo(it)
        }
        // println "return "+(val+asg.planificado)
        val = val + getValorSinModificacion(asg)
//        println "valor hijo "+asg.id+"  --> "+val
//        println ""
        return val
    }

    /**
     * Calcula el valor real de la asignación teniendo en cuenta la reubicación
     * @return el valor real calculado
     */
//    def getValorReal() {
//        if (this.reubicada == "S") {
//            if (this.planificado == 0) {
//                return this.planificado
//            }
//            def dist = DistribucionAsignacion.findAllByAsignacion(this)
//
//            def valor = this.planificado
//            Asignacion.findAllByPadreAndUnidadNotEqual(this, this.marcoLogico.proyecto.unidadEjecutora, [sort: "id"]).each { hd ->
//                valor += getValorHijo(hd)
//            }
//
//            def vs = 0
//            def mas = ModificacionAsignacion.findAllByDesde(this)
//            def menos = ModificacionAsignacion.findAllByRecibe(this)
//
//            mas.each {
//
//                if (it.recibe?.padre?.id == it.desde.id) {
//                    vs += it.valor
//                }
//            }
//            valor += vs
//            dist.each {
//                valor = valor - it.valor
//            }
//
//            if (valor > this.planificado) {
//                valor = this.planificado
//            }
//            if (valor < 0) {
//                valor = 0
//            }
//
//            return valor
//        } else {
//            return this.planificado
//        }
//
//    }

}