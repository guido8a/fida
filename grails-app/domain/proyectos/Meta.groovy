package proyectos

import parametros.proyectos.IndicadorOrms
import parametros.proyectos.Unidad
import geografia.Parroquia

/*Para cada componente se determinan las metas desagregadas conforme al marco lógico. */
/**
 * Clase para conectar con la tabla 'meta' de la base de datos<br/>
 * Para cada componente se determinan las metas desagregadas conforme al marco lógico.
 */
class Meta {
    /**
     * Unidad a la cual pertenece la meta
     */
    Unidad unidad
    /**
     * Parroquia a la cual pertenece la meta
     */
    Parroquia parroquia
    /**
     * Marco lón de la meta
     */
    MarcoLogico marcoLogico
    /**
     * Indicador orms de la meta
     */
    IndicadorOrms indicadorOrms
    /**
     * Descripción de la meta
     */
    String descripcion
    /**
     * valor de la meta
     */
    double valor

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = [ignore: []]

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'meta'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'meta__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'meta__id'
            parroquia column: 'parr__id'
            marcoLogico column: 'mrlg__id'
            unidad column: 'undd__id'
            indicadorOrms column: 'orms__id'
            descripcion column: 'metadscr'
            valor column: 'metavlor'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        parroquia(blank: false, nullable: false, attributes: [mensaje: 'Parroquia en la cual se verificará la meta'])
        marcoLogico(blank: true, nullable: true, attributes: [mensaje: 'Componente del marco lógico'])
        unidad(blank: true, nullable: true, attributes: [mensaje: 'Unidad de medida'])
        indicadorOrms(blank: true, nullable: true, attributes: [mensaje: 'Indicador orms'])
        descripcion(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Descripción de la meta a alcanzar'])
        valor(blank: false, nullable: false, attributes: [mensaje: 'Valor de la meta'])
    }

    /**
     * Genera un string para mostrar
     * @return la descripción limitada a 20 caracteres
     */
    String toString() {
        if (descripcion.size() > 20) {
            def partes = descripcion.split(" ")
            def cont = 0
            def des = ""
            partes.each {
                cont += it.size()
                if (cont < 22)
                    des += " " + it
            }
            return des + "... "

        } else {
            return "${this.descripcion}"
        }
    }
}