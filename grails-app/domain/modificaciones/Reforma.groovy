package modificaciones

import audita.Auditable
import poa.EstadoAval
import parametros.Anio
import seguridad.Firma
import seguridad.Persona


class Reforma implements Auditable {

    /**
     * El año del POA
     */
    Anio anio
    /**
     * Quien realiza la solicitud
     */
    Persona persona
    /**
     * Estado de la solicitud
     */
    EstadoAval estado
    /**
     * Quien firma la solicitud
     */
    Firma firmaSolicitud
    /**
     * Firma 1 de aprobación
     */
    Firma firma1
    /**
     * Firma 2 de aprobación
     */
    Firma firma2
    /**
     * Concepto, por qué la nueva actividad, objetivo o justificación
     */
    String concepto
    /**
     * Fecha de realización
     */
    Date fecha
    /**
     * Fecha de revisión
     */
    Date fechaRevision
    /**
     * Tipo de reforma: A:ajuste, R:reforma, C:ajuste corriente
     */
    String tipo
    /**
     * Tipo de la solicitud E: existente, A: actividad, P: partida, I: incremento, C: incremento actividad (a nuevas actividades sin origen), T: modificación de techos
     */
    String tipoSolicitud
    /**
     * Texto para párrafo inicial de la reforma o ajuste (PDF)
     */
    String textoPdf
    /**
     * Nota técnica u observaciones
     */
    String nota
    /**
     * Secuencial (número solicitud, depende de la gerencia) generado cuando se aprueba (1ra firma: del gerente)
     */
    Integer numero = 0
    /**
     * Secuencial (número reforma, no depende de nada) generado cuando se aprueba (2da firma de aprobacion)
     */
    Integer numeroReforma = 0
    /**
     * Analista de planificación que revisó la solicitud de reforma
     */
    Persona analista
    /**
     * Director que revisó la solicitud de reforma
     */
    Persona director
    /**
     * Observaciones del director al momento de devolver
     */
    String observacionesDirector
    /**
     * Secuencial (número reforma GP) generado cuando se aprueba (2da firma de aprobacion)
     */
    Integer numeroReformaGp = 0

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = true

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'rfrm'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'rfrm__id'
        id generator: 'identity'
        version false
        columns {
            anio column: 'anio__id'
            persona column: 'prsn__id'
            estado column: 'edav__id'
            firmaSolicitud column: 'frmaslid'
            firma1 column: 'frma1_id'
            firma2 column: 'frma2_id'
            concepto column: 'rfrmcpto'
            fecha column: 'rfrmfcha'
            fechaRevision column: 'rfrmfcrv'
            tipo column: 'rfrmtipo'
            tipoSolicitud column: 'rfrmtprf'   /* ya no se usa */
            textoPdf column: 'rfrm_pdf'
            nota column: 'rfrmnota'
            numero column: 'rfrmnmro'
            numeroReforma column: 'rfrmnmrf'
            analista column: 'rfrmpran'
            director column: 'rfrmprdr'
            observacionesDirector column: 'rfrmobdr'
            observacionesDirector type: 'text'
            numeroReformaGp column: 'rfrmnmgp'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        firmaSolicitud nullable: true
        firma1 nullable: true
        firma2 nullable: true
        fechaRevision nullable: true
        textoPdf blank: true, nullable: true
        nota blank: true, nullable: true
        analista nullable: true
        director nullable: true
        observacionesDirector blank: true, nullable: true
    }

    String getTituloSolicitud() {
        if(this.tipoSolicitud == 'Q') {
            return 'Solicitud de reforma al POA de gasto permanente'
        }
        return (this.tipo == 'R' ? 'Solicitud de reforma' : 'Ajuste') + " al POA" + (this.tipo == 'C' ? ' de gasto permanente' : '')
    }

    String getTituloReforma() {
        if(this.tipoSolicitud == 'Q') {
            return 'Reforma al POA de gasto permanente'
        }
        return (this.tipo == 'R' ? 'Reforma' : 'Ajuste') + " al POA" + (this.tipo == 'C' ? ' de gasto permanente' : '')
    }

    String getTipoString() {
        switch (this.tipo) {
            case "R": return "Reforma"
            case "A": return "Ajuste"
            case "C": return "Ajuste corriente"
            default: return "Tipo no reconocido"
        }
    }

}
