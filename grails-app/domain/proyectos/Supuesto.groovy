package proyectos

import audita.Auditable

class Supuesto implements Auditable {

    MarcoLogico marcoLogico
    String descripcion

    static auditable = true

    static mapping = {
        table 'spst'
        cache usage:'read-write', include:'non-lazy'
        id column:'spst__id'
        id generator:'identity'
        version false
        columns {
            id column:'spst__id'
            marcoLogico column: 'mrlg__id'
            descripcion column: 'spstdscr'
        }
    }
    static constraints = {
        marcoLogico(blank: false, nullable: false)
        descripcion(size:1..255, blank:false, nullable:false)
    }
    String toString(){
        "${this.descripcion}"
    }

}