package proyectos

import groovy.io.FileType
import jxl.DateCell
import jxl.Sheet
import jxl.Workbook
import jxl.WorkbookSettings
import org.springframework.dao.DataIntegrityViolationException
import org.springframework.web.servlet.support.RequestContextUtils
import parametros.proyectos.TipoElemento
//import vesta.parametros.UnidadEjecutora
//import vesta.seguridad.Persona
//import vesta.seguridad.Shield

/**
 * Controlador que muestra las pantallas de manejo de Proyecto
 */
class ProyectoController {

    static allowedMethods = [save_ajax: "POST", delete_ajax: "POST"]
    def dbConnectionService

    /**
     * Acción que redirecciona a la lista (acción "list")
     */
    def index() {
        redirect(action: "list", params: params)
    }

    /**
     * Función que saca la lista de elementos según los parámetros recibidos
     * @param params objeto que contiene los parámetros para la búsqueda:: max: el máximo de respuestas, offset: índice del primer elemento (para la paginación), search: para efectuar búsquedas
     * @param all boolean que indica si saca todos los resultados, ignorando el parámetro max (true) o no (false)
     * @return lista de los elementos encontrados
     */
    List<Proyecto> getList(params, all) {
//        println "GET LIST: " + params + "   " + all
        params = params.clone()
        params.max = params.max ? Math.min(params.max.toInteger(), 100) : 10
        params.offset = params.offset ?: 0
        if (all) {
            params.remove("max")
            params.remove("offset")
        }
        def list
//        println "PARAMS: " + params
        if (!params.sort) {
            params.sort = 'codigo'
        }
        if (!params.order) {
            params.order = 'asc'
        }

        if (params.search_programa || params.search_nombre || params.search_desde || params.search_hasta) {
            def c = Proyecto.createCriteria()
            list = c.list(params) {
                if (params.search_programa) {
                    programa {
                        ilike("descripcion", "%" + params.search_programa + "%")
                    }
                }
                if (params.search_nombre) {
                    ilike("nombre", "%" + params.search_nombre + "%")
                }
                if (params.search_desde) {
                    ge("monto", params.search_desde.replaceAll(",", "").toDouble())
                }
                if (params.search_hasta) {
                    le("monto", params.search_hasta.replaceAll(",", "").toDouble())
                }
            }
        } else {
            list = Proyecto.list(params)
        }
        if (!all && params.offset.toInteger() > 0 && list.size() == 0) {
            params.offset = params.offset.toInteger() - 1
            list = getList(params, all)
        }
        return list
    }

    /**
     * Acción que muestra la lista de elementos
     * @return proyectoInstanceList: la lista de elementos filtrados, proyectoInstanceCount: la cantidad total de elementos (sin máximo)
     */
    def list() {
        println "proyectos list $params"
        params.max = params.max?:10
        params.max = Math.max(params.max.toInteger(), 15)
        def proyectoInstanceList = getList(params, false)
        def proyectoInstanceCount = getList(params, true).size()

        def sql = "select distinct anio.anio__id id, anioanio anio from anio, asgn " +
                "where asgn.anio__id = anio.anio__id and mrlg__id is not null order by anioanio "

        def cn = dbConnectionService.getConnection()

        def anios = cn.rows(sql.toString())

        def usu = Persona.get(session.usuario.id)

        return [proyectoInstanceList: proyectoInstanceList, proyectoInstanceCount: proyectoInstanceCount, anios: anios, usu: usu]
    }

