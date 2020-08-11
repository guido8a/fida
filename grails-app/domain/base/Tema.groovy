package base

import audita.Auditable

class Tema  implements Auditable {
    static auditable = true
    String nombre

    static mapping = {
        table 'tema'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'tema__id'
            nombre column: 'temanmbr'
        }
    }

    static constraints = {
        nombre(blank: false, size: 3..63)
    }

    String toString() {
        "${this.nombre}"
    }

}