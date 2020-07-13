package parametros.convenio

class UnidadCompras {

    String codigo
    String descripcion

    static auditable=[ignore:[]]
    static mapping = {
        table 'uncp'
        cache usage:'read-write', include:'non-lazy'
        id column:'uncp__id'
        id generator:'identity'
        version false
        columns {
            id column:'uncp__id'
            codigo column: 'uncpcdgo'
            descripcion column: 'uncpdscr'
        }
    }
    static constraints = {
        codigo(size:1..7, blank:false, nullable:false)
        descripcion(size:1..63, blank:false, nullable:false)
    }
    String toString(){
        "${this.descripcion}"
    }

}