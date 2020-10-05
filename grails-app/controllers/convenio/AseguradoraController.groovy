package convenio


class AseguradoraController {

    def list(){
        def aseguradoras = Aseguradora.list().sort{it.nombre}
        return[aseguradoras:aseguradoras]
    }

    def form_ajax(){

        def aseguradora

        if(params.id){
            aseguradora = Aseguradora.get(params.id)
        }else{
            aseguradora = new Aseguradora()
        }

        return[aseguradora:aseguradora]
    }

    def saveAseguradora_ajax(){

        def aseguradora

        if(params.id){
            aseguradora = Aseguradora.get(params.id)
        }else{
            aseguradora = new Aseguradora()
        }

        aseguradora.properties = params
        if(!aseguradora.save(flush:true)){
            println("error al guardar la aseguradora " + aseguradora.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        def aseguradora = Aseguradora.get(params.id)

        try{
            aseguradora.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar la aseguradora " + aseguradora.errors)
            render "no"
        }
    }

    def show_ajax(){
        def aseguradora = Aseguradora.get(params.id)
        return[aseguradora:aseguradora]
    }

}
