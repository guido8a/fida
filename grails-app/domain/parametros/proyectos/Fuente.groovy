package parametros.proyectos
/*Fuente de financiamiento del proyecto, puede ser estado, préstamo a organismos internacionales, aporte propio, etc.*/
/**
 * Clase para conectar con la tabla 'fnte' de la base de datos<br/>
 * Fuente de financiamiento del proyecto, puede ser estado, préstamo a organismos internacionales, aporte propio, etc.
 */
class Fuente {
    /**
     * Descripción de la fuente
     */
    String descripcion
    /**
     * Código de la fuente
     */
    String codigo
    /**
     * Porcentaje del desembolso
     */
    double porcentaje

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = false

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
//        table 'fnte'
        table 'fnte'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'fnte__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'fnte__id'
            codigo column: 'fntecdgo'
            descripcion column: 'fntedscr'
            porcentaje column: 'fntepcnt'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        codigo(size: 1..3, blank: true, nullable: true, attributes: [mensaje: 'Código fuente de financiamiento del proyecto'])
        descripcion(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Descripción de la fuente de financiamiento del proyecto'])
        porcentaje(blank:true, nullable:true)
    }

    /**
     * Genera un string para mostrar
     * @return la descripción
     */
    String toString() {
        "${this.descripcion}"
    }
}