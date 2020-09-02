package taller

import audita.Auditable

class InstitucionAsociada implements Auditable{

    Taller taller
    Institucion institucion

    static mapping = {
        table 'inas'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'inas__id'
        id generator: 'identity'
        version false
        columns {
            id column: 'inas__id'
            taller column: 'tllr__id'
            institucion column: 'inst__id'
        }
    }
    static constraints = {

        taller(blank:true, nullable: true)
        institucion(blank:true, nullable: true)

    }

}
