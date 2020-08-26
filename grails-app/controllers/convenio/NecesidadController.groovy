package convenio

import seguridad.UnidadEjecutora


class NecesidadController {

    def formNecesidad_ajax() {
        def unidad = UnidadEjecutora.get(params.unidad)
        return[unidad: unidad]
    }

    def tablaNecesidad_ajax(){
        def unidad = UnidadEjecutora.get(params.id)
        def necesidades = Necesidad.findAllByUnidadEjecutora(unidad)
        return [necesidades:necesidades]
    }

    def agregarNecesidad_ajax(){

        def unidad = UnidadEjecutora.get(params.id)
        def tipoNecesidad = TipoNecesidad.get(params.necesidad)
        def necesidades = Necesidad.findAllByUnidadEjecutoraAndTipoNecesidad(unidad, tipoNecesidad)
        def necesidad
        if(necesidades){
            render "er"
        }else{
            necesidad = new Necesidad()
            necesidad.unidadEjecutora = unidad
            necesidad.tipoNecesidad = tipoNecesidad

            if(!necesidad.save(flush:true)){
                println("error al guardar la necesidad " + necesidad.errors)
                render "no"
            }else{
                render "ok"
            }
        }
    }

    def borrarNecesidad_ajax(){
        def necesidad = Necesidad.get(params.id)

        try{
            necesidad.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el elemento del tabla necesidad " + e + " " + necesidad.errors)
            render "no"
        }
    }

}
