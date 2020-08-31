package convenio

import seguridad.UnidadEjecutora
import taller.Raza


class CategoriaController {

    def formCategoria_ajax() {
        def unidad = UnidadEjecutora.get(params.unidad)
        return[unidad: unidad]
    }

    def tablaCategoria_ajax(){
        def unidad = UnidadEjecutora.get(params.id)
        def categorias = Categoria.findAllByUnidadEjecutora(unidad).sort{it.tipoCategoria.descripcion}
        return [categorias:categorias]
    }

    def agregarCategoria_ajax(){

        def unidad = UnidadEjecutora.get(params.id)
        def tipoCategoria = TipoCategoria.get(params.categoria)
        def categorias = Categoria.findAllByUnidadEjecutoraAndTipoCategoria(unidad, tipoCategoria)
        def categoria
        if(categorias){
            render "er"
        }else{
            categoria = new Categoria()
            categoria.unidadEjecutora = unidad
            categoria.tipoCategoria = tipoCategoria
            categoria.valor = params.valor

            if(!categoria.save(flush:true)){
                println("error al guardar la categoria " + categoria.errors)
                render "no"
            }else{
                render "ok"
            }
        }
    }

    def borrarCategoria_ajax(){
        def categoria = Categoria.get(params.id)

        try{
            categoria.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el elemento del tabla categoia " + e + " " + categoria.errors)
            render "no"
        }
    }


}
