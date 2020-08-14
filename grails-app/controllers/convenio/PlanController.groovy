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

//        println("sql " + sql)

        return [componentes: res, lista: listaPeriodos, anio: params.periodo, convenio: convenio]
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

        println("params pax " + params)

        def pl = Plan.get(params.plan)
        def periodoNumero = (params.anio == '1' ? params.periodo : params.periodo.toInteger() + ((params.anio.toInteger() - 1) * 12))
        def periodoId = Periodo.findByNumero(periodoNumero)

        println("pn " + periodoNumero)

        def planPeriodo

        if(params.id){
            planPeriodo = PlanPeriodo.get(params.id)
        }else{
            planPeriodo = new PlanPeriodo()
            planPeriodo.valor = params.valor.toDouble()
            planPeriodo.plan = pl
            planPeriodo.periodo = periodoId
        }

        if(!planPeriodo.save(flush: true)){
            render "no"
        }else{
            render "ok"
        }
    }

}
