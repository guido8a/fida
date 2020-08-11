package proyectos

import audita.Auditable
import parametros.proyectos.IndicadorOrms

class Indicador implements Auditable {
    MarcoLogico marcoLogico
    IndicadorOrms indicadorOrms
    String descripcion
    double cantidad

    static auditable = true
    static mapping = {
        table 'indi'
        cache usage:'read-write', include:'non-lazy'
        id column:'indi__id'
        id generator:'identity'
        version false
        columns {
            id column:'indi__id'
            marcoLogico column: 'mrlg__id'
            indicadorOrms column: 'orms__id'
            descripcion column: 'indidscr'
            cantidad column: 'indicntd'
        }
    }
    static constraints = {
        marcoLogico( blank:false, nullable:false ,attributes:[mensaje:'Elemento del marco lógico al que se aplica el indicador'])
        indicadorOrms( blank:false, nullable:false ,attributes:[mensaje:'Indicador ORMS'])
        descripcion(size:1..1023, blank:false, nullable:false ,attributes:[mensaje:'Descripción del indicador'])
        cantidad( blank:true, nullable:true ,attributes:[mensaje:'Cantidad para indicadores cuantitativos'])
    }
     String toString(){
        "${this.descripcion}"
    }
}