package proyectos

import audita.Auditable

class ModificacionMarcoLogico implements Auditable {

    MarcoLogico marcoLogico
    int numero
    Date fecha
    String objetivo
    double monto
    int porcentaje

    static mapping = {
        table 'mdml'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'mdml__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'mdml__id'
            marcoLogico column: 'mrlg__id'
            numero column: 'mdmlnmro'
            fecha column: 'mdmlfcha'
            objetivo column: 'mdmlobjt'
            monto column: 'mdmlmnto'
            porcentaje column: 'mdmlpcap'
        }
    }

    /**
     * Define las restricciones de cada uno de los campos
     */
    static constraints = {
        marcoLogico(blank: false, nullable: false)
        monto(blank: false, attributes: [mensaje: 'Monto'])
        fecha(blank:false, nullable: false)
        objetivo(blank:false, nullable: false)
        numero(blank:true, nullable: true)
        porcentaje(blank:true, nullable: true)
    }
}
