package reportes

import avales.ProcesoAval
import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Font
import com.lowagie.text.Image
import com.lowagie.text.PageSize
import com.lowagie.text.Paragraph
import com.lowagie.text.pdf.PdfPCell
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfWriter
import jxl.Workbook
import jxl.WorkbookSettings
import jxl.write.Label
import jxl.write.WritableSheet
import jxl.write.WritableWorkbook
//import NumberToLetterConverter
import avales.ProcesoAsignacion
import avales.SolicitudAval
import modificaciones.DetalleReforma
import modificaciones.Reforma

//import modificaciones.SolicitudModPoa
import parametros.Anio
import poa.Asignacion
import seguridad.Firma
import seguridad.Persona
import seguridad.Prfl
import seguridad.Sesn
import seguridad.UnidadEjecutora

import java.awt.Color

/**
 * Controlador que permite generar reportes relacionados con solicitudes y sus aprobaciones
 */
class ReporteSolicitudController {

    def firmasService

    /**
     * Acción que genera un archivo XLS de las solicitudes
     */
    def solicitudesXls = {

        def perfil = session.perfil
        def usuario = Persona.get(session.usuario.id)
        def unidad = usuario.unidad

        def iniRow = 1
        def iniCol = 0

//        mostraba todas las solicitudes
//        def list2 = Solicitud.findAll("from Solicitud order by unidadEjecutora.id,fecha")

//        muestra solo las que correspondel al perfil
        def todos = ["GP", "DP", "DS", "ASAF", "ASGJ", "ASPL", "GAF", "GJ"]

        def c = Solicitud.createCriteria()
        def list2 = c.list(params) {
            if (!todos.contains(perfil.codigo)) {
                eq("unidadEjecutora", unidad)
            }
            if (params.search) {
                ilike("nombreProceso", "%" + params.search + "%")
            }
            //puede ver todas las no aprobadas aun
//            if (["ASAF", "ASGJ", ""].contains(perfil.codigo)) {
            eq("estado", "P")
//            }
            //si es Analista admin. o Analista juridico -> puede ver todas las que no hayan sido ya validadas
            if (perfil.codigo == "ASAF") {
                isNull("validadoAdministrativaFinanciera")
            }
            if (perfil.codigo == "ASGJ") {
                isNull("validadoJuridica")
            }
            //si es Gerencia admin o Gerencia juridica -> puede ver las que ya han sido revisadas por su analista
            if (perfil.codigo == "GAF") {
                isNotNull("revisadoAdministrativaFinanciera")
            }
            if (perfil.codigo == "GJ") {
                isNotNull("revisadoJuridica")
            }
            //si es Director requirente puede ver las ya validadas
            if (perfil.codigo == "DRRQ") {
                isNotNull("validadoAdministrativaFinanciera")
                isNotNull("validadoJuridica")
            }
        }

        def list01 = []
        def list02 = []
        def anios = []

        list2.each { s ->
            def aprobaciones = s.aprobacion
            if (aprobaciones && s.tipoAprobacion?.codigo != "NA") {
                list01 += s
            } else {
                list02 += s
            }
        }
        def list = list01 + list02

        list.each { sol ->
            DetalleMontoSolicitud.findAllBySolicitud(sol, [sort: "anio"]).each { d ->
                if (!anios.contains(d.anio)) {
                    anios.add(d.anio)
                }
            }
        }

        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default
        def file = File.createTempFile('solicitudes', '.xls')
        def label
        def number
        file.deleteOnExit()

        WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)
        def row = iniRow
        def col = iniCol
        WritableSheet sheet = workbook.createSheet('MySheet', 0)

