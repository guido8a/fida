package convenio

import parametros.Anio
import parametros.proyectos.Fuente
import parametros.proyectos.TipoElemento
import planes.GrupoActividad
import planes.PlanesNegocio
import poa.Presupuesto
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
        def plns = PlanesNegocio.get(params.convenio)
        def plan

        if(params.id){
            plan = Plan.get(params.id)
        }else{
            plan = new Plan()
        }
        return[plns: plns, plan: plan]
    }

    def actividad_ajax(){
        def tipo = TipoElemento.get(4)
        def componente = GrupoActividad.get(params.id)
        def actividades = GrupoActividad.findAllByPadre(componente).sort{it.descripcion}
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
        def planes = Plan.findAllByPlanesNegocio(convenio.planesNegocio, [sort: 'grupoActividad.descripcion'])
        return[convenio: convenio, planes: planes]
    }

    def savePlan_ajax(){
        println "savePlan_ajac $params"

        def plan

        if(params.plan){
            plan = Plan.get(params.plan)
        }else{
            plan = new Plan()
        }

        params.ejecutado = params.ejecutado ? params.ejecutado : 0
        plan.properties = params

        if(!plan.save(flush:true)){
            println "error: ${plan.errors}"
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
        def totalFinanciado = 0
        def financiamientos = FinanciamientoPlan.findAllByPlanAndFuente(plan,fuente)
        def financiados = FinanciamientoPlan.findAllByPlan(plan)


        if(params.monto.toDouble() < 0){
            render "er_Ingrese un número positivo"
        } else {
            if(financiados){
                totalFinanciado = financiados.valor.sum()
            }

            def restante = 0

            if(plan.costo > 0){
                restante = plan.costo - totalFinanciado
            }

            def financiamiento

            if(financiamientos){
                render "er_La fuente ya fué agregada"
            } else {
//                println "${Math.round(restante*100)} < ${Math.round(params.monto.toDouble()*100)}"
                if(Math.round(restante*100) < Math.round(params.monto.toDouble()*100)){
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

    def arbol() {
        def id = params.id
        return [arbol: makeTree(id), plns: id]
    }

/*
    */
/**
     * Acción llamada con ajax que permite realizar búsquedas en el árbol
     *//*

    def arbolSearch_ajax() {
        def search = params.str.trim()
        if (search != "") {
            def c = Presupuesto.createCriteria()
            def find = c.list(params) {
                or {
                    ilike("numero", "%" + search + "%")
                    ilike("descripcion", "%" + search + "%")
                }
            }
            println find
            def presupuestos = []
            find.each { pres ->
                if (pres.presupuesto && !presupuestos.contains(pres.presupuesto)) {
                    def pr = pres
                    while (pr) {
                        if (pr.presupuesto && !presupuestos.contains(pr.presupuesto)) {
                            presupuestos.add(pr.presupuesto)
                        }
                        pr = pr.presupuesto
                    }
                }
            }
            presupuestos = presupuestos.reverse()

            def ids = "["
            if (find.size() > 0) {
                ids += "\"#root\","
                presupuestos.each { pr ->
                    ids += "\"#lid_" + pr.id + "\","
                }
                ids = ids[0..-2]
            }
            ids += "]"
            render ids
        } else {
            render ""
        }
    }

*/
    /**
     * Función que genera el árbol de partidas presupuestarias
     */
    def makeTree(id) {
        def plns = PlanesNegocio.get(id)
        def lista = GrupoActividad.findAllByPadreIsNullAndPlanesNegocio(plns, [sort: "numero"]).id
        def res = ""
        println "root: ${lista}"
        res += "<ul>"
        res += "<li id='root' data-level='0' class='root jstree-open' data-jstree='{\"type\":\"root\"}'>"
        res += "<a href='#' class='label_arbol'>Grupo de Actividades</a>"
        res += "<ul>"
        lista.each {
            res += imprimeHijos(it)
        }
        res += "</ul>"
        res += "</ul>"
    }

    /**
     * Función que genera las hojas del árbol de un padre específico
     */
    def imprimeHijos(padre) {
        def band = true
        def t = ""
        def txt = ""

        def grac = GrupoActividad.get(padre)

        def l = GrupoActividad.findAllByPadre(grac, [sort: 'numero']);

        l.each {
            println "---- hijos"
            band = false;
            t += imprimeHijos(it.id)
        }

        if (!band) {
            def clase = "jstree-open"
            if (!grac.padre) {
                clase = "jstree-closed"
            }
            txt += "<li id='li_" + grac.id + "' class='padre " + clase + "' data-jstree='{\"type\":\"padre\"}'>"
            txt += "<a href='#' class='label_arbol'>" + grac + "</a>"
            txt += "<ul>"
            txt += t
            txt += "</ul>"
        } else {
            txt += "<li id='li_" + grac.id + "' class='hijo jstree-leaf' data-jstree='{\"type\":\"hijo\"}'>"
            txt += "<a href='#' class='label_arbol'>" + grac + "</a>"
        }
        txt += "</li>"
        return txt
    }



}
