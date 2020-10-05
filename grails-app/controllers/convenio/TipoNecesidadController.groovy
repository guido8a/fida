package convenio


class TipoNecesidadController {

    def list(){
        def necesidades = TipoNecesidad.list().sort{it.descripcion}
        return[necesidades:necesidades]
    }

    def form_ajax(){

        def necesidad

        if(params.id){
            necesidad = TipoNecesidad.get(params.id)
        }else{
            necesidad = new TipoNecesidad()
        }

        return[necesidad:necesidad]
    }

    def saveNecesidad_ajax(){

        def necesidad

        if(params.id){
            necesidad = TipoNecesidad.get(params.id)
        }else{
            necesidad = new TipoNecesidad()
        }

        necesidad.properties = params
        if(!necesidad.save(flush:true)){
            println("error al guardar el tipo de necesidad " + necesidad.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        def necesidad = TipoNecesidad.get(params.id)

        try{
            necesidad.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de necesidad " + necesidad.errors)
            render "no"
        }
    }

    def show_ajax(){
        def necesidad = TipoNecesidad.get(params.id)
        return[necesidad:necesidad]
    }


}
