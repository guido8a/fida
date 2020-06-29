package geografia

/**
 * Clase para conectar con la tabla 'cntn' de la base de datos<br/>
 * Guarda la lista de cantones por provincia y por zona
 */
class Canton   {
    /**
     * Provincia a la cual pertenece el cantón
     */
    Provincia provincia
    Integer numero
    String nombre

    /**
     * Posición geográfica del cantón (longitud para ubicar en un mapa)
     */
    double longitud
    /**
     * Posición geográfica del cantón (latitud para ubicar en un mapa)
     */
    double latitud


//    static auditable = false

    /**
     * Define el mapeo entre los campos del dominio y las columnas de la base de datos
     */
    static mapping = {
        table 'cntn'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'cntn__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'cntn__id'
            provincia column: 'prov__id'
            numero column: 'cntnnmro'
            nombre column: 'cntnnmbr'
            longitud column: 'cntnlong'
            latitud column: 'cntnlatt'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        provincia(blank: true, nullable: true, attributes: [mensaje: 'Provincia a la que pertenece el cantón'])
        numero(blank: true, nullable: true, attributes: [mensaje: 'Número del cantón'])
        nombre(size: 1..63, blank: true, nullable: true, attributes: [mensaje: 'Nombre del cantón'])
    }

    /**
     * Genera un string para mostrar
     * @return el nombre
     */
    String toString() {
        return this.nombre
    }
}