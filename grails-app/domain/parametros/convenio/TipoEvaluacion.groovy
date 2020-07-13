package parametros.convenio

class TipoEvaluacion {
    /**
     * Descripción del tipo de elemento
     */
    String descripcion

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = false

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'tpev'
        version false
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'tpev__id'
        id generator: 'identity'
        columns {
            id column: 'tpev__id'
            descripcion column: 'tpevdscr'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        descripcion(size: 1..15, blank: true, nullable: true, attributes: [mensaje: 'Descripción del tipo de evaluación'])
    }
}