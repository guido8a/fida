package proyectos

import parametros.proyectos.TipoElemento


class MetaController {

    def list(){
//        println("params" + params)
        def proyecto = Proyecto.get(params.id)
        def marco = MarcoLogico.findAllByProyecto(proyecto)
        def metas = Meta.findAllByMarcoLogicoInList(marco)
        return[proyecto: proyecto, metas: metas]
    }

    def form_ajax() {
//        println("params fm " + params)
        def proyecto = Proyecto.get(params.proyecto)
        def meta
        if(params.id){
            meta = Meta.get(params.id)
        }else{
            meta = new Meta()
        }

        def actividades = MarcoLogico.findAllByProyectoAndTipoElemento(proyecto, TipoElemento.get(4))

        return [meta: meta, actividades: actividades]
    }


    def saveMeta_ajax () {
//        println("params sm " + params)

        def meta

        if(params.id){
            meta = Meta.get(params.id)
        }else{
            meta = new Meta()
        }

        params.valor = params.valor.toDouble()
        meta.properties = params


        if(!meta.save(flush: true)){
            println("error al guardar la meta " + meta.errors)
            render "no_Error al guardar la meta"
        }else{
            render "ok_Meta guardada correctamente"
        }

    }


}
