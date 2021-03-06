package proyectos

import audita.Auditable
import parametros.Anio
import parametros.Mes
import parametros.proyectos.Fuente
import poa.Presupuesto


/*El cronograma valorado se registra por actividades del marco lógico, por año, mes y fuente de financiamiento.*/
/**
 * Clase para conectar con la tabla 'crng' de la base de datos<br/>
 * El cronograma valorado se registra por actividades del marco lógico, por año, mes y fuente de financiamiento
 */
class Cronograma implements Auditable  {
    /**
     * Mes del cronograma
     */
    Mes mes
    /**
     * Marco lógico del cronograma
     */
    MarcoLogico marcoLogico
    /**
     * Fuente del cronograma
     */
    Fuente fuente
    /**
     * Fuente del cronograma 2
     */
    Fuente fuente2
    /**
     * Año del cronograma
     */
    Anio anio
    /**
     * Presupuesto del cronograma
     */
    Presupuesto presupuesto
    /**
     * Presupuesto 2 del cronograma
     */
    Presupuesto presupuesto2
    /**
     * Valor del cronograma
     */
    double valor
    /**
     * Valor 2 del cronograma
     */
    double valor2

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = true

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'crng'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'crng__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'crng__id'
            mes column: 'mess__id'
            marcoLogico column: 'mrlg__id'
            fuente column: 'fnte__id'
            fuente2 column: 'fnte2_id'
            anio column: 'anio__id'
            presupuesto column: 'prsp__id'
            presupuesto2 column: 'prsp2_id'
            valor column: 'crngvlor'
            valor2 column: 'crngvl02'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        mes(blank: true, nullable: true, attributes: [mensaje: 'Mes'])
        marcoLogico(blank: true, nullable: true, attributes: [mensaje: 'Actividad del marco lógico'])
        fuente(blank: true, nullable: true, attributes: [mensaje: 'Fuente'])
        fuente2(blank: true, nullable: true, attributes: [mensaje: 'Fuente2'])
        anio(blank: true, nullable: true, attributes: [mensaje: 'Año'])
        presupuesto(nullable: false, blank: false)
        presupuesto2(nullable: true, blank: true)
        valor(blank: true, nullable: true, attributes: [mensaje: 'Valor a ejecutarse en el mes'])
        valor2(blank: true, nullable: true, attributes: [mensaje: 'Valor a ejecutarse en el mes'])
    }
}