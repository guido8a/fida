package proyectos

class MedioVerificacion implements Serializable {
    Indicador indicador
    String descripcion
    static auditable=true
    static mapping = {
        table 'mdvf'
        cache usage:'read-write', include:'non-lazy'
        id column:'mdvf__id'
        id generator:'identity'
        version false
        columns {
            id column:'mdvf__id'
            indicador column: 'indi__id'
            descripcion column: 'mdfvdscr'
        }
    }
    static constraints = {
        indicador( blank:false, nullable:false ,attributes:[mensaje:'Elemento del marco lógico al que se aplica el indicador'])
        descripcion(size:1..1023, blank:false, nullable:false ,attributes:[mensaje:'Descripción del medio de verificación'])
    }

    String toString(){
        if(descripcion.size()>20){
            def partes = descripcion.split(" ")
            def cont=0
            def des =""
            partes.each {
                cont+=it.size()
                if(cont<22)
                    des+=" "+it
            }
            return des+"... "

        }else{
            return "${this.descripcion}"
        }

    }
    String toStringCompleto(){
        return this.descripcion
    }

}