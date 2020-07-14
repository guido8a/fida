package convenio


import geografia.Comunidad
import geografia.Parroquia
import org.springframework.dao.DataIntegrityViolationException
import proyectos.Proyecto
import convenio.Convenio

class ConvenioController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]
    def dbConnectionService


    /**
     * Acción llamada con ajax que muestra y permite modificar los convenios de un proyecto
     */
    def listConvenio() {
        def proyecto = Proyecto.get(1)
        return [proyecto: proyecto]
    }

    /**
     * Acción llamada con ajax que llena la tabla de los convenios de un proyecto
     */
    def tablaConvenio_ajax() {
        def convenio = Convenio.withCriteria {
            if (params.search && params.search != "") {
                or {
                    ilike("nombre", "%" + params.search + "%")
                    ilike("objetivo", "%" + params.search + "%")
                }
            }
            order("nombre", "asc")
        }
        return [convenio: convenio]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return convenioInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        println "show_ajax: $params"
        if (params.id) {
            def convenioInstance = Convenio.get(params.id)
            if (!convenioInstance) {
                render "ERROR*No se encontró Convenio."
                return
            }
//            println ".... show_ajax ${convenioInstance?.proyecto.nombre}"
            return [convenioInstance: convenioInstance]
        } else {
            render "ERROR*No se encontró Convenio."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return convenioInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def formConvenio_ajax() {
        println "formConvenio_ajax: $params"
        def lugar = ""
        def convenioInstance = new Convenio()
        if (params.id) {
            convenioInstance = Convenio.get(params.id)
            if (!convenioInstance) {
//                render "ERROR*No se encontró Convenio."
//                return
                convenioInstance = new Convenio()
            }
        }
//        convenioInstance.properties = params
        if(convenioInstance?.parroquia){
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
        def convenio
        def texto

        if(params.parroquia){
            def parroquia = Parroquia.get(params.parroquia)

            params.fechaInicio = params.fechaInicio ? new Date().parse("dd-MM-yyyy", params.fechaInicio) : null
            params.fechaFin = params.fechaFin ? new Date().parse("dd-MM-yyyy", params.fechaFin) : null

            if(params.id){
                convenio = Convenio.get(params.id)
                texto = "Convenio actualizado correctamente"
            }else{
                convenio = new Convenio()
                texto = "Convenio creado correctamente"
            }

            params.codigo = params.codigo.toString().toUpperCase()
            convenio.properties = params
            convenio.fecha = new Date()
            convenio.monto = params.monto.toDouble()
            convenio.parroquia = parroquia

            if(!convenio.save(flush:true)){
                println "Error en save de convenio ejecutora\n" + convenio.errors
                render "no*Error al guardar la convenio"
            }else{
                render "SUCCESS*" + texto + "*" + convenio?.id
            }
        }else{
            render "er*Seleccione una parroquia!"
        }
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def convenioInstance = Convenio.get(params.id)
            if (!convenioInstance) {
                render "ERROR*No se encontró el Convenio."
                return
            }
            try {
                convenioInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Convenio exitosa."
            } catch (DataIntegrityViolationException e) {
                println("error al borrar el convenio " + e + convenioInstance.errors )
                render "ERROR*Ha ocurrido un error al eliminar Convenio"
            }
        } else {
            render "ERROR*No se encontró el Convenio."
        }
    } //delete para eliminar via ajax

    def comunidad_ajax(){
        def parroquia = Parroquia.get(params.id)
        def cantones = Comunidad.findAllByParroquia(parroquia)
        def convenio = Convenio.get(params.convenio)
        return [cantones: cantones, convenio: convenio]
    }

    def convenio(){
        def convenio
        if(params.id){
            convenio = Convenio.get(params.id)
        }else{
            convenio = new Convenio()
        }
        return[convenio: convenio]
    }

    def buscarConvenio_ajax(){

    }

    def tablaBuscarConvenio_ajax(){
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
        sql = "select * from cnvn, unej, parr where cnvn.parr__id = parr.parr__id and unej.unej__id = cnvn.unej__id and ${operador} ilike '%${params.texto}%' order by cnvnnmbr asc limit 20"

        def res = cn.rows(sql.toString())

//        println("sql " + sql)

        return [convenios: res]

    }

    def observaciones_ajax(){
        def administrador = AdministradorConvenio.get(params.id)
        return[administrador:administrador]
    }

}
