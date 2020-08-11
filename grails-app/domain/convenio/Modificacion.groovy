package convenio


class Modificacion {

    Plan plan
    Date fechaModificacion
    String descripcion
    double cantidad
    double costo
    Date fechaInicio
    Date fechaFin

    static mapping = {
        table 'mdcv'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'mdcv__id'
            plan column: 'plan__id'
            fechaModificacion column: 'mdcvfcha'
            descripcion column: 'mdcvdscr'
            cantidad column: 'mdcvcntd'
            costo column: 'mdcvcsto'
            fechaInicio column: 'mdcvfcin'
            fechaFin column: 'mdcvfcfn'
        }
    }

    static constraints = {
        plan(nullable: false, blank: false)
        fechaModificacion(nullable: false, blank:false)
        descripcion(size: 1..1023, nullable: false, blank:false)
        cantidad(nullable: false, blank: false)
        costo(nullable: false, blank: false)
        fechaInicio(nullable: true, blank: true)
        fechaFin(nullable: true, blank: true)
    }
}
