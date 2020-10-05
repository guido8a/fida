package convenio


class EstadoGarantiaController {

    def list(){
        def estados = EstadoGarantia.list().sort{it.descripcion}
        return[estados:estados]
    }

    def form_ajax(){

        def estado

        if(params.id){
            estado = EstadoGarantia.get(params.id)
        }else{
            estado = new EstadoGarantia()
        }

        return[estado:estado]
    }

    def saveEstado_ajax(){

        def estado

        if(params.id){
            estado = EstadoGarantia.get(params.id)
        }else{
            estado = new EstadoGarantia()
        }


        estado.properties = params
        if(!estado.save(flush:true)){
            println("error al guardar el tipo de categoria " + estado.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        def estado = EstadoGarantia.get(params.id)

        try{
            estado.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el estado de garantía " + estado.errors)
            render "no"
        }
    }

    def show_ajax(){
        def estado = EstadoGarantia.get(params.id)
        return[estado:estado]
    }

}
