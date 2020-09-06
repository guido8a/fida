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
        def sql = "select inpn__id, inpn.inor__id, inpn.plns__id, inordscr, 0 original, 'obsr' obsr from inpn, inor " +
                "where inor.inor__id = inpn.inor__id order by inor__id"
        println("sql " + sql)
        def cn = dbConnectionService.getConnection()
        def data = cn.rows(sql.toString())

/*
        data = [[prsn__id:2, edifdscr:'Torre 1', prsnnmbr:'Santiago', prsnapll:'Naranjo', prsndpto:111,
                 tpocdscr:'Propietario', ingr__id:88, ingrfcha:'2018-02-01 00:00:00.0', ingretdo:'P',
                 ingrvlor:51.00, ingrobsr:'Febrero 2018'],
                [prsn__id:3, edifdscr:'Torre 1', prsnnmbr:'Lilia', prsnapll:'Quintana', prsndpto:112,
                 tpocdscr:'Propietario', ingr__id:89, ingrfcha:'2018-02-01 00:00:00.0', ingretdo:'P',
                 ingrvlor:46.00, ingrobsr:'Febrero 2018']]
*/

//        def par = [oblg:7, controller:'vivienda', format:null, action:'tabla']
        [indicadores: data, params: params, band: false]
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

        def fecha = new Date().parse("dd-MM-yyyy", params.fecha);
        println "fecha: $fecha"

        def oblg = Obligacion.get(params.oblg)

        println "oblg: ${oblg.id}"

        if(params.item) {
            params.item.each {
                def parts = it.split("_")

                def prsnId = parts[0]
                def valor  = parts[1].toDouble()
                def ingr   = parts[2]
                def obsr = null
                if(it.contains('_ob')) {
                    obsr   = parts[3]
                    if(obsr.size() > 2) {
                        obsr = obsr[2..-1]
                    } else {
                        obsr = null
                    }
                }

                if(ingr.size() > 2) {
                    ingr = ingr[2..-1]
                } else {
                    ingr = null
                }

                def ingreso = Ingreso.get(ingr);

/*
                if (!ingreso) {
                    ingreso = new Ingreso()
                    ingreso.persona = Persona.get(prsnId)
                    ingreso.obligacion = oblg
                    ingreso.valor = valor
                    ingreso.fecha = new Date()
                } else {
                    ingreso.valor = valor
                    ingreso.fecha = new Date()
                    ingreso.estado = 'M'
                }
*/

                ingreso.observaciones = obsr

                if (!ingreso.save(flush: true)) {
                    println "error $parts, --> ${ingreso.errors}"
                    if (nos != "") {
                        nos += ","
                    }
                    nos += "#" + prsnId
                } else {
                    if (oks != "") {
                        oks += ","
                    }
                    oks += "#" + prsnId
                }

            }

        }

        def obsr
        def id
        if(params.obsr){
            params.obsr.each {
                def p_obsr = it.split("_")
                id = p_obsr[0]
                def ingr   = p_obsr[1]
                if(ingr.size() > 2) {
                    ingr = ingr[2..-1]
                } else {
                    ingr = null
                }

                obsr = p_obsr[2]
                if(obsr.size() > 2) {
                    obsr = obsr[2..-1]
                } else {
                    obsr = null
                }
                println "id: $id, ingr: $ingr, obsr: $obsr"

                def ingreso = Ingreso.get(ingr);

/*
                if (!ingreso) {
                    println "crea ingreso"
                    ingreso = new Ingreso()
                    ingreso.persona = Persona.get(id)
                    ingreso.fecha = new Date()
                    ingreso.observaciones = obsr
                } else {
                    println "edita ingreso ${ingreso.id}"
                    ingreso.observaciones = obsr
                }
*/

                if (!ingreso.save(flush: true)) {
                    println "error $p_obsr, --> ${ingreso.errors}"
                    if (nos != "") {
                        nos += ","
                    }
                    nos += "#" + id
                } else {
                    if (oks != "") {
                        oks += ","
                    }
                    oks += "#" + id
                }
            }
        }

        render oks + "_" + nos
    }




}
