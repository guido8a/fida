package poa

import audita.Auditable
import modificaciones.DetalleReforma
import seguridad.Firma
import seguridad.Persona
import seguridad.UnidadEjecutora


/*La modificación de la asignación presupuestaria se refiere a la redistribución del valor asignado lo cual implica además una reprogramación.*/
/**
 * Clase para conectar con la tabla 'mdas' de la base de datos<br/>
 * La modificación de la asignación presupuestaria se refiere a la redistribución del valor asignado
 * lo cual implica además una reprogramación
 */
class ModificacionAsignacion implements Auditable {
    /**
     * Asignación que envía
     */
    Asignacion desde
    /**
     * Asignación que recibe
     */
    Asignacion recibe
    /**
     * Detalle de reforma que originó esta modificación
     */
    DetalleReforma detalleReforma
    /**
     * Usuario que realiza la modificacion
     */
    Persona usuario
    /**
     * Modificación proyecto
     */
//    ModificacionProyecto modificacionProyecto
    /**
     * Primera firma de aprobación
     */
    Firma firma1
    /**
     * Segunda firma de aprobación
     */
    Firma firma2
    /**
     * Fecha
     */
    Date fecha
    /**
     * Valor
     */
    double valor
    /**
     * Numero de la modificacion
     */
    Integer numero = 0
    /**
     * Estado: P = pendiente, A = aprobado
     */
    String estado = 'P'
//    /**
//     * Path al archivo PDF
//     */
//    String pdf
//    /**
//     * Unidad ejecutora
//     */
    UnidadEjecutora unidad
    /**
     * Texto para el pdf
     */
    String textoPdf
    /**
     * Valor inicial de la asignación de origen
     */
    Double originalOrigen = 0
    /**
     * Valor inicial de la asignación de destino
     */
    Double originalDestino = 0

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = true

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'mdas'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mdas__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'mdas__id'
            usuario column: 'prsn__id'
            desde column: 'asgndsde'
            recibe column: 'asgnrcbe'
//            modificacionProyecto column: 'mdfc__id'
            fecha column: 'mdasfcha'
            valor column: 'mdasvlor'
            unidad column: 'unej__id'
            firma1 column: 'frma_id1'
            firma2 column: 'frma_id2'
            estado column: 'mdasetdo'
            numero column: 'mdasnmro'
            textoPdf column: 'mdastxpd'
            textoPdf type: 'text'
            detalleReforma column: 'dtrf__id'
            originalOrigen column: 'mdasoror'
            originalDestino column: 'mdasords'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        desde(blank: true, nullable: true, attributes: [mensaje: 'Asignación desde donde sale dinero'])
        recibe(blank: true, nullable: true, attributes: [mensaje: 'Asignación que recibe el dinero'])
//        modificacionProyecto(blank: true, nullable: true, attributes: [mensaje: 'Modificación'])
        fecha(blank: true, nullable: true, attributes: [mensaje: 'Fecha'])
        valor(blank: true, nullable: true, attributes: [mensaje: 'Valor redistribuido, siempre en positivo'])
//        pdf(blank: true, nullable: true, size: 1..250)
        unidad(blank: true, nullable: true)
        firma1(blank: true, nullable: true)
        firma2(blank: true, nullable: true)
        estado(blank: true, nullable: true, maxSize: 1)
        textoPdf(blank: true, nullable: true)
        usuario(blank: true, nullable: true)
    }
}