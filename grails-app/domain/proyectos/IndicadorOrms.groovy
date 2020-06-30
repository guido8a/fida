package proyectos

class IndicadorOrms implements Serializable {

    String codigo
    String descripcion

    static auditable=[ignore:[]]
    static mapping = {
        table 'orms'
        cache usage:'read-write', include:'non-lazy'
        id column:'orms__id'
        id generator:'identity'
        version false
        columns {
            id column:'orms__id'
            codigo column: 'ormscdgo'
            descripcion column: 'ormsdscr'
        }
    }
    static constraints = {
        codigo(size:1..15, blank:false, nullable:false)
        descripcion(size:1..255, blank:false, nullable:false)
    }
    String toString(){
        "${this.descripcion}"
    }

}