package convenio


class TipoProcesoComprasPublicasController {

    def list(){
        def procesos = TipoProcesoComprasPublicas.list().sort{it.descripcion}
        return[procesos:procesos]
    }

    def form_ajax(){

        def proceso

        if(params.id){
            proceso = TipoProcesoComprasPublicas.get(params.id)
        }else{
            proceso = new TipoProcesoComprasPublicas()
        }

        return[proceso:proceso]
    }

    def saveProceso_ajax(){

        def proceso

        if(params.id){
            proceso = TipoProcesoComprasPublicas.get(params.id)
        }else{
            proceso = new TipoProcesoComprasPublicas()
        }

        params.sigla = params.sigla.toUpperCase()
        proceso.properties = params
        if(!proceso.save(flush:true)){
            println("error al guardar el tipo de proceso " + proceso.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        def proceso = TipoProcesoComprasPublicas.get(params.id)

        try{
            proceso.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de proceso " + proceso.errors)
            render "no"
        }
    }

    def show_ajax(){
        def proceso = TipoProcesoComprasPublicas.get(params.id)
        return[proceso:proceso]
    }

}
