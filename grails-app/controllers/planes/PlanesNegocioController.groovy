package planes

import convenio.Necesidad
import convenio.TipoNecesidad
import geografia.Comunidad
import geografia.Parroquia
import org.springframework.dao.DataIntegrityViolationException
import parametros.proyectos.IndicadorOrms
import proyectos.Indicador
import proyectos.Proyecto
import seguridad.UnidadEjecutora
import seguridad.UnidadEjecutoraController

class PlanesNegocioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def dbConnectionService


    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return convenioInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formPlanesNegocio_ajax() {
        println "formPlanesNegocio_ajax: $params"
        def lugar = ""
        def convenioInstance = new PlanesNegocio()
        if (params.id) {
            convenioInstance = PlanesNegocio.get(params.id)
            if (!convenioInstance) {
//                render "ERROR*No se encontró PlanesNegocio."
//                return
                convenioInstance = new PlanesNegocio()
            }
        }
//        convenioInstance.properties = params
        if (convenioInstance?.parroquia) {
            lugar = "${convenioInstance.parroquia.nombre} " +
                    "(${convenioInstance.parroquia.canton.provincia.nombre})"
        }
        println "convenio: $convenioInstance"
        return [convenioInstance: convenioInstance, lugar: lugar]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        def plan
        def texto

        params.fechaPresentacion = params.fechaPresentacion ? new Date().parse("dd-MM-yyyy", params.fechaPresentacion) : null
        params.fechaComite = params.fechaComite ? new Date().parse("dd-MM-yyyy", params.fechaComite) : null
        params.fechaAprobacion = params.fechaAprobacion ? new Date().parse("dd-MM-yyyy", params.fechaAprobacion) : null

        println "1...monto: ${params.monto}"

        if (params.id) {
            plan = PlanesNegocio.get(params.id)
            texto = "PlanesNegocio actualizado correctamente"
        } else {
            plan = new PlanesNegocio()
            texto = "PlanesNegocio creado correctamente"
        }

        println "plan: ${plan}"

        plan.properties = params
        println "monto: ${params.monto}"
        plan.monto = params.monto.toDouble()

        if (!plan.save(flush: true)) {
            println "Error en save de PNS ejecutora\n" + plan.errors
            render "no*Error al guardar el PNS"
        } else {
            render "SUCCESS*" + texto + "*" + plan?.id
        }
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def convenioInstance = PlanesNegocio.get(params.id)
            if (!convenioInstance) {
                render "ERROR*No se encontró el PlanesNegocio."
                return
            }
            try {
                convenioInstance.delete(flush: true)
                render "SUCCESS*Eliminación de PlanesNegocio exitosa."
            } catch (DataIntegrityViolationException e) {
                println("error al borrar el convenio " + e + convenioInstance.errors)
                render "ERROR*Ha ocurrido un error al eliminar PlanesNegocio"
            }
        } else {
            render "ERROR*No se encontró el PlanesNegocio."
        }
    } //delete para eliminar via ajax

    def comunidad_ajax() {
        def parroquia = Parroquia.get(params.id)
        def cantones = Comunidad.findAllByParroquia(parroquia)
        def convenio = PlanesNegocio.get(params.convenio)
        return [cantones: cantones, convenio: convenio]
    }

    def planes() {
//        println "planes $params"
        def unidad = UnidadEjecutora.get(params.id)
        def plns = PlanesNegocio.findByUnidadEjecutora(unidad)
        if(!plns){
            plns = new PlanesNegocio()
        }
//        if (params.id) {
//            plan = PlanesNegocio.get(params.id)
//        } else if(params.unej) {
//            plan = PlanesNegocio.findByUnidadEjecutora(seguridad.UnidadEjecutora.get(params.unej))
//        } else {
//            plan = new PlanesNegocio()
//        }
        return [plns: plns, unidad: unidad]
    }

    def buscarPlanesNegocio_ajax() {

    }

    def tablaBuscarPlanesNegocio_ajax() {
//        println("params buc " + params)
        def sql = ''
        def operador = ''

        switch (params.operador) {
            case "0":
                operador = "cnvnnmbr"
                break;
            case '1':
                operador = "cnvncdgo"
                break;
            case "2":
                operador = "unejnmbr"
                break;
            case "3":
                operador = "parrnmbr"
                break;
        }

        def cn = dbConnectionService.getConnection()
        sql = "select cnvn.cnvn__id, cnvncdgo, cnvnnmbr, cnvnfcin, unejnmbr, parrnmbr from cnvn, unej, parr " +
                "where cnvn.parr__id = parr.parr__id and " +
                "unej.unej__id = cnvn.unej__id and ${operador} ilike '%${params.texto}%' " +
                "order by cnvnnmbr asc limit 20"

        def res = cn.rows(sql.toString())

//        println("sql " + sql)

        return [convenios: res]

    }

    def observaciones_ajax() {
        def administrador = AdministradorPlanesNegocio.get(params.id)
        return [administrador: administrador]
    }

    def savePlan_ajax () {
//        println("params sp " + params)

        if(params.fechaAprobacion){
            params.fechaAprobacion = new Date().parse("dd-MM-yyy", params.fechaAprobacion)
        }
        if(params.fechaPresentacion){
            params.fechaPresentacion = new Date().parse("dd-MM-yyy", params.fechaPresentacion)
        }
        if(params.fechaComite){
            params.fechaComite = new Date().parse("dd-MM-yyy", params.fechaComite)
        }

        def plan

        if(params.id){
            plan = PlanesNegocio.get(params.id)
        }else{
            plan = new PlanesNegocio()
        }

        plan.properties = params

        if(!plan.save(flush:true)){
            println("error al guardar el plan de negocio " + plan.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def deletePlan_ajax(){
        def plan = PlanesNegocio.get(params.id)
        try{
            plan.delete(flush:true)
            render"ok"
        }catch(e){
            println("Error al borrar el plan de negocio" + plan.errors)
            render "no"
        }
    }

    def formIndicadores_ajax(){
        def plan = PlanesNegocio.get(params.id)
        return[plan:plan]
    }

    def tablaIndicadores_ajax(){
        def plan = PlanesNegocio.get(params.id)
        def indicadores = IndicadorPlan.findAllByPlanesNegocio(plan)
        return[indicadores:indicadores]
    }

    def agregarIndicador_ajax(){
        def plan = PlanesNegocio.get(params.id)
        def indicador = Indicadores.get(params.indicador)
        def existe = IndicadorPlan.findAllByPlanesNegocioAndIndicadores(plan,indicador)
        def indicadorPlan
        if(existe){
            render "er"
        }else{
            indicadorPlan = new IndicadorPlan()
            indicadorPlan.planesNegocio = plan
            indicadorPlan.indicadores = indicador

            if(!indicadorPlan.save(flush:true)){
                println("error al guardar el indicador inpn " + indicadorPlan.errors)
                render "no"
            }else{
                render "ok"
            }
        }
    }

    def borrarIndicador_ajax(){
        def indicador = IndicadorPlan.get(params.id)
        try{
            indicador.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el indicador inpn")
            render "no"
        }
    }
}
