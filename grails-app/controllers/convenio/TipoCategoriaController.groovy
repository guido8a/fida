package convenio



class TipoCategoriaController {

    def list(){
        def categorias = TipoCategoria.list().sort{it.descripcion}
        return[categorias:categorias]
    }

    def form_ajax(){

        def categoria

        if(params.id){
            categoria = TipoCategoria.get(params.id)
        }else{
            categoria = new TipoCategoria()
        }

        return[categoria:categoria]
    }

    def saveCategoria_ajax(){

        def categoria

        if(params.id){
            categoria = TipoCategoria.get(params.id)
        }else{
            categoria = new TipoCategoria()
        }

        categoria.properties = params
        if(!categoria.save(flush:true)){
            println("error al guardar el tipo de categoria " + categoria.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def delete_ajax(){
        def categoria = TipoCategoria.get(params.id)

        try{
            categoria.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el tipo de categoria " + categoria.errors)
            render "no"
        }
    }

    def show_ajax(){
        def categoria = TipoCategoria.get(params.id)
        return[categoria:categoria]
    }

}
