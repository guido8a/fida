package base

import audita.Auditable
import seguridad.Persona

class Base  implements Auditable {
    Persona persona
    Tema tema
    Date fecha
    String clave
    String problema
    String algoritmo
    String solucion
    String referencia
    String observacion

    static auditable = true

    static mapping = {
        table 'base'
        cache usage: 'read-write', include: 'non-lazy'
        id generator: 'identity'
        version false

        columns {
            id column: 'base__id'
            persona column: 'prsn__id'
            tema    column: 'tema__id'
            fecha column: 'basefcha'
            clave column: 'baseclve'
            problema column: 'baseprbl'
            algoritmo column: 'basealgr'
            solucion column: 'baseslcn'
            referencia column: 'baserefe'
            observacion column: 'baseobsr'

        }
    }
    static constraints = {
        problema(size: 15..255, blank: false)
        clave(size: 3..127, blank: false)
        algoritmo(blank: true, nullable: true)
        solucion(blank: true, nullable: true)
        referencia(blank: true, nullable: true)
        observacion(blank: true, nullable: true)
    }

    String toString() {
        "${this.id}: ${this.problema}"
    }

    def beforeInsert = {
        clave = clave.toLowerCase()
    }
}