        label = new Label(3, row, "YACHAY EP"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        row++
        label = new Label(3, row, "Lista de solicitudes de contratación"); sheet.addCell(label);
        sheet.setColumnView(col, 30)

        row += 2

        label = new Label(col, row, "Proyecto"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        col++
        label = new Label(col, row, "Componente"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        col++
        label = new Label(col, row, "N.Poa"); sheet.addCell(label);
        sheet.setColumnView(col, 20)
        col++
        label = new Label(col, row, "Nombre"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        col++
        label = new Label(col, row, "Objetivo"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        col++
        label = new Label(col, row, "TDR's"); sheet.addCell(label);
        col++
        label = new Label(col, row, "Responsable"); sheet.addCell(label);
        sheet.setColumnView(col, 20)
        col++
        anios.each { a ->
            label = new Label(col, row, "Valor ${a.anio}"); sheet.addCell(label);
            sheet.setColumnView(col, 20)
            col++
        }
        label = new Label(col, row, "Monto"); sheet.addCell(label);
        sheet.setColumnView(col, 20)
        col++
        label = new Label(col, row, "Aprobacion"); sheet.addCell(label);
        sheet.setColumnView(col, 20)
        col++
        label = new Label(col, row, "Fecha Solicitud"); sheet.addCell(label);
        sheet.setColumnView(col, 20)

        row++
        list.each { solicitudInstance ->
            col = iniCol
            label = new Label(col, row, solicitudInstance.actividad.proyecto.toString()); sheet.addCell(label);
            col++
            label = new Label(col, row, solicitudInstance.actividad.marcoLogico.toString()); sheet.addCell(label);
            col++
            label = new Label(col, row, Asignacion.findByMarcoLogico(solicitudInstance.actividad)?.presupuesto?.numero); sheet.addCell(label);
            col++
            label = new Label(col, row, solicitudInstance.nombreProceso); sheet.addCell(label);
            col++
            label = new Label(col, row, solicitudInstance.objetoContrato); sheet.addCell(label);
            col++
            label = new Label(col, row, "X"); sheet.addCell(label);
            col++
            label = new Label(col, row, solicitudInstance.unidadEjecutora?.codigo); sheet.addCell(label);
            col++

            anios.each { a ->
                def valor = DetalleMontoSolicitud.findByAnioAndSolicitud(a, solicitudInstance)
                if (valor) {
                    number = new jxl.write.Number(col, row, valor.monto); sheet.addCell(number);
                } else {
                    label = new Label(col, row, ""); sheet.addCell(label);
                }
                col++
            }
            number = new jxl.write.Number(col, row, solicitudInstance.montoSolicitado); sheet.addCell(number);
            col++
            def estado = solicitudInstance.aprobacion
            if (estado) {
                label = new Label(col, row, solicitudInstance.tipoAprobacion?.descripcion + " (" + estado?.fechaRealizacion?.format("dd-MM-yyyy") + ")");
                sheet.addCell(label);
                col++
            } else {
                label = new Label(col, row, "Pendiente"); sheet.addCell(label);
                col++
            }
            label = new Label(col, row, solicitudInstance.fecha?.format('dd-MM-yyyy')); sheet.addCell(label);
            col++

            row++
        }

        workbook.write();
        workbook.close();
        def output = response.getOutputStream()
        def header = "attachment; filename=" + "solicitudes.xls";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        output.write(file.getBytes());
    }

    /**
     * Acción que genera un archivo PDF de las solicitudes
     */
    def solicitudes = {
        println "solicitudes"
        def list2 = Solicitud.findAll("from Solicitud order by unidadEjecutora.id,fecha")




        def nombreProceso

        list2.each {

            nombreProceso = it.nombreProceso

            if (nombreProceso) {
                nombreProceso = nombreProceso.replaceAll("&nbsp", " ")
                nombreProceso = nombreProceso.replaceAll("&Oacute;", "Ó")
                nombreProceso = nombreProceso.replaceAll("&oacute;", "ó")
                nombreProceso = nombreProceso.replaceAll("&Aacute;", "Á")
                nombreProceso = nombreProceso.replaceAll("&aacute;", "á")
                nombreProceso = nombreProceso.replaceAll("&Eacute;", "É")
                nombreProceso = nombreProceso.replaceAll("&eacute;", "é")
                nombreProceso = nombreProceso.replaceAll("&Iacute;", "Í")
                nombreProceso = nombreProceso.replaceAll("&iacute;", "í")
                nombreProceso = nombreProceso.replaceAll("&Uacute;", "Ú")
                nombreProceso = nombreProceso.replaceAll("&uacute;", "ú")
                nombreProceso = nombreProceso.replaceAll("&ntilde;", "ñ")
                nombreProceso = nombreProceso.replaceAll("&Ntilde;", "Ñ")
                nombreProceso = nombreProceso.replaceAll("&ldquo;", '"')
                nombreProceso = nombreProceso.replaceAll("&rdquo;", '"')
                nombreProceso = nombreProceso.replaceAll("&lquo;", "'")
                nombreProceso = nombreProceso.replaceAll("&rquo;", "'")

            } else {

                nombreProceso = ""
            }

            it.nombreProceso = nombreProceso
        }

        def list01 = []
        def list02 = []
        def anios = []

        list2.each { s ->
            def aprobaciones = s.aprobacion
            if (aprobaciones && s.tipoAprobacion?.codigo != "NA") {
                list01 += s
            } else {
                list02 += s
            }
        }
        def list = list01 + list02

        list.each { sol ->
            DetalleMontoSolicitud.findAllBySolicitud(sol, [sort: "anio"]).each { d ->
                if (!anios.contains(d.anio)) {
                    anios.add(d.anio)
                }
            }
        }
        return [solicitudInstanceList: list, anios: anios]
    }

    /**
     * Acción que genera un archivo PDF de las solicitudes aprobadas
     */
    def aprobadas = {
//        println "aprobadas"
        def list = []
        def list2 = Solicitud.findAll("from Solicitud order by unidadEjecutora.id,fecha")

        list2.each { s ->
            def aprobaciones = s.aprobacion
            if (aprobaciones && s?.tipoAprobacion && s?.tipoAprobacion?.codigo != "NA") {
                list += s
            }
        }

        def anios = []


        list.each { sol ->
            DetalleMontoSolicitud.findAllBySolicitud(sol, [sort: "anio"]).each { d ->
                if (!anios.contains(d.anio)) {
                    anios.add(d.anio)
                }
            }
        }
        return [solicitudInstanceList: list, anios: anios]
    }

    /**
     * Acción que genera un archivo XLS de las solicitudes aprobadas
     */
    def aprobadasXLS = {
//        println "aprobadas"
        def list = []
        def list2 = Solicitud.findAll("from Solicitud order by unidadEjecutora.id,fecha")

        list2.each { s ->
            if (s.aprobacion && s?.tipoAprobacion && s?.tipoAprobacion?.codigo != "NA") {
                list += s
            }
        }

        def anios = []

//        list = list.sort { it.aprobacion?.descripcion + it.unidadEjecutora?.nombre + it.fecha.format("dd-MM-yyyy") }
//        list = list.sort { a, b ->
//            ((a.aprobacion?.descripcion <=> b.aprobacion?.descripcion) ?:
//                    (a.unidadEjecutora?.nombre <=> b.unidadEjecutora?.nombre)) ?:
//                    (a.fecha?.format("dd-MM-yyyy") <=> b.fecha?.format("dd-MM-yyyy"))
//    }


        list.each { sol ->
            DetalleMontoSolicitud.findAllBySolicitud(sol, [sort: "anio"]).each { d ->
                if (!anios.contains(d.anio)) {
                    anios.add(d.anio)
                }
            }
        }

        def iniRow = 1
        def iniCol = 0

        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default
        def file = File.createTempFile('solicitudes_aprobadas', '.xls')
        def label
        def number
        file.deleteOnExit()

        WritableWorkbook workbook = Workbook.createWorkbook(file, workbookSettings)
        def row = iniRow
        def col = iniCol
        WritableSheet sheet = workbook.createSheet('MySheet', 0)

        label = new Label(3, row, "YACHAY EP"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        row++
        label = new Label(3, row, "Lista de solicitudes de contratación aprobadas"); sheet.addCell(label);
        sheet.setColumnView(col, 30)

        row += 2

        label = new Label(col, row, "Proyecto"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        col++
        label = new Label(col, row, "Componente"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        col++
        label = new Label(col, row, "N.Poa"); sheet.addCell(label);
        sheet.setColumnView(col, 20)
        col++
        label = new Label(col, row, "Nombre"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        col++
        label = new Label(col, row, "Objetivo"); sheet.addCell(label);
        sheet.setColumnView(col, 30)
        col++
        label = new Label(col, row, "TDR's"); sheet.addCell(label);
        col++
        label = new Label(col, row, "Responsable"); sheet.addCell(label);
        sheet.setColumnView(col, 20)
        col++
        anios.each { a ->
            label = new Label(col, row, "Valor ${a.anio}"); sheet.addCell(label);
            sheet.setColumnView(col, 20)
            col++
        }
        label = new Label(col, row, "Monto"); sheet.addCell(label);
        sheet.setColumnView(col, 20)
        col++
        label = new Label(col, row, "Aprobacion"); sheet.addCell(label);
        sheet.setColumnView(col, 20)
        col++
        label = new Label(col, row, "Fecha Solicitud"); sheet.addCell(label);
        sheet.setColumnView(col, 20)

        row++

        list.each { solicitudInstance ->
            col = iniCol
            label = new Label(col, row, solicitudInstance.actividad.proyecto.toString()); sheet.addCell(label);
            col++
            label = new Label(col, row, solicitudInstance.actividad.marcoLogico.toString()); sheet.addCell(label);
            col++
            label = new Label(col, row, Asignacion.findByMarcoLogico(solicitudInstance.actividad)?.presupuesto?.numero); sheet.addCell(label);
            col++
            label = new Label(col, row, solicitudInstance.nombreProceso); sheet.addCell(label);
            col++
            label = new Label(col, row, solicitudInstance.objetoContrato); sheet.addCell(label);
            col++
            label = new Label(col, row, "X"); sheet.addCell(label);
            col++
            label = new Label(col, row, solicitudInstance.unidadEjecutora?.codigo); sheet.addCell(label);
            col++

            anios.each { a ->
                def valor = DetalleMontoSolicitud.findByAnioAndSolicitud(a, solicitudInstance)
                if (valor) {
                    number = new jxl.write.Number(col, row, valor.monto); sheet.addCell(number);
                } else {
                    label = new Label(col, row, ""); sheet.addCell(label);
                }
                col++
            }
            number = new jxl.write.Number(col, row, solicitudInstance.montoSolicitado); sheet.addCell(number);
            col++
            def estado = solicitudInstance.aprobacion
            if (estado) {
                println "1:::: " + estado
                println "2:::: " + estado?.fechaRealizacion
                println "3:::: " + solicitudInstance.tipoAprobacion
                label = new Label(col, row, solicitudInstance.tipoAprobacion?.descripcion + " (" + estado?.fechaRealizacion?.format("dd-MM-yyyy") + ")");
                sheet.addCell(label);
                col++
            } else {
                label = new Label(col, row, "Pendiente"); sheet.addCell(label);
                col++
            }
            label = new Label(col, row, solicitudInstance.fecha?.format('dd-MM-yyyy')); sheet.addCell(label);
            col++

            row++
        }

        workbook.write();
        workbook.close();
        def output = response.getOutputStream()
        def header = "attachment; filename=" + "solicitudes_aprobadas.xls";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        output.write(file.getBytes());
    }

    /**
     * Acción que genera un archivo PDF de una solicitud
     */
    def imprimirSolicitud = {
        def solicitud = Solicitud.get(params.id)

        def firmas = []

        if (solicitud.usuario) {
//            firmas += [cargo: solicitud?.usuario?.cargoPersonal?.descripcion ?: "Responsable unidad", usuario: solicitud.usuario]
            firmas += [cargo: solicitud?.usuario?.cargo ?: "Responsable unidad", usuario: solicitud.usuario]
        }
        return [solicitud: solicitud, firmas: firmas]
    }

    /**
     * Acción que muestra un pdf de la aprobacion de la solicitud
     * @deprecated ya no se usa, se usa imprimirActaReunionAprobacion
     */
    @Deprecated

    /**
     * Acción que genera un archivo PDF de la solicitud de aval
     */
    def imprimirSolicitudAval() {

        println("params ra " + params.id)

        def id
        if(params.id) {
            if(!params.id.contains('&')){
                id = params.id
            } else {
                id = params.id.split('&')[0]
            }
        }

//        def arch = params.id.split('&')[1]
        println "--> id: $id"
        def titulo_rep
        def slav = SolicitudAval.get(id)
        def poas = ProcesoAsignacion.findByProceso(slav?.proceso)
        def anio = poas.asignacion.anio.anio
        def firma = seguridad.Firma.findByIdAccionAndTipoFirmaAndEstado(slav.id, 'AVAL', 'F')
        def firmaAval = seguridad.Firma.findByIdAccionAndTipoFirmaAndEstadoAndAccionAndPathIsNotNull(slav.id, 'AVAL', 'F', 'firmarAval')
        def firma_path = firma?.path
        Image logo = Image.getInstance('/var/fida/logo.png')
        def tipoAval = firmaAval? "aval" : "solicitud"

        Image firma_img
        println "firma_path: $firma_path   firmaaval: ${firmaAval}"
        if (firmaAval) {
            titulo_rep = "AVAL DE POA"
            firma_img = Image.getInstance('/var/fida/firmas/' + firma_path)
            firma_img.setAlignment(Image.ALIGN_CENTER | Image.TEXTWRAP)
        } else {
            firma_img = Image.getInstance('/var/fida/firmas/' + firma_path)
            firma_img.setAlignment(Image.ALIGN_CENTER | Image.TEXTWRAP)
            titulo_rep = "SOLICITUD DE AVAL DE POA"
        }
//            println "firma: ${firma_img}"

        logo.scaleToFit(46, 46)
        logo.setAlignment(Image.RIGHT | Image.TEXTWRAP)
//        logo.setAlignment(Image.RIGHT)

        def baos = new ByteArrayOutputStream()
        def name = "${tipoAval.toLowerCase()}_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        Font times12bold = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font times12normal = new Font(Font.TIMES_ROMAN, 12, Font.NORMAL);
        Font times10bold = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
        Font times10normal = new Font(Font.TIMES_ROMAN, 10, Font.NORMAL);
        Font times14bold = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);
        Font times18bold = new Font(Font.TIMES_ROMAN, 18, Font.BOLD);
        Font times8bold = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)
        Font times8normal = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL)
        Font times10boldWhite = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
        Font times8boldWhite = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)
        def titulo = new Color(40, 140, 180)
        Font fontProyecto = new Font(Font.HELVETICA, 18, Font.NORMAL, titulo);
        Font fontTitulo = new Font(Font.TIMES_ROMAN, 16, Font.BOLD, titulo);

        Document document
        document = new Document(PageSize.A4);
        def pdfw = PdfWriter.getInstance(document, baos);
        document.open();
        document.addTitle("Composicion " + new Date().format("dd_MM_yyyy"));
        document.addSubject("Generado por el sistema FIDA");
        document.addKeywords("reporte, fida, composicion");
        document.addAuthor("FIDA");
        document.addCreator("Tedein SA");

        def prmsHeaderHoja = [border: Color.WHITE]
        def prmsHeader = [border: Color.WHITE, align: Element.ALIGN_JUSTIFIED, valign: Element.ALIGN_MIDDLE]
        def prmsRight = [border: Color.WHITE, colspan: 7, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_RIGHT]
        def prmsHeader2 = [border: Color.WHITE, colspan: 3, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellHead = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellHead3 = [border: Color.WHITE, align: Element.ALIGN_JUSTIFIED, valign: Element.ALIGN_TOP]
        def prmsCellHeadCentro = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_LEFT]
        def prmsCellHead4 = [align: Element.ALIGN_LEFT, valign: Element.ALIGN_LEFT]
        def prmsCellHead2 = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, bordeTop: "1", bordeBot: "1"]
        def prmsCellIzquierda = [border: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_LEFT]
        def prmsCellDerecha = [border: Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_RIGHT]
        def prmsCellDerecha2 = [border: Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_RIGHT, bordeTop: "1", bordeBot: "1"]
        def prmsCellCenter = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellLeft = [border: Color.WHITE, valign: Element.ALIGN_MIDDLE]
        def prmsSubtotal = [border: Color.WHITE, colspan: 6, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsNum = [border: Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def fondo = new Color(240, 248, 250);
        def frmtHd = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bg: fondo, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def frmtBorde = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bg: Color.WHITE, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def frmtHdDerecha = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bg: fondo, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def frmtDato = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def frmtDato2 = [colspan: 9, bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def frmtDatoDerecha = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]


        Paragraph preface = new Paragraph();
        Paragraph pr_firma = new Paragraph();
        addEmptyLine(preface, 1);
        preface.setAlignment(Element.ALIGN_CENTER);
        preface.add(new Paragraph("PROYECTO FAREPS", fontProyecto));
//        addEmptyLine(preface, 1);
        preface.add(new Paragraph(titulo_rep, fontTitulo));
        addEmptyLine(preface, 1);
        document.add(logo)
        document.add(preface);

/*
        PdfCanvas canvas = new PdfCanvas(pdfPage)
        canvas.moveTo(100, 300)
        canvas.lineTo(500, 300)
*/

        PdfPTable tablaCabecera = new PdfPTable(1)
        tablaCabecera.setWidthPercentage(100)
        tablaCabecera.setWidths(arregloEnteros([100]))

        addCellTabla(tablaCabecera, new Paragraph("Con el propósito de ejecutar las actividades programadas en la " +
                "planificación operativa institucional ${anio}, la Unidad Adminisrtativa: ${slav.usuario.unidadEjecutora.nombre} " +
                "solicita emitir el Aval de POA correspondiente al proceso que se detalla a continuación:\n\r", times10normal), prmsHeader)

        PdfPTable tablaHeader = new PdfPTable(9)
        tablaHeader.setWidthPercentage(100)
        tablaHeader.setWidths(arregloEnteros([5, 8, 15, 19, 8, 10, 12, 12, 10]))

        PdfPTable tablaTitulo = new PdfPTable(2)
        tablaTitulo.setWidthPercentage(100)
        tablaTitulo.setWidths(arregloEnteros([90, 10]))

        PdfPTable tablaTotales = new PdfPTable(5)
        tablaTotales.setWidthPercentage(100)
        tablaTotales.setWidths(arregloEnteros([55, 10, 12, 12, 10]))

        PdfPTable tablaPie = new PdfPTable(2)
        tablaPie.setWidthPercentage(100)
        tablaPie.setWidths(arregloEnteros([15, 85]))

        PdfPTable tablaCabecera2 = new PdfPTable(2)
        tablaCabecera2.setWidthPercentage(100)
        tablaCabecera2.setWidths(arregloEnteros([30, 70]))

        addCellTabla(tablaCabecera2, new Paragraph("Proceso", times10bold), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph(slav?.proceso.nombre, times10normal), frmtBorde)

        addCellTabla(tablaCabecera2, new Paragraph("Fecha de Inicio", times10bold), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph(slav?.proceso.fechaInicio?.format("dd-MM-yyyy"), times10normal), frmtBorde)

        addCellTabla(tablaCabecera2, new Paragraph("Fecha de Fin", times10bold), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph(slav?.proceso.fechaFin?.format("dd-MM-yyyy"), times10normal), frmtBorde)

        addCellTabla(tablaCabecera2, new Paragraph("Monto solicitado", times10bold), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph("USD " + g.formatNumber(number: slav?.proceso.monto, format: "##,##0", maxFractionDigits: 2,
                minFractionDigits: 2)?.toString(), times10normal), frmtBorde)

        addCellTabla(tablaCabecera2, new Paragraph("Componente", times10bold), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph(poas?.asignacion?.marcoLogico?.marcoLogico?.objeto, times10normal), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph("Actividad", times10bold), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph(poas?.asignacion?.marcoLogico?.objeto, times10normal), frmtBorde)

        addCellTabla(tablaCabecera2, new Paragraph("Monto del Aval", times10bold), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph("USD " + g.formatNumber(number: slav?.proceso.monto, format: "##,##0", maxFractionDigits: 2,
                minFractionDigits: 2)?.toString(), times10normal), frmtBorde)

        addCellTabla(tablaCabecera2, new Paragraph("Fuente", times10bold), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph(poas?.asignacion?.fuente?.toString(), times10normal), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph("Partida", times10bold), frmtBorde)
        addCellTabla(tablaCabecera2, new Paragraph(poas?.asignacion?.presupuesto?.toString(), times10normal), frmtBorde)


        addCellTabla(tablaPie, new Paragraph("", times10normal), frmtDato2)
//        addCellTabla(tablaPie, new Paragraph("", times10normal), prmsCellHead3)
        addCellTabla(tablaPie, new Paragraph("Elaborado por:", times10bold), prmsCellHead3)
        addCellTabla(tablaPie, new Paragraph(slav.usuario.nombreCompleto, times10normal), prmsCellHead3)
        addCellTabla(tablaPie, new Paragraph("Fecha:", times10bold), prmsCellHead3)
        addCellTabla(tablaPie, new Paragraph(slav?.fecha?.format("dd-MM-yyyy"), times10normal), prmsCellHead3)

        document.add(tablaCabecera);
        document.add(tablaCabecera2);
        document.add(tablaHeader);
        document.add(tablaPie)

        if (firma_path) {
//        preface.add(new Paragraph("MATRIZ DE REFORMA", fontTitulo));
            pr_firma.setAlignment(Element.ALIGN_CENTER)
            pr_firma.add(new Paragraph("Firmado por: ${firma.usuario.nombreCompleto}", times12bold));
//        addEmptyLine(pr_firma, 1)
            document.add(pr_firma)

            document.add(firma_img)
        }

        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + name)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    /**
     * Acción que genera un archivo PDF de la negacion de la solicitud de aval
     */
    def imprimirSolicitudAnulacionAval = {
        println "impr sol " + params
        def solicitud = SolicitudAval.get(params.id)
        println "solcitud " + solicitud
        return [solicitud: solicitud]
    }

    def imprimirActaReunionAprobacion = {
        def reunion = Aprobacion.get(params.id.toLong())
        def solicitudes = Solicitud.findAllByAprobacion(reunion)
        def firmas = []
        def anios = []
        if (reunion.firmaGerenciaTecnica || reunion.firmaDireccionPlanificacion || reunion.firmaGerenciaPlanificacion) {
            def gerentePlanificacion = reunion.firmaGerenciaPlanificacion
            if (gerentePlanificacion) {
                firmas += [cargo: gerentePlanificacion?.cargoPersonal?.descripcion ?: "GERENTE DE PLANIFICACIÓN", usuario: gerentePlanificacion]
            }
            def directorPlanificacion = reunion.firmaDireccionPlanificacion
            if (directorPlanificacion) {
                firmas += [cargo: directorPlanificacion?.cargoPersonal?.descripcion ?: "DIRECTOR DE PLANIFICACIÓN", usuario: directorPlanificacion]
            }
            def gerenteTec = reunion.firmaGerenciaTecnica
            if (gerenteTec) {
                firmas += [cargo: gerenteTec?.cargoPersonal?.descripcion ?: "GERENTE TÉCNICO", usuario: gerenteTec]
            }
        } else {
            if (params.fgp != "null") {
                def gerentePlanificacion = Persona.get(params.fgp)
                reunion.firmaGerenciaPlanificacion = gerentePlanificacion
                if (gerentePlanificacion) {
                    firmas += [cargo: gerentePlanificacion?.cargoPersonal?.descripcion ?: "GERENTE DE PLANIFICACIÓN", usuario: gerentePlanificacion]
//                firmas += [cargo: "GERENTE DE PLANIFICACIÓN", usuario: gerentePlanificacion]
                }
            }
            if (params.fdp != "null") {
                def directorPlanificacion = Persona.get(params.fdp)
                reunion.firmaDireccionPlanificacion = directorPlanificacion
                if (directorPlanificacion) {
//                firmas += [cargo: "DIRECTOR DE PLANIFICACIÓN", usuario: directorPlanificacion]
                    firmas += [cargo: directorPlanificacion?.cargoPersonal?.descripcion ?: "DIRECTOR DE PLANIFICACIÓN", usuario: directorPlanificacion]
                }
            }
            if (params.fgt != "null") {
                def gerenteTec = Persona.get(params.fgt)
                reunion.firmaGerenciaTecnica = gerenteTec
                if (gerenteTec) {
//                firmas += [cargo: "GERENTE TÉCNICO", usuario: gerenteTec]
                    firmas += [cargo: gerenteTec?.cargoPersonal?.descripcion ?: "GERENTE TÉCNICO", usuario: gerenteTec]
                }
            }
            if (!reunion.save(flush: true)) {
                println "error save reunion firmas: " + reunion.errors
            }
        }
        solicitudes.each { sol ->
            DetalleMontoSolicitud.findAllBySolicitud(sol, [sort: "anio"]).each { d ->
                if (!anios.contains(d.anio)) {
                    anios.add(d.anio)
                }
            }
        }

        return [reunion: reunion, solicitudes: solicitudes, firmas: firmas, anios: anios]
    }

    def solicitudReformaPdf = {
        def sol = SolicitudModPoa.get(params.id)
        def fecha = sol.fecha.format("dd-MM-yyyy")
        def nmroMemo = ''
        def para = 'Srta Econ. Rocio Elizabeth Gavilanes Reyes'
        def cargo = 'GERENTE DE PLANIFICACIÓN'
        def asunto = 'Solicitud de reforma del POA'
        def nombreFirma = sol.usuario
        def cargofirma = ''
        def gerente = Sesn.findByPerfil(Prfl.findByCodigo("GP"))
        if (gerente) {
            gerente = gerente.usuario
        }
        return [fecha: fecha, numero: nmroMemo, para: para, cargo: cargo, asunto: asunto, nombreFirma: nombreFirma, cargoFirma: cargofirma, gerente: gerente, solicitud: sol]


    }

    def respuestaSolicitudReforma = {

        def fecha = new Date().format("dd-MM-yyyy")
        def nmroMemo = 'YACHAY-GAF-2014-0102-MI'
        def para = 'Srta Abg. Gabriela Valeria Diaz Peñafiel'
        def cargo = 'Gerente de Planificación'
        def asunto = 'solicitud de reforma del poa'
        def nombreFirma = 'Abg. Gabriela Valeria Diaz Peñafiel'
        def cargofirma = 'GERENTE ADMINISTRATIVA FINANCIERA'

        return [fecha: fecha, numero: nmroMemo, para: para, cargo: cargo, asunto: asunto, nombreFirma: nombreFirma, cargoFirma: cargofirma]
    }

    def solicitudAvalCorriente() {
        def proceso = AvalCorriente.get(params.id)

        def firma

        if(proceso.firmaGerente){
            firma = Firma.get(proceso.firmaGerente.id)
        }else{
            firma = null
        }


        return [proceso: proceso, detalles: AvalCorrienteController.arreglarDetalles(proceso), firma: firma]
    }

    def avalCorriente() {
        def proceso = AvalCorriente.get(params.id)
        def transf = NumberToLetterConverter.convertNumberToLetter(proceso?.monto)

        return [proceso: proceso, detalles: AvalCorrienteController.arreglarDetalles(proceso), transf: transf]
    }




    def addCellTabla(table, paragraph, params) {
        PdfPCell cell = new PdfPCell(paragraph);
        cell.setBorderColor(Color.BLACK);

        if (params.border) {
            if (!params.bordeBot)
                if (!params.bordeTop)
                    cell.setBorderColor(params.border);
        }
        if (params.bg) {
            cell.setBackgroundColor(params.bg);
        }
        if (params.colspan) {
            cell.setColspan(params.colspan);
        }
        if (params.align) {
            cell.setHorizontalAlignment(params.align);
        }
        if (params.valign) {
            cell.setVerticalAlignment(params.valign);
        }
        if (params.w) {
            cell.setBorderWidth(params.w);
        }
        if (params.bordeTop) {
            cell.setBorderWidthTop(1)
            cell.setBorderWidthLeft(0)
            cell.setBorderWidthRight(0)
            cell.setBorderWidthBottom(0)
            cell.setPaddingTop(7);
        }
        if (params.bordeBot) {
            cell.setBorderWidthBottom(1)
            cell.setBorderWidthLeft(0)
            cell.setBorderWidthRight(0)
            cell.setPaddingBottom(7)

            if (!params.bordeTop) {
                cell.setBorderWidthTop(0)
            }
        }
        table.addCell(cell);
    }


    static arregloEnteros(array) {
        int[] ia = new int[array.size()]
        array.eachWithIndex { it, i ->
            ia[i] = it.toInteger()
        }

        return ia
    }

    private String numero(num, decimales, cero) {
        if (num == 0 && cero.toString().toLowerCase() == "hide") {
            return " ";
        }
        if (decimales == 0) {
            return formatNumber(number: num, minFractionDigits: decimales, maxFractionDigits: decimales, locale: "ec")
        } else {
            def format
            if (decimales == 2) {
                format = "##,##0"
            } else if (decimales == 3) {
                format = "##,###0"
            }
            return formatNumber(number: num, minFractionDigits: decimales, maxFractionDigits: decimales, locale: "ec", format: format)
        }
    }

    private String numero(num, decimales) {
        return numero(num, decimales, "show")
    }

    private String numero(num) {
        return numero(num, 3)
    }


    private static void addEmptyLine(Paragraph paragraph, int number) {
        for (int i = 0; i < number; i++) {
            paragraph.add(new Paragraph(" "));
        }
    }


}