    /**
     * Acción llamada con ajax que muestra la información de un elemento particular
     * @return proyectoInstance el objeto a mostrar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def show_ajax() {
        if (params.id) {
            def proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                render "ERROR*No se encontró Proyecto."
                return
            }
            def metas = MetaBuenVivirProyecto.findAllByProyecto(proyectoInstance)
            def financiamientos = Financiamiento.findAllByProyecto(proyectoInstance, [sort: "anio"])
            return [proyectoInstance: proyectoInstance, metas: metas, financiamientos: financiamientos]
        } else {
            render "ERROR*No se encontró Proyecto."
        }
    } //show para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que muestra un formulario para crear o modificar un elemento
     * @return proyectoInstance el objeto a modificar cuando se encontró el elemento
     * @render ERROR*[mensaje] cuando no se encontró el elemento
     */
    def form_ajax() {
        def proyectoInstance = new Proyecto()
        if (params.id) {
            proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                render "ERROR*No se encontró Proyecto."
                return
            }
        }
        proyectoInstance.properties = params
        return [proyectoInstance: proyectoInstance]
    } //form para cargar con ajax en un dialog

    /**
     * Acción llamada con ajax que guarda la información de un elemento
     * @render ERROR*[mensaje] cuando no se pudo grabar correctamente, SUCCESS*[mensaje] cuando se grabó correctamente
     */
    def save_ajax() {
        println "$params"
        def proyectoInstance = new Proyecto()
        if (params.id) {
            proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                render "ERROR*No se encontró Proyecto."
                return
            }
        }
        params.monto = params.monto ? params.monto.toDouble() : 0
        params.fechaInicio = params.fechaInicio ? new Date().parse("dd-MM-yyyy", params.fechaInicio) : null
        params.fechaFin = params.fechaFin ? new Date().parse("dd-MM-yyyy", params.fechaFin) : null

        proyectoInstance.properties = params

        if (!proyectoInstance.save(flush: true)) {
            println proyectoInstance.errors
            render "er_" + renderErrors(bean: proyectoInstance)
            return
        }
        println "ok_${proyectoInstance.id} ${params.id ? 'Actualización' : 'Creación'} de Proyecto exitosa.*"
        render "ok_${proyectoInstance.id}_${params.id ? 'Actualización' : 'Creación'} de Proyecto exitosa.*"
        return
    } //save para grabar desde ajax

    /**
     * Acción llamada con ajax que permite eliminar un elemento
     * @render ERROR*[mensaje] cuando no se pudo eliminar correctamente, SUCCESS*[mensaje] cuando se eliminó correctamente
     */
    def delete_ajax() {
        if (params.id) {
            def proyectoInstance = Proyecto.get(params.id)
            if (!proyectoInstance) {
                render "ERROR*No se encontró Proyecto."
                return
            }
            try {
                proyectoInstance.delete(flush: true)
                render "SUCCESS*Eliminación de Proyecto exitosa."
                return
            } catch (DataIntegrityViolationException e) {
                render "ERROR*Ha ocurrido un error al eliminar Proyecto"
                return
            }
        } else {
            render "ERROR*No se encontró Proyecto."
            return
        }
    } //delete para eliminar via ajax

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad codigo
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_codigo_ajax() {
        params.codigo = params.codigo.toString().trim()
        if (params.id) {
            def obj = Proyecto.get(params.id)
            if (obj.codigo.toLowerCase() == params.codigo.toLowerCase()) {
                render true
                return
            } else {
                render Proyecto.countByCodigoIlike(params.codigo) == 0
                return
            }
        } else {
            render Proyecto.countByCodigoIlike(params.codigo) == 0
            return
        }
    }

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad codigoEsigef
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_codigoEsigef_ajax() {
        params.codigoEsigef = params.codigoEsigef.toString().trim()
        if (params.id) {
            def obj = Proyecto.get(params.id)
            if (obj.codigoEsigef.toLowerCase() == params.codigoEsigef.toLowerCase()) {
                render true
                return
            } else {
                render Proyecto.countByCodigoEsigefIlike(params.codigoEsigef) == 0
                return
            }
        } else {
            render Proyecto.countByCodigoEsigefIlike(params.codigoEsigef) == 0
            return
        }
    }

    /**
     * Acción llamada con ajax que valida que no se duplique la propiedad codigoProyecto
     * @render boolean que indica si se puede o no utilizar el valor recibido
     */
    def validar_unique_codigoProyecto_ajax() {
        params.codigoProyecto = params.codigoProyecto.toString().trim()
        if (params.id) {
            def obj = Proyecto.get(params.id)
            if (obj.codigoProyecto.toLowerCase() == params.codigoProyecto.toLowerCase()) {
                render true
                return
            } else {
                render Proyecto.countByCodigoProyectoIlike(params.codigoProyecto) == 0
                return
            }
        } else {
            render Proyecto.countByCodigoProyectoIlike(params.codigoProyecto) == 0
            return
        }
    }

    /**
     * Acción llamada con ajax que carga un combo box de estrategias de un objetivo estratégico en particular
     */
