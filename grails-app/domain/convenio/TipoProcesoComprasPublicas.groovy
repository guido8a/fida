package convenio

class TipoProcesoComprasPublicas {

    String descripcion
    Double base
    String sigla
    Double techo

    static mapping = {
        table 'tppc'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tppc__id'
            descripcion column: 'tppcdscr'
            base column: 'tppcbase'
            sigla column: 'tppcsgla'
            techo column: 'tppctcho'
        }
    }

    static constraints = {
        descripcion(size: 1..63, nullable: false, blank: false)
        base(nullable: false, blank: false)
        sigla(size: 1..7, nullable: true, blank: true)
        techo(nullable: true, blank: true)
    }
}
