package convenio

import org.springframework.dao.DataIntegrityViolationException
import parametros.Anio
import parametros.proyectos.Fuente
import parametros.proyectos.TipoElemento
import planes.FinanciamientoPlanNegocio
import planes.GrupoActividad
import planes.PlanesNegocio
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
        println "formPlan_ajax: $params"
        def plns = PlanesNegocio.get(params.planNs)
        def plan

        if(params.id){
            plan = Plan.get(params.id)
        }else{
            plan = new Plan()
        }
        println "PNS: ${plns.id}"
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
//        println "planesConvenio: ${params}"
        def plns = PlanesNegocio.get(params.id)
        def cnvn = Convenio.findByPlanesNegocio(plns)
        def periodo = Periodo.findByPlanesNegocioAndFechaInicioIsNotNull(plns)
        def planes = Plan.findAllByPlanesNegocio(plns, [sort: 'grupoActividad.descripcion'])
        println "planesConvenio --> ${plns.id}"
        return[planNs: plns, planes: planes, cnvn: cnvn, periodo: periodo]
    }

    def savePlan_ajax(){
//        println "savePlan_ajac $params"

        def plan

        if(params.plan){
            plan = Plan.get(params.plan)
        }else{
            plan = new Plan()
        }

        params.ejecutado = params.ejecutado ? params.ejecutado : 0
        params.costo = params.costo.toDouble()
        params.cantidad = params.cantidad.toDouble()
        params.presupuesto = params.partida1
        plan.properties = params
//        plan.ejecutado = params.ejecutado.toDouble()

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

    def fuenteFnpl_ajax () {
        def plan = Plan.get(params.id)
        def planNegocio = plan.planesNegocio
        def fuentes = FinanciamientoPlanNegocio.findAllByPlanesNegocio(planNegocio).sort{it.fuente.descripcion}
        return[plan: plan, fuentes: fuentes]
    }

    def tablaFuenteFnpl_ajax (){

    }

    def fuente_ajax () {
        def plan = Plan.get(params.id)
        return[plan: plan]
    }

    def tablaFuente_ajax(){
        def plan = Plan.get(params.id)
        def financiamientos = FinanciamientoPlan.findAllByPlan(plan).sort{it.financiamientoPlanNegocio.fuente.descripcion}
        return[plan: plan, financiamientos: financiamientos]
    }

    def saveFuente_ajax(){

        def plan = Plan.get(params.id.toLong())
        def finanPlanNegocio = FinanciamientoPlanNegocio.get(params.fuente.toLong())
        def totalFinanciado = 0
        def financiamientos = FinanciamientoPlan.findAllByPlanAndFinanciamientoPlanNegocio(plan,finanPlanNegocio)
        def financiados = FinanciamientoPlan.findAllByPlan(plan)



        def usado = FinanciamientoPlan.findAllByFinanciamientoPlanNegocio(finanPlanNegocio)
        def restanteFnpn = 0
        if(usado){
            restanteFnpn = finanPlanNegocio.valor - usado.valor.sum()
        }else{
            restanteFnpn = finanPlanNegocio.valor
        }


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
                    if(params.monto.toDouble() > restanteFnpn){
                        render "er_El monto ingresado es mayor al valor disponible de la fuente"
                    }else{
                        financiamiento = new FinanciamientoPlan()
                        financiamiento.valor = params.monto.toDouble()
                        financiamiento.financiamientoPlanNegocio = finanPlanNegocio
                        financiamiento.plan = plan
                    }
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
            def c = GrupoActividad.createCriteria()
            def find = c.list(params) {
                or {
                    ilike("numero", "%" + search + "%")
                    ilike("descripcion", "%" + search + "%")
                }
            }
            println find
            def presupuestos = []
            find.each { pres ->
                if (pres.GrupoActividad && !presupuestos.contains(pres.GrupoActividad)) {
                    def pr = pres
                    while (pr) {
                        if (pr.GrupoActividad && !presupuestos.contains(pr.GrupoActividad)) {
                            presupuestos.add(pr.GrupoActividad)
                        }
                        pr = pr.GrupoActividad
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
//            println "---- hijos"
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

    def form_ajax() {
        println "form_ajax $params"
        def plns = PlanesNegocio.get(params.plns)
        def grupoAc = new GrupoActividad()
        if (params.id) {
            grupoAc = GrupoActividad.get(params.id)
            if (!grupoAc) {
                render "ERROR*No se encontró GrupoActividad."
                return
            }
        }
        grupoAc.properties = params
        if (params.padre) {
            def padre = GrupoActividad.get(params.padre.toLong())
            grupoAc.padre = padre
        }

        return [grupoAc: grupoAc, plns: plns.id]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        println "save_ajax: $params"
        def plns = PlanesNegocio.get(params.plns)
        def grupoAc = new GrupoActividad()
        if (params.id) {
            grupoAc = GrupoActividad.get(params.id)
            if (!grupoAc) {
                render "ERROR*No se encontró GrupoActividad."
                return
            }
        }
        grupoAc.properties = params
        grupoAc.planesNegocio = plns
        println "padre: ${grupoAc.padre}, ${params.padre}"

        if (!grupoAc.save(flush: true)) {
            render "ERROR*Ha ocurrido un error al guardar GrupoActividad: " + renderErrors(bean: grupoAc)
            return
        }
        render "SUCCESS*${params.id ? 'Actualización' : 'Creación'} de Actividad exitosa."
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def grupoAc = GrupoActividad.get(params.id)
            if (!grupoAc) {
                render "ERROR*No se encontró GrupoActividad."
                return
            }
            def hijos = GrupoActividad.findAllByPresupuesto(grupoAc)
            if (hijos == 0) {
                try {
                    grupoAc.delete(flush: true)
                    render "SUCCESS*Eliminación de GrupoActividad exitosa."
                    return
                } catch (DataIntegrityViolationException e) {
                    render "ERROR*Ha ocurrido un error al eliminar GrupoActividad"
                    return
                }
            } else {
                render "ERROR*El GrupoActividad tiene presupuestos asociados, no puede eliminarlo"
            }
        } else {
            render "ERROR*No se encontró GrupoActividad."
            return
        }
    } //delete para eliminar via ajax

    def disponible_ajax(){
        def plan = FinanciamientoPlanNegocio.get(params.id)
        def usado = FinanciamientoPlan.findAllByFinanciamientoPlanNegocio(plan)
        def restante
        if(usado){
            restante = plan.valor - usado.valor.sum()
        }else{
            restante = plan.valor
        }

        return[plan:plan, restante: restante]
    }

    def poneFechas() {
        println "poneFechas: $params"
        def plns = PlanesNegocio.get(params.id)
        def cnvn = Convenio.findByPlanesNegocio(plns)
        def fcin = cnvn.fechaInicio
        def fcfn = fcin + 30 - 1
        def dias = 0
        def nmro = 1
        def prdo

/*
        if(prdo) {
            flash.message = "Ya están generadas las fechas de los periodos"
            redirect(controller: 'plan', action: 'planesConvenio', id: plns.id)
            return
        }
*/

        while(dias < cnvn.plazo) {
            prdo = Periodo.findByPlanesNegocioAndNumero(plns, nmro)
            prdo.fechaInicio = fcin
            prdo.fechaFin = fcfn
            prdo.save(flush: true)
//            println "prdo: ${prdo.numero} --> $nmro"
//            println "fecha: $fcin -- $fcfn"
            dias += 30
            fcin = fcfn + 1
            fcfn = fcin + 30 - 1
            nmro++
        }
        flash.message = "Se ha actualizado los periodos"
        redirect(controller: 'plan', action: 'planesConvenio', id: plns.id)
    }

}
