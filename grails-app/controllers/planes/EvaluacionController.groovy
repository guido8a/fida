package planes


class EvaluacionController {

    def formEvaluacion_ajax() {
        def plan = PlanesNegocio.get(params.plan)
        def evaluacion
        if(params.id){
            evaluacion = Evaluacion.get(params.id)
        }else{
            evaluacion = new Evaluacion()
        }

        return[evaluacion: evaluacion, plan: plan]
    }

    def saveEvaluacion_ajax(){
        println("params se " + params)
        def evaluacion

        if(params.fechaInicio){
            params.fechaInicio = new Date().parse("dd-MM-yyyy",params.fechaInicio)
        }

        if(params.fechaFin){
            params.fechaFin = new Date().parse("dd-MM-yyyy",params.fechaFin)
        }

        if(params.id){
            evaluacion = Evaluacion.get(params.id)
        }else{
            evaluacion = new Evaluacion()
            evaluacion.fecha = new Date()
        }

        evaluacion.properties = params

        if(!evaluacion.save(flush:true)){
            println("error al guardar la evaluacion eval " + evaluacion.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def detalleEvaluacion(){

        def evaluacion = Evaluacion.get(params.id)
        def plan = evaluacion.planesNegocio

        def indicadores = IndicadorPlan.findAllByPlanesNegocio(plan)
        def detallesPlan = DetalleEvaluacion.findAllByEvaluacion(evaluacion)
        def detallesIndicadores = null
        def detallesDetalles = null

        if(indicadores){
            if(detallesPlan){
                indicadores.each {
                    if(detallesPlan?.indicadorPlan?.contains(it.indicadores)){

                    }else{
                        detallesIndicadores += it
                    }
                }

                detallesDetalles = detallesPlan

            }else{
                detallesIndicadores = indicadores
            }
        }else{
            detallesIndicadores = null
        }

        println("di " + detallesIndicadores)
        println("dd " + detallesDetalles)

        return[detalles:detallesDetalles, indicadores:detallesIndicadores, plan:plan, evaluacion: evaluacion]
    }

    def borrarEvaluacion_ajax() {
        def evaluacion = Evaluacion.get(params.id)

        def detalles = DetalleEvaluacion.findAllByEvaluacion(evaluacion)

        if(detalles){
            render "er"
        }else{
            try{
            evaluacion.delete(flush:true)
                render "ok"
            }catch(e){
                println("error al borrar la evaluacion " + evaluacion.errors)
                render"no"
            }
        }
    }

}
