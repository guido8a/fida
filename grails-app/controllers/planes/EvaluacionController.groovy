package planes


class EvaluacionController {

    def dbConnectionService

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
        println "params: $params"
        def evaluacion = Evaluacion.get(params.id)
        def plns = evaluacion.planesNegocio

        def indicadores = IndicadorPlan.findAllByPlanesNegocio(plns)
        def detallesPlan = DetalleEvaluacion.findAllByEvaluacion(evaluacion)
        def detallesIndicadores = null
        def detallesDetalles = null

        if(indicadores){
/*
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
*/
        }else{
            detallesIndicadores = null
        }

        println("di " + detallesIndicadores)
        println("dd " + detallesDetalles)

        return[detalles:detallesDetalles, indicadores:detallesIndicadores, plns: plns, evaluacion: evaluacion]
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



    def tabla() {
        println "tabla " + params
        def sql = "select 0 id, inpn__id, inpn.inor__id, inpn.plns__id, inordscr, 0 original, 'obsr' obsr from inpn, inor " +
                "where inor.inor__id = inpn.inor__id order by inor__id"
        println("sql " + sql)
        def cn = dbConnectionService.getConnection()
        def evaluacion = Evaluacion.get(params.eval)
        def detalle = DetalleEvaluacion.countByEvaluacion(evaluacion)
        def data

        if(detalle) {
            sql = "select dtev__id id, inpn.inpn__id, inpn.inor__id, inpn.plns__id, inordscr, dtevvlor original, " +
                    " dtevobsr obsr from dtev, inpn, inor where eval__id = ${evaluacion.id} and " +
                    "inpn.inpn__id = dtev.inpn__id and inor.inor__id = inpn.inor__id order by inor__id"
        }
        println "sql: $sql"
        data = cn.rows(sql.toString())

//        def par = [oblg:7, controller:'vivienda', format:null, action:'tabla']
        [indicadores: data, plns: params.plns, eval: params.eval, band: false, cuenta: detalle]
    }

    def actualizar() {
        println "actualizar $params"
        if (params.item instanceof java.lang.String) {
            params.item = [params.item]
        }
        if (params.obsr instanceof java.lang.String) {
            params.obsr = [params.obsr]
        }

        def oks = "", nos = ""

        def eval = Evaluacion.get(params.eval)

        println "eval: ${eval.descripcion}"

        if(params.item) {
            params.item.each {
                def parts = it.split("_")

                def inpn = parts[0]
                def valor  = parts[1].toDouble()
                def inor   = parts[2]
                def obsr = null
                if(it.contains('_ob')) {
                    obsr   = parts[3]
                    if(obsr.size() > 2) {
                        obsr = obsr[2..-1]
                    } else {
                        obsr = null
                    }
                }

                if(inor.size() > 4) {
                    inor = inor[4..-1]
                } else {
                    inor = null
                }

                println "eval: ${params.eval}, inpn: $inpn, valor: $valor, inor: $inor, obsr: $obsr"

                /* consultar si hay que actualizar DTEV */
                def evaluacion = Evaluacion.get(params.eval);
                def indicador = IndicadorPlan.get(inpn);
                def detalle = DetalleEvaluacion.findByEvaluacionAndIndicadorPlan(evaluacion, indicador)

                println "evaluacion: ${evaluacion.id}, indicador: ${indicador.id} inor: ${indicador.indicadores.descripcion}"

                if(!detalle) {
                    detalle = new DetalleEvaluacion()
                    detalle.evaluacion = evaluacion
                    detalle.indicadorPlan = indicador
                }
                detalle.valor = valor
                detalle.observaciones = obsr

                if (!detalle.save(flush: true)) {
                    println "error $parts, --> ${detealle.errors}"
                    if (nos != "") {
                        nos += ","
                    }
                    nos += "#" + inpn
                } else {
                    if (oks != "") {
                        oks += ","
                    }
                    oks += "#" + inpn
                }
            }
        }
        render oks + "_" + nos
    }




}
