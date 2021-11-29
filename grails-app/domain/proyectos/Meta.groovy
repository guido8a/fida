package proyectos

import audita.Auditable
import parametros.proyectos.IndicadorOrms
import parametros.proyectos.Unidad
import geografia.Parroquia

/*Para cada componente se determinan las metas desagregadas conforme al marco lógico. */
/**
 * Clase para conectar con la tabla 'meta' de la base de datos<br/>
 * Para cada componente se determinan las metas desagregadas conforme al marco lógico.
 */
class Meta implements Auditable{
    /**
     * Unidad a la cual pertenece la meta
     */
    Unidad unidad
    /**
     * Indicador orms de la meta
     */
    IndicadorOrms indicadorOrms
    /**
     * Descripción de la meta
     */
    String descripcion
    /**
     * Indicador
     */
    Indicador indicador

    int lineaBase = 0
    int disenio = 0
    int restructuracion  = 0

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = true

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
            unidad column: 'undd__id'
            indicadorOrms column: 'orms__id'
            indicador column: 'indi__id'
            descripcion column: 'metadscr'
            lineaBase column: 'metalnbs'
            disenio column: 'metadise'
            restructuracion column: 'metarest'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        unidad(blank: true, nullable: true, attributes: [mensaje: 'Unidad de medida'])
        indicadorOrms(blank: true, nullable: true, attributes: [mensaje: 'Indicador orms'])
        indicador(blank: true, nullable: true, attributes: [mensaje: 'Indicador'])
        lineaBase(blank: true, nullable: true, attributes: [mensaje: 'Indicador orms'])
        restructuracion(blank: true, nullable: true, attributes: [mensaje: 'Indicador orms'])
        disenio(blank: true, nullable: true, attributes: [mensaje: 'Indicador orms'])
        descripcion(size: 1..255, blank: false, nullable: false, attributes: [mensaje: 'Descripción de la meta a alcanzar'])
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