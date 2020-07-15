package poa

import parametros.Mes
import proyectos.Cronograma


/*Programación de la asignación presupuestaria por cuatrimestres.*/
/**
 * Clase para conectar con la tabla 'pras' de la base de datos<br/>
 * Programación de la asignación presupuestaria por cuatrimestres.
 */
class ProgramacionAsignacion {
    Asignacion asignacion
    Mes mes
    Cronograma cronograma
    double valor
    int estado = 0

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'pras'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'pras__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'pras__id'
            asignacion column: 'asgn__id'
            mes column: 'mess__id'
            valor column: 'messvlor'
            estado column: 'prasetdo'
            cronograma column: 'crng__id'
        }
    }
    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        asignacion(blank: true, nullable: true, attributes: [mensaje: 'Asignación'])
        mes(blank: false, nullable: false, attributes: [mensaje: 'Cuatrimestre'])
        valor(blank: true, nullable: true, attributes: [mensaje: 'Valor asignado al cuatrimestre'])
        estado(blank: false, nullable: false, attributes: [mensaje: 'estado de la asignación'])
        cronograma(blank: true, nullable: true)
    }
}