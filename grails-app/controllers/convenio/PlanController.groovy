package convenio

import parametros.Anio
import parametros.proyectos.Fuente
import parametros.proyectos.TipoElemento
import proyectos.Financiamiento
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

        def planP = PlanPeriodo.findByPeriodoAndPlan(periodo, pl)

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
        def plan

        if(params.id){
            plan = Plan.get(params.id)
        }else{
            plan = new Plan()
        }
        return[convenio: convenio, plan: plan]
    }

    def actividad_ajax(){
        def tipo = TipoElemento.get(4)
        def componente = MarcoLogico.get(params.id)
        def actividades = MarcoLogico.findAllByMarcoLogicoAndTipoElemento(componente,tipo).sort{it.objeto}
        def plan
        if(params.plan){
            plan = Plan.get(params.plan)
        }else{
            plan = new Plan()
        }

        return[actividades: actividades, plan: plan]
    }

    def planesConvenio (){
        def convenio = Convenio.get(params.id)
        def planes = Plan.findAllByConvenio(convenio)
        return[convenio: convenio, planes: planes]
    }

    def savePlan_ajax(){
//        println("params sp " + params)

        def plan

        if(params.plan){
            plan = Plan.get(params.plan)
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


    def borrarPlan_ajax(){
        def plan = Plan.get(params.id)
        def periodos = PlanPeriodo.findAllByPlan(plan)

        if(periodos){
            render "er"
        }else{
            try{
                plan.delete(flush:true)
                render "ok"
            }catch(e){
                println("error al borrar el plan " + e + plan.errors)
                render "no"
            }
        }
    }

    def fuente_ajax () {
        def plan = Plan.get(params.id)
        return[plan: plan]
    }

    def tablaFuente_ajax(){
        def plan = Plan.get(params.id)

        def financiamientos = FinanciamientoPlan.findAllByPlan(plan).sort{it.fuente.descripcion}

        return[plan: plan, financiamientos: financiamientos]
    }

    def saveFuente_ajax(){

        def plan = Plan.get(params.id.toLong())
        def fuente = Fuente.get(params.fuente.toLong())

        def financiamientos = FinanciamientoPlan.findAllByPlanAndFuente(plan,fuente)
        def totalFinanciado = FinanciamientoPlan.findAllByPlan(plan).valor.sum()
        def restante = plan.costo.toDouble() - totalFinanciado

        def financiamiento

        if(financiamientos){
            render "er_La fuente ya fué agregada"
        }else{
            if(restante < params.monto.toDouble()){
                render "er_El monto ingresado es mayor al valor restante"
            }else{
                financiamiento = new FinanciamientoPlan()
                financiamiento.valor = params.monto.toDouble()
                financiamiento.fuente = fuente
                financiamiento.plan = plan
            }
        }

        if(!financiamiento.save(flush:true)){
            println("error al guardar la fuente del plan " + financiamiento.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def borrarFuente_ajax(){
        def financiamiento = FinanciamientoPlan.get(params.id)

        try{
            financiamiento.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la fuente del plan " + e + financiamiento.errors)
            render "no"
        }
    }

}
