package convenio

import parametros.proyectos.TipoElemento
import proyectos.MarcoLogico
import proyectos.Proyecto


class PlanController {

    def dbConnectionService

    def plan(){
        def convenio = Convenio.get(params.id)
        def plazo = convenio?.plazo ? (convenio?.plazo?.toInteger() / 360) : 0
        def plazoEntero = Math.ceil(plazo).toInteger()
        def combo = [:]
        def listaPeriodos = []

        for (int j = 0; j < 12; j++) {
            listaPeriodos.add("Período ${j + 1}")
        }

        for(int i=1; plazoEntero >= i; i++ ){
            combo << ["${i}":"Año ${i}"]
        }

//        println("--> " + combo)
        return[convenio: convenio, combo: combo, lista: listaPeriodos]
    }

    def tablaPlan_ajax(){

        def convenio = Convenio.get(params.id)

        def listaPeriodos = []

        for (int j = 0; j < 12; j++) {
            listaPeriodos.add("Período ${j + 1}")
        }

        def sql = "select * from planes(${convenio?.id}, ${params.periodo}) order by comp__id"
        def cn = dbConnectionService.getConnection()
        def res = cn.rows(sql.toString())

        def tam = res?.size()

//        println("sql " + sql)

        return [componentes: res, lista: listaPeriodos, anio: params.periodo, convenio: convenio, tam: tam]
    }


    def valor_ajax(){

        println("va " + params)

        def pl = Plan.get(params.id)
        def periodoNumero = (params.anio == '1' ? params.periodo : params.periodo.toInteger() + ((params.anio.toInteger() - 1) * 12))
        def periodo = Periodo.findByNumero(periodoNumero)

        def planP = PlanPeriodo.findByPeriodoAndPlan(periodo,pl)

        return [periodo: planP]
    }

    def guardarValorPeriodo_ajax () {

//        println("params pax " + params)

        def pl = Plan.get(params.plan)
        def periodoNumero = (params.anio == '1' ? params.periodo : params.periodo.toInteger() + ((params.anio.toInteger() - 1) * 12))
        def periodoId = Periodo.findByNumero(periodoNumero)

//        println("pn " + periodoNumero)

        def planP = PlanPeriodo.findByPeriodoAndPlan(periodoId,pl)

        def planPeriodo

        if(planP){
            planPeriodo = planP
        }else{
            planPeriodo = new PlanPeriodo()
            planPeriodo.plan = pl
            planPeriodo.periodo = periodoId
        }

        planPeriodo.valor = params.valor.toDouble()

        if(!planPeriodo.save(flush: true)){
            render "no"
        }else{
            render "ok"
        }
    }

    def formPlan_ajax (){
        def convenio = Convenio.get(params.convenio)
        return[convenio: convenio]
    }

    def actividad_ajax(){
        def tipo = TipoElemento.get(4)
        def componente = MarcoLogico.get(params.id)
        def actividades = MarcoLogico.findAllByMarcoLogicoAndTipoElemento(componente,tipo).sort{it.objeto}

        return[actividades: actividades]
    }

    def planesConvenio (){
        def convenio = Convenio.get(params.id)
        def planes = Plan.findAllByConvenio(convenio)
        return[convenio: convenio, planes: planes]
    }

    def savePlan_ajax(){
        println("params sp " + params)

        def plan

        if(params.id){
            plan = Plan.get(params.id)
        }else{
            plan = new Plan()
        }

        params.ejecutado = params.ejecutado ? params.ejecutado : 0
        plan.properties = params

        if(!plan.save(flush:true)){
            render "no"
        }else{
            render "ok"
        }

    }

}
