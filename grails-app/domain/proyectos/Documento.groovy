package proyectos

import audita.Auditable
import convenio.Convenio
import parametros.proyectos.GrupoProcesos

/*Es toda documentación importante que debe ser archivada en el proyecto. Este comprende el archivo de proyecto o el archivo de casos de proyecto.
Se usará preferentemente formato pdf, pero pueden incluirse otros formatos aunque no puedan ser visualizados desde el sistema.*/
/**
 * Clase para conectar con la tabla 'dcmt' de la base de datos<br/>
 * Es toda documentación importante que debe ser archivada en el proyecto.
 * Esta comprende el archivo de proyecto o el archivo de casos de proyecto.
 * Se usará preferentemente formato pdf, pero pueden incluirse otros formatos aunque no puedan ser visualizados desde el sistema.
 */
class Documento implements Auditable {
    /**
     * Proyecto al cual pertenece el documento
     */
    Proyecto proyecto

    Convenio convenio
    /**
     * Grupo de procesos del documento
     */
    GrupoProcesos grupoProcesos
    /**
     * Descripción del documento
     */
    String descripcion
    /**
     * Palabras claves del documento
     */
    String clave
    /**
     * Resumen del documento
     */
    String resumen
    /**
     * Path del archivo del documento
     */
    String documento

    /**
     * Define los campos que se van a ignorar al momento de hacer logs
     */
    static auditable = true

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'dcmt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'dcmt__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'dcmt__id'
            proyecto column: 'proy__id'
            convenio column: 'cnvn__id'
            grupoProcesos column: 'grpr__id'
            descripcion column: 'dcmtdscr'
            clave column: 'dcmtclve'
            resumen column: 'dcmtrsmn'
            documento column: 'dcmtdcmt'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        proyecto(blank: true, nullable: true, attributes: [mensaje: 'Proyecto'])
        convenio(blank: true, nullable: true, attributes: [mensaje: 'Convenio'])
        grupoProcesos(blank: true, nullable: true, attributes: [mensaje: 'Grupo de Procesos'])
        descripcion(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Descripción del documento'])
        clave(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Palabras clave'])
        resumen(size: 1..1024, blank: true, nullable: true, attributes: [mensaje: 'Resumen'])
        documento(size: 1..255, blank: true, nullable: true, attributes: [mensaje: 'Ruta del documento'])
    }

    /**
     * Genera un string para mostrar
     * @return la descripción
     */
    String toString() {
        return this.descripcion
    }
}