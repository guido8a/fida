package modificaciones

import parametros.Anio
import parametros.proyectos.Fuente
import poa.Asignacion
import poa.Presupuesto
import proyectos.MarcoLogico
import seguridad.UnidadEjecutora

class DetalleReforma {

    /**
     * Reforma a la que pertenece el detalle
     */
    Reforma reforma
    /**
     * Asignación de origen
     */
    Asignacion asignacionOrigen
    /**
     * Asignación de destino
     */
    Asignacion asignacionDestino
    /**
     * Presupuesto de la nueva asignación que genera la actividad
     */
    Presupuesto presupuesto
    /**
     * Nueva actividad componente, en el caso de ajuste de techos es la actividad
     */
    MarcoLogico componente
    /**
     * Tipo de reforma
     */
    TipoReforma tipoReforma
    /**
     * Valor
     */
    Double valor
    /**
     * Descripción de la nueva actividad --la fuente es la misma de la asignación de origen
     */
    String descripcionNuevaActividad
    /**
     * Saldo para usarse en incrementos
     */
    Double saldo = 0
    /**
     * Fuente para la nueva partida
     */
    Fuente fuente
    /**
     * Detalle original (para las modificaciones de incremento cuando ya se les asigna un origen)
     */
    DetalleReforma detalleOriginal
    /**
     * Valor de la asignación de origen al momento de realizar la solicitud
     */
    Double valorOrigenInicial
    /**
     * Valor de la asignación de destino al momento de realizar la solicitud
     */
    Double valorDestinoInicial

    /**
     * Solicitado
     */
    String solicitado

    Anio anio

    UnidadEjecutora responsable

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'dtrf'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dtrf__id'
        id generator: 'identity'
        version false
        columns {
            reforma column: 'rfrm__id'
            asignacionOrigen column: 'asgn__id'
            asignacionDestino column: 'asgndstn'
            presupuesto column: 'prsp__id'
            componente column: 'mrlg__id'
            valor column: 'dtrfvlor'
            descripcionNuevaActividad column: 'dtrfactv'
            saldo column: 'dtrfsldo'
            detalleOriginal column: 'dtrfdtrf'
            valorOrigenInicial column: 'dtrfvloi'
            valorDestinoInicial column: 'dtrfvldi'
            tipoReforma column: 'tprf__id'
            fuente column: 'fnte__id'
            solicitado column: 'dtrfslct'
            anio column: 'anio__id'
            responsable column: 'unej__id'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        asignacionOrigen nullable: true
        asignacionDestino nullable: true
        presupuesto nullable: true
        componente nullable: true
        descripcionNuevaActividad nullable: true
        detalleOriginal nullable: true
        tipoReforma nullable: true
        fuente nullable: true
        anio nullable: false
        responsable nullable: true
        solicitado blank: true, nullable: true, size: 1..1
    }
}
