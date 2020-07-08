package proyectos



class MetaController {

    def list(){
        def proyecto = Proyecto.get(params.id)
        return[proyecto: proyecto]
    }

    def form_ajax() {
        def meta
        if(params.id){
            meta = Meta.get(params.id)
        }else{
            meta = new Meta()
        }

        return [meta: meta]
    }


    def saveMeta_ajax () {
        println("params sm " + params)
    }


}
