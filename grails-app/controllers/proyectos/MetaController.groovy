package proyectos

import parametros.proyectos.TipoElemento


class MetaController {

    def dbConnectionService

    def list(){
//        println("params" + params)
        def proyecto = Proyecto.get(params.id)
        def sql = "select * from indicador(${proyecto?.id})"
        def cn = dbConnectionService.getConnection()
        def res = cn.rows(sql.toString())

        def metas = []

        res.each{d->
            def indicador = Indicador.get(d.indi__id)
            if(Meta.findByIndicador(indicador)){
                metas.add(Meta.findByIndicador(indicador))
            }
        }

        def indicadores = res.indi__id

        println("r2 " +metas)

//        def metas2 = Meta.findAllByIndicadorInList(indicadores)
//        println("r1 " +metas2)
//
        return[proyecto: proyecto, metas: metas, indicadores: indicadores]
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
        def marcoLogicoIndicadores = MarcoLogico.findAllByTipoElemento(TipoElemento.get(3))
        def indicadores = Indicador.findAllByMarcoLogicoInList(marcoLogicoIndicadores).sort{it.descripcion}

        return [meta: meta, actividades: actividades, indicadores: indicadores]
    }


    def saveMeta_ajax () {
        println("params sm " + params)

        def meta

        if(params.id){
            meta = Meta.get(params.id)
        }else{
            meta = new Meta()
        }

        params.lineaBase = params.lineaBase.toInteger()
        params.disenio = params.disenio.toInteger()
        params.restructuracion = params.restructuracion.toInteger()
        meta.properties = params

        if(!meta.save(flush: true)){
            println("error al guardar la meta " + meta.errors)
            render "no_Error al guardar la meta"
        }else{
            render "ok_Meta guardada correctamente"
        }
    }

    def borrarMeta_ajax(){

        def meta = Meta.get(params.id)

        try{
            meta.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar la meta " + e + meta.errors)
            render "no"
        }
    }

    def show_ajax(){
        def meta = Meta.get(params.id)

        return[meta: meta]
    }


}
