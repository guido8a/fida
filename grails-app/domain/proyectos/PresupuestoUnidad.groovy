package proyectos

import audita.Auditable
import parametros.Anio
import seguridad.UnidadEjecutora

/**
 * Clase para conectar con la tabla 'prue' de la base de datos
 */
class PresupuestoUnidad implements Auditable{
    /**
     * Unidad ejecutora del presupuesto
     */
    UnidadEjecutora unidad
    /**
     * Año del presupuesto
     */
    Anio anio
    /**
     * Máximo de invesriones
     */
    double maxInversion
    /**
     * Máximo de corrientes
     */
    double maxCorrientes
    /**
     * Valor original de corrientes
     */
    double originalCorrientes = 0
    /**
     * Valor original de inversiones
     */
    double originalInversion = 0
    /**
     * Está o no aprobado corrientes
     */
    int aprobadoCorrientes = 0
    /**
     * Está o no aprobado inversión
     */
    int aprobadoInversion = 0

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = true

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'prue'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prue__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'prue__id'
            unidad column: 'unej__id'
            anio column: 'anio__id'
            maxInversion column: 'pruemxiv'
            maxCorrientes column: 'pruemxcr'
            aprobadoCorrientes column: 'prueapcr'
            aprobadoInversion column: 'prueapin'
            originalCorrientes column: 'prueorcr'
            originalInversion column: 'prueorin'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        unidad(nullable: false, blank: false)
        anio(nullable: false, blank: false)
        maxInversion(nullable: false, blank: false)
        maxCorrientes(nullable: false, blank: false)
    }

    /**
     * Genera un string para mostrar
     * @return el año, el máximo de invesriones y máximo de corrientes concatenados
     */
    String toString() {
        "${this.anio}:${this.maxInversion}:${this.maxCorrientes}"
    }
}
