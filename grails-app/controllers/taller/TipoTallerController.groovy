package taller


class TipoTallerController {


    def list(){
        def talleres = TipoTaller.list().sort{it.descripcion}
        return[talleres:talleres]
    }

    def form_ajax(){

        def taller

        if(params.id){
            taller = TipoTaller.get(params.id)
        }else{
            taller = new TipoTaller()
        }

        return[taller:taller]
    }

    def saveTaller_ajax(){

        def taller

        if(params.id){
            taller = TipoTaller.get(params.id)
        }else{
            taller = new TipoTaller()
        }

        params.descripcion = params.descripcion.toUpperCase();
        taller.properties = params
        if(!taller.save(flush:true)){
            println("error al guardar el tipo de taller " + taller.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        def taller = TipoTaller.get(params.id)

        try{
            taller.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar tipo de taller " + taller.errors)
            render "no"
        }
    }

    def show_ajax(){
        def taller = TipoTaller.get(params.id)
        return[taller:taller]
    }

}
