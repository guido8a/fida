package parametros

import audita.Auditable

/*Año al cual corresponde el PAPP, cada año debe iniciarse una nueva gestión de proyectos. Es similar al período contable o año fiscal.*/
/**
 * Clase para conectar con la tabla 'anio' de la base de datos<br/>
 * Año al cual corresponde el PAPP, cada a&ntildeo debe iniciarse una nueva
 * gestión de proyectos. Es similar al periodo contable o año fiscal
 */
class Anio implements Auditable {
    /**
     * Número de año
     */
    String anio
    /**
     * Estado del año: 0: no aprobado, 1: aprobado
     */
    int estado = 0 /* 0 -> no aprobado    1-> aprobadp */
    /**
     * Estado del año para gasto permanente: 0: no aprobado, 1: aprobado
     */
    int estadoGp = 0 /* 0 -> no aprobado    1-> aprobadp */

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = true

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'anio'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'anio__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'anio__id'
            anio column: 'anioanio'
            estado column: 'anioetdo'
            estadoGp column: 'anioedgp'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        anio(size: 1..4, blank: false, attributes: [mensaje: 'Año al cual corresponde el POA'])
        estado(blank: false, nullable: false)
        estadoGp(blank: false, nullable: false)
    }

    /**
     * Genera un string para mostrar
     * @return el número del año
     */
    String toString() {
        "${this.anio}"
    }
}