/*
    def estrategiaPorObjetivo_ajax = {
        def estrategias = []
        def estr = new Estrategia()
        if (params.proy__id) {
            def proyecto = Proyecto.get(params.proy__id.toLong())
            if (proyecto.estrategia) {
                estr = proyecto.estrategia
            }
        }
        if (params.id != "null") {
            def obj = ObjetivoEstrategicoProyecto.get(params.id.toLong())
            estrategias = Estrategia.findAllByObjetivoEstrategico(obj, [sort: 'descripcion'])
        }
        def select = g.select(id: "estrategia", name: "estrategia.id", from: estrategias,
                optionKey: "id", value: estr?.id, title: "Estrategia del proyecto",
                class: "estrategia many-to-one form-control input-sm")

        select+="<script type='text/javascript'>\$('#estrategia').qtip({\n" +
                "        style    : {\n" +
                "            classes : 'qtip-tipsy'\n" +
                "        },\n" +
                "        position : {\n" +
                "            my : \"bottom center\",\n" +
                "            at : \"top center\"\n" +
                "        }\n" +
                "    });</script>"

        render select.toString()
    }
*/

    /**
     * Acción que muestra la lista de proyectos por aprobar
     */
    def listaAprobarProyecto = {
        println "lista " + params
        //        def proyectos = []
//        if (params.parametro && params.parametro.trim().size() > 0) {
//            proyectos += Proyecto.findAllByNombreIlike("%${params.parametro}%")
//            proyectos += Proyecto.findAllByCodigoProyectoIlike("%${params.parametro}%")
//        } else {
//            proyectos = Proyecto.list(params)
//        }
        def proyectoInstanceList = getList(params, false)
        def proyectoInstanceCount = getList(params, true).size()
//        return [proyectoInstanceList: proyectoInstanceList, proyectoInstanceCount: proyectoInstanceCount]
        return [proyectoInstanceList: proyectoInstanceList, proyectoInstanceCount: proyectoInstanceCount, params: params]
    }

    /**
     * Acción llamada con ajax que marca un proyecto como aprobado
     */
    def aprobarProyecto_ajax() {
        if (request.method == 'POST') {
            if (session.usuario.autorizacion == params.auth.encodeAsMD5()) {
                def proy = Proyecto.get(params.proy.toLong())
                proy.aprobado = "a"
                if (proy.save(flush: true)) {
                    render "SUCCESS*Proyecto aprobado exitosamente"
                } else {
                    render "ERROR*" + renderErrors(bean: proy)
                }
            } else {
                render "ERROR*Su clave de autorización es incorrecta"
            }
        } else {
            response.sendError(403)
        }
    }

    /**
     * Acción
     */
    def cargarExcel = {

    }

    /*Función para cargar un archivo excel con componentes y actividades*/
    /**
     * Acción
     */
    def subirExcel = {

//        println "subir excel "+params
        def path = servletContext.getRealPath("/") + "excel/"
        new File(path).mkdirs()
        def ext
        try {
            def f = request.getFile('file')
            WorkbookSettings ws = new WorkbookSettings();
            ws.setEncoding("ISO-8859-1");
            Workbook workbook = Workbook.getWorkbook(f.inputStream, ws)
            Sheet sheet = workbook.getSheet(0)
            if (f && !f.empty) {
                def nombre = f.getOriginalFilename()
                def parts = nombre.split("\\.")
                nombre = ""
                parts.eachWithIndex { obj, i ->
                    if (i < parts.size() - 1) {
                        nombre += obj
                    } else {
                        ext = obj
                    }
                }

                def reps = [
                        "a": "[àáâãäåæ]",
                        "e": "[èéêë]",
                        "i": "[ìíîï]",
                        "o": "[òóôõöø]",
                        "u": "[ùúûü]",

                        "A": "[ÀÁÂÃÄÅÆ]",
                        "E": "[ÈÉÊË]",
                        "I": "[ÌÍÎÏ]",
                        "O": "[ÒÓÔÕÖØ]",
                        "U": "[ÙÚÛÜ]",

                        "n": "[ñ]",
                        "c": "[ç]",

                        "N": "[Ñ]",
                        "C": "[Ç]",

                        "" : "[\\!@#\\\$%\\^&*()-='\"\\/<>:;\\.,\\?]",

                        "_": "[\\s]"
                ]
                reps.each { k, v ->
                    nombre = (nombre.trim()).replaceAll(v, k)
                }

                nombre = nombre + "." + ext

                def pathFile = path + File.separatorChar + nombre
                def src = new File(pathFile)

                def tipoComponente = TipoElemento.findByDescripcion("Componente")
                def tipoActivdad = TipoElemento.findByDescripcion("Actividad")
                def unidad = UnidadEjecutora.findByNombre("YACHAY EP")
                def proyectos = []
                def componentes = []
                def acts = []
//                println "unidad "+unidad//
                println "locale " + RequestContextUtils.getLocale(request)
                // println("path " + pathFile )

                if (ext == 'xls') {
                    if (src.exists()) {
                        flash.message = 'Ya existe un archivo con ese nombre. Por favor cambielo o elimine el otro archivo primero.'
                        flash.estado = "error"
                        flash.icon = "alert"
                        redirect(action: 'cargarExcel')
                        return
                    } else {
                        println "inicio proceso "
                        //   println "rows "+sheet.getRows()
                        // println "columns "+sheet.getColumns()
                        def posiciones = [:]
                        posiciones["codigoProyecto"] = 0
                        posiciones["nombreProyecto"] = 1
                        posiciones["nombreComponente"] = 2
                        posiciones["codigoEsigef"] = 4
                        posiciones["numeroComponente"] = 5
                        posiciones["partida"] = 6
                        posiciones["numeroActividad"] = 7
                        posiciones["nombreActividad"] = 8
                        posiciones["responsable"] = 9
                        posiciones["inicio"] = 10
                        posiciones["fin"] = 11
                        posiciones["stotal"] = 12
                        posiciones["total"] = 15
                        for (int r = 2; r < sheet.rows; r++) {
                            DateCell dCell = null;
                            DateCell dCellF = null;
                            println "row for ${r}------------------------------------------------------------------------------------------- " + sheet.getRow(r)[posiciones["codigoProyecto"]].contents
                            if (sheet.getRow(r)[posiciones["codigoProyecto"]].contents && sheet.getRow(r)[posiciones["codigoProyecto"]].contents != "" && sheet.getRow(r)[posiciones["codigoProyecto"]].contents != " ") {
                                def total = sheet.getRow(r)[posiciones["total"]].contents
                                if (total && total != "" && total != "-") {
                                    total = total.replaceAll(",", "")
                                    total = total.toDouble()
                                } else {
                                    total = sheet.getRow(r)[posiciones["stotal"]].contents
                                    if (total && total != "" && total != "-") {
                                        total = total.replaceAll(",", "")
                                        total = total.toDouble()
                                    } else {
                                        total = 0
                                    }

                                }
                                println "total " + total + " ---  " + sheet.getRow(r)[posiciones["total"]].contents + " --  " + sheet.getRow(r)[posiciones["stotal"]].contents
                                def proyecto = Proyecto.findByCodigoEsigef(sheet.getRow(r)[posiciones["codigoEsigef"]].contents)
                                // println "proyecto " + proyecto + "   " + sheet.getRow(r)[posiciones["codigoEsigef"]].contents
                                if (!proyecto) {
                                    proyecto = new Proyecto()
                                    proyecto.nombre = sheet.getRow(r)[posiciones["nombreProyecto"]].contents
                                    proyecto.codigo = sheet.getRow(r)[posiciones["codigoProyecto"]].contents
                                    //proyecto.codigoProyecto = sheet.getRow(r)[posiciones["codigoProyecto"]].contents
                                    proyecto.codigoEsigef = sheet.getRow(r)[posiciones["codigoEsigef"]].contents
                                    proyecto.unidadEjecutora = unidad
                                    proyecto.monto = total
                                    if (!proyecto.save(flush: true)) {
                                        println "error save proyecto subir execel " + proyecto.errors
                                        break;
                                        flash.message = "Error "
                                        redirect(action: "cargarExcel")
                                        return
                                    }
                                    println "nuevo proy " + proyecto.monto
                                    proyectos.add(proyecto.id)
                                } else {
                                    if (proyectos.contains(proyecto.id)) {
                                        proyecto.monto += total
                                    } else {
                                        proyectos.add(proyecto.id)
                                        proyecto.monto = total
                                    }
                                    proyecto.save()
                                }
                                def numeroComp = sheet.getRow(r)[posiciones["numeroComponente"]].contents
                                //     def componente = MarcoLogico.findByTipoElementoAndNumeroComp(tipoComponente,sheet.getRow(r)[posiciones["numeroComponente"]].contents)
                                def componente = MarcoLogico.findAll("from MarcoLogico where proyecto=${proyecto.id} and tipoElemento=${tipoComponente.id} and numeroComp='${numeroComp}'")

                                //  println "componente "+componente+" "+sheet.getRow(r)[posiciones["numeroComponente"]].contents
                                if (componente.size() == 0) {
                                    componente = new MarcoLogico()
                                    componente.proyecto = proyecto
                                    componente.numeroComp = sheet.getRow(r)[posiciones["numeroComponente"]].contents
                                    componente.objeto = sheet.getRow(r)[posiciones["nombreComponente"]].contents
                                    componente.monto = total
                                    componente.tipoElemento = tipoComponente
                                    if (!componente.save(flush: true)) {
                                        println "error save componente subir execel " + componente.errors
                                        break;
                                        flash.message = "Error "
                                        redirect(action: "cargarExcel")
                                        return
                                    }
                                    componentes.add(componente.id)
                                } else {
                                    componente = componente.pop()
                                    if (componentes.contains(componente.id)) {
                                        componente.monto += total
                                    } else {
                                        componentes.add(componente.id)
                                        componente.monto = total
                                    }
                                    componente.save()
                                }
                                def numeroAct = sheet.getRow(r)[posiciones["numeroActividad"]].contents
                                if (numeroAct) {
                                    numeroAct = numeroAct.split("-")
                                    numeroAct = numeroAct[1]
                                    numeroAct = numeroAct.toInteger()
                                } else {
                                    break;
                                    flash.message = "Error "
                                    redirect(action: "cargarExcel")
                                    return
                                }
                                def resp = UnidadEjecutora.findByCodigo(sheet.getRow(r)[posiciones["responsable"]].contents)
                                // println "resp "+resp +"  "+sheet.getRow(r)[posiciones["responsable"]].contents
                                def actividad = MarcoLogico.findByTipoElementoAndNumero(tipoActivdad, numeroAct)
                                //println "actividad "+actividad+"  "+numeroAct
                                if (!actividad) {
                                    actividad = new MarcoLogico()
                                    actividad.numero = numeroAct
                                    actividad.monto = total
                                } else {
                                    if (acts.contains(actividad.id)) {
                                        actividad.monto += total
                                    } else {
                                        acts.add(actividad.id)
                                        actividad.monto = total
                                    }
                                }
                                actividad.proyecto = proyecto
                                actividad.marcoLogico = componente

                                actividad.objeto = sheet.getRow(r)[posiciones["nombreActividad"]].contents
                                actividad.tipoElemento = tipoActivdad
                                actividad.responsable = resp
                                //  println "inicio excel  "+sheet.getRow(r)[posiciones["inicio"]].contents
                                // println "fin excel "+sheet.getRow(r)[posiciones["fin"]].contents+"   "+sheet.getCell(posiciones["fin"], r);
                                def inicio = null
                                def fin = null
                                if (sheet.getRow(r)[posiciones["inicio"]].contents && sheet.getRow(r)[posiciones["inicio"]].contents != "-") {
                                    dCell = (DateCell) sheet.getCell(posiciones["inicio"], r);
                                    inicio = dCell.getDate()
                                }
                                if (sheet.getRow(r)[posiciones["fin"]].contents && sheet.getRow(r)[posiciones["fin"]].contents != "-") {
                                    dCell = (DateCell) sheet.getCell(posiciones["fin"], r);
                                    fin = dCell.getDate()
                                }
                                // println "inicio date  "+inicio?.format("dd-MM-yyyy")
                                // println "fin date  "+fin?.format("dd-MM-yyyy")
                                actividad.fechaInicio = inicio
                                actividad.fechaFin = fin
                                if (!actividad.save(flush: true)) {
                                    println "error save actividad subir execel " + actividad.errors
                                    break;
                                    flash.message = "Error "
                                    redirect(action: "cargarExcel")
                                    return
                                }
                                if (!acts.contains(actividad.id)) {
                                    acts.add(actividad.id)
                                }

                                // println "-->monto fin!!!!!!! para ${proyecto.id} " + proyecto.monto
                            }
                        }

//                    f.transferTo(new File(pathFile))
//                    println("Guardado!!")


                        flash.message = 'Archivo cargado existosamente.'
                        flash.estado = "error"
                        flash.icon = "alert"
//                    redirect(action: 'cargarExcel')
                        redirect(controller: 'proyecto', action: 'cargarExcel')
                        return
                    }
                } else {
                    flash.message = 'El archivo a cargar debe ser del tipo EXCEL con extensión XLS.'
                    flash.estado = "error"
                    flash.icon = "alert"
                    redirect(action: 'cargarExcel')
                    return
                }


            } else {
                flash.message = 'No se ha seleccionado ningun archivo para cargar'
                flash.estado = "error"
                flash.icon = "alert"
                redirect(action: 'cargarExcel')
                return
            }
        } catch (e) {
            flash.message = 'Error al cargar el archivo Excel, revise que el formato sea el correcto y que las columnas coincidan con el ejemplo descrito en la parte inferior'
            flash.estado = "error"
            flash.icon = "alert"
            e.printStackTrace()
            redirect(action: 'cargarExcel')
            return
        }

    }

    def proy() {
        def proy = Proyecto.get(1)

        def list = []
        def dir = new File("/var/proyecto/${proy?.id}")
        if (dir.size() > 0) {
            dir.eachFileRecurse(FileType.FILES) { file ->
                list << file
            }
        }

        def partes = []
        def contadorImas = 0
        def contadorOtros = 0

        list.each {

            partes = it.name.split("\\.")
            if (partes[1] in ['jpeg', 'png', 'jpg']) {
                contadorImas++
            } else {
                contadorOtros++
            }

        }

        return [proy: proy, lista: list, contadorImas: contadorImas, contadorOtros: contadorOtros]
    }


    def validarNombre_ajax() {
        def nombre = params.nombre
        println "nombre: $nombre --> ${nombre.contains('FAREPS')}"
        if (nombre.contains('FAREPS')) {
            render true
            return
        } else {
            render false
            return
        }
    }

    def cambiarEstado_ajax(){
//        println("params ce " + params)

        def proyecto = Proyecto.get(params.id)
        def marcos = MarcoLogico.findAllByProyecto(proyecto)
        def modificaciones = ModificacionMarcoLogico.findAllByMarcoLogicoInList(marcos)
        def band = ''

        if(proyecto.fechaRegistro){
            if(MarcoLogico.findAllByProyectoAndFechaGreaterThanEquals(proyecto, proyecto.fechaRegistro)){
                render "er"
            }else{
                band = 'R'
            }
        }else{
                band = 'N'
        }

        if(modificaciones){
            render"er"
        }else{
            if(band == 'R'){
                proyecto.fechaRegistro = null
            }else{
                proyecto.fechaRegistro = new Date()
            }

            if(!proyecto.save(flush:true)){
                render "no"
            }else{
                render "ok"
            }
        }
    }
}
