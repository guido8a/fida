package reportes

import avales.ProcesoAsignacion
import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Font
import com.lowagie.text.Image
import com.lowagie.text.PageSize
import com.lowagie.text.Paragraph
import com.lowagie.text.pdf.PdfPCell
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfWriter
import grails.converters.JSON
import groovy.json.JsonBuilder
import jxl.CellView
import jxl.WorkbookSettings
import jxl.write.Label
import jxl.write.NumberFormat
import jxl.write.WritableCellFormat
import jxl.write.WritableFont
import jxl.write.WritableSheet
import jxl.write.WritableWorkbook
import modificaciones.DetalleReforma
import modificaciones.Reforma
import org.apache.poi.ss.usermodel.IndexedColors
import org.apache.poi.ss.usermodel.Workbook
import org.apache.poi.xssf.usermodel.XSSFColor
import org.apache.poi.xssf.usermodel.XSSFCreationHelper
import parametros.Anio
import parametros.Mes
import parametros.proyectos.TipoElemento
import poa.Asignacion
import poa.ProgramacionAsignacion
import preguntas.DetalleEncuesta
import preguntas.Encuesta
import preguntas.Pregunta
import proyectos.MarcoLogico
import proyectos.Proyecto

import org.apache.poi.ss.usermodel.CellStyle
import org.apache.poi.ss.util.CellRangeAddress
import org.apache.poi.xssf.usermodel.XSSFCell as Cell
import org.apache.poi.xssf.usermodel.XSSFRow as Row
import org.apache.poi.xssf.usermodel.XSSFSheet as Sheet
import org.apache.poi.xssf.usermodel.XSSFWorkbook as Workbook
import seguridad.TipoInstitucion
import seguridad.UnidadEjecutora

import java.awt.Color

class ReportesController {

    def dbConnectionService

    def reporteAjustes() {

        println("params ra " + params)

        def titulo_rep
        def reforma = Reforma.get(params.id)
        def firma = seguridad.Firma.findByIdAccionAndTipoFirmaInListAndEstado(reforma.id,['AJST', 'RFRM'] ,'F')
        def firma_path = firma?.path
//        def firma_path = seguridad.Firma.findByTipoFirmaAndIdAccion('AJST', 5)?.path
        def detalles = DetalleReforma.findAllByReforma(reforma)
        Image logo = Image.getInstance('/var/fida/logo.png')
        Image firma_img
        def tipoRfrm = reforma?.tipo == "R" ? "REFORMA" : "AJUSTE"
        def tipotxto = reforma?.tipo == "R" ? "de la reforma" : "del ajuste"
        println "tipo: ${reforma.tipo} tipoSolicitud: ${reforma.tipoSolicitud}"
        println "firma_path: $firma_path"
        if(firma_path) {
            titulo_rep = "${tipoRfrm} AL POA"
            firma_img = Image.getInstance('/var/fida/firmas/' + firma_path)
            firma_img.setAlignment(Image.ALIGN_CENTER | Image.TEXTWRAP)
        } else {
            titulo_rep = "SOLICITUD DE ${tipoRfrm}"
        }
        println "firma: ${firma_img}"

        logo.scaleToFit(46, 46)
        logo.setAlignment(Image.RIGHT | Image.TEXTWRAP)
//        logo.setAlignment(Image.RIGHT)

        def baos = new ByteArrayOutputStream()
        def name = "${tipoRfrm.toLowerCase()}_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        Font times12bold = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
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
        def prmsHeader = [border: Color.WHITE, colspan: 7, align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsRight = [border: Color.WHITE, colspan: 7, align : Element.ALIGN_RIGHT, valign: Element.ALIGN_RIGHT]
        def prmsHeader2 = [border: Color.WHITE, colspan: 3, align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellHead = [border: Color.WHITE, align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellHead3 = [border: Color.WHITE, align : Element.ALIGN_JUSTIFIED, valign: Element.ALIGN_TOP]
        def prmsCellHeadCentro = [border: Color.WHITE, align : Element.ALIGN_CENTER, valign: Element.ALIGN_LEFT]
        def prmsCellHead4 = [align : Element.ALIGN_LEFT, valign: Element.ALIGN_LEFT]
        def prmsCellHead2 = [border: Color.WHITE, align : Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE, bordeTop: "1", bordeBot: "1"]
        def prmsCellIzquierda = [border: Color.WHITE, align : Element.ALIGN_LEFT, valign: Element.ALIGN_LEFT]
        def prmsCellDerecha = [border: Color.WHITE, align : Element.ALIGN_RIGHT, valign: Element.ALIGN_RIGHT]
        def prmsCellDerecha2 = [border: Color.WHITE, align : Element.ALIGN_RIGHT, valign: Element.ALIGN_RIGHT, bordeTop: "1", bordeBot: "1"]
        def prmsCellCenter = [border: Color.WHITE, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellLeft = [border: Color.WHITE, valign: Element.ALIGN_MIDDLE]
        def prmsSubtotal = [border: Color.WHITE, colspan: 6, align : Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def prmsNum = [border: Color.WHITE, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def fondo = new Color(240, 248, 250);
        def frmtHd = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bg: fondo, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def frmtHdDerecha = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bg: fondo, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
        def frmtDato = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def frmtDato2 = [colspan: 9, bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def frmtDatoDerecha = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]


        Paragraph preface = new Paragraph();
        Paragraph pr_firma = new Paragraph();
        addEmptyLine(preface, 1);
        preface.setAlignment(Element.ALIGN_CENTER);
        preface.add(new Paragraph("PROYECTO FAREPS", fontProyecto));
        preface.add(new Paragraph(titulo_rep, fontTitulo));
        addEmptyLine(preface, 1);
        document.add(logo)
        document.add(preface);

        PdfPTable tablaCabecera = new PdfPTable(2)
        tablaCabecera.setWidthPercentage(100)
        tablaCabecera.setWidths(arregloEnteros([30, 70]))

        PdfPTable tablaHeader = new PdfPTable(9)
        tablaHeader.setWidthPercentage(100)
        tablaHeader.setWidths(arregloEnteros([5, 8, 15, 19, 8, 10, 12, 12,10]))

        PdfPTable tablaTitulo = new PdfPTable(2)
        tablaTitulo.setWidthPercentage(100)
        tablaTitulo.setWidths(arregloEnteros([90, 10]))

        PdfPTable tablaTotales = new PdfPTable(5)
        tablaTotales.setWidthPercentage(100)
        tablaTotales.setWidths(arregloEnteros([55,10,12,12,10]))

        PdfPTable tablaPie = new PdfPTable(2)
        tablaPie.setWidthPercentage(100)
        tablaPie.setWidths(arregloEnteros([15, 85]))

        PdfPTable tablaCabecera2 = new PdfPTable(1)
        tablaCabecera2.setWidthPercentage(100)
        tablaCabecera2.setWidths(arregloEnteros([100]))

        addCellTabla(tablaCabecera2, new Paragraph("Justificación ${tipotxto}:", times12bold), prmsCellHead3)
        addCellTabla(tablaCabecera2, new Paragraph(reforma?.concepto, times10normal), prmsCellHead3)
        addCellTabla(tablaCabecera2, new Paragraph("", times10normal), prmsCellHead3)
        addCellTabla(tablaCabecera2, new Paragraph("", times10normal), prmsCellHead3)

        addCellTabla(tablaCabecera2, new Paragraph("Matriz ${tipotxto}", times12bold), prmsCellHeadCentro)
        addCellTabla(tablaCabecera2, new Paragraph("", times10bold), prmsCellHeadCentro)
        addCellTabla(tablaCabecera2, new Paragraph("", times10bold), prmsCellHeadCentro)

        addCellTabla(tablaPie, new Paragraph("", times10normal), frmtDato2)
        addCellTabla(tablaPie, new Paragraph("Elaborado por:", times10bold), prmsCellHead3)
        addCellTabla(tablaPie, new Paragraph(reforma.persona.nombreCompleto, times10normal), prmsCellHead3)
        addCellTabla(tablaPie, new Paragraph("Fecha:", times10bold), prmsCellHead3)
        addCellTabla(tablaPie, new Paragraph(reforma?.fecha?.format("dd-MM-yyyy"), times10normal), prmsCellHead3)

        if(reforma?.nota) {
            addCellTabla(tablaPie, new Paragraph("Nota:", times10bold), prmsCellHead3)
            addCellTabla(tablaPie, new Paragraph(reforma.nota, times10normal), prmsCellHead3)
        }

        addCellTabla(tablaHeader, new Paragraph("AÑO", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("FUENTE", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("COMPONENTE", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("ACTIVIDAD", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("PARTIDA", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("VALOR INICIAL", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("DISMINUCIÓN", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("INCREMENTO", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("MONTO FINAL", times8bold), frmtHd)


        PdfPTable tablaDetalleOrigen = new PdfPTable(9)
        tablaDetalleOrigen.setWidthPercentage(100)
        tablaDetalleOrigen.setWidths(arregloEnteros([5, 8, 15, 19, 8, 10, 12, 12,10]))

        PdfPTable tablaDetalleIncremento = new PdfPTable(9)
        tablaDetalleIncremento.setWidthPercentage(100)
        tablaDetalleIncremento.setWidths(arregloEnteros([5, 8, 15, 19, 8, 10, 12, 12,10]))

        PdfPTable tablaDetallePartida = new PdfPTable(9)
        tablaDetallePartida.setWidthPercentage(100)
        tablaDetallePartida.setWidths(arregloEnteros([5, 8, 15, 19, 8, 10, 12, 12,10]))

        PdfPTable tablaDetalleActividad = new PdfPTable(9)
        tablaDetalleActividad.setWidthPercentage(100)
        tablaDetalleActividad.setWidths(arregloEnteros([5, 8, 15, 19, 8, 10, 12, 12,10]))

        PdfPTable tablaDetalleTecho = new PdfPTable(9)
        tablaDetalleTecho.setWidthPercentage(100)
        tablaDetalleTecho.setWidths(arregloEnteros([5, 8, 15, 19, 8, 10, 12, 12,10]))

        def tablaTipo
        def componenteTabla = ''
        def actividadTabla = ''
        def partidaTabla = ''
        def valorInicialTabla = 0
        def totalInicial = 0
        def disminucion = 0
        def incremento = 0
        def montoFinal = 0

        detalles.each{detalle->

            def disminucionTabla = " --- "
            def incrementoTabla = g.formatNumber(number: detalle?.valor, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
            def finalTabla = g.formatNumber(number: (detalle?.valorDestinoInicial + detalle?.valor), format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)

            switch (detalle?.tipoReforma?.codigo) {
                case "O":
                    tablaTipo = tablaDetalleOrigen
                    componenteTabla = detalle?.componente?.objeto
                    actividadTabla = detalle?.asignacionOrigen?.marcoLogico?.numero + " - " + detalle?.asignacionOrigen?.marcoLogico?.objeto
                    partidaTabla = detalle?.asignacionOrigen?.presupuesto?.numero
                    valorInicialTabla =  g.formatNumber(number: detalle?.valorOrigenInicial, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    disminucionTabla =  g.formatNumber(number: detalle?.valor, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    incrementoTabla = " --- "
                    finalTabla = g.formatNumber(number: (detalle?.valorOrigenInicial - detalle?.valor), format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    disminucion += (detalle?.valor ?: 0)
                    montoFinal += (detalle?.valorOrigenInicial - detalle?.valor)
                    break
                case "E":
                    tablaTipo = tablaDetalleIncremento
                    componenteTabla = detalle?.componente?.objeto
                    actividadTabla = detalle?.asignacionOrigen?.marcoLogico?.numero + " - " + detalle?.asignacionOrigen?.marcoLogico?.objeto
                    partidaTabla = detalle?.asignacionOrigen?.presupuesto?.numero
                    valorInicialTabla =  g.formatNumber(number: detalle?.valorDestinoInicial, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    incremento += (detalle?.valor ?: 0)
                    montoFinal += (detalle?.valorDestinoInicial + detalle?.valor)
                    break
                case "P":
                    tablaTipo = tablaDetallePartida
                    componenteTabla = detalle?.componente?.marcoLogico?.objeto
                    actividadTabla = detalle?.componente?.numero + " - " + detalle?.componente?.objeto
                    partidaTabla = detalle?.presupuesto?.numero
                    valorInicialTabla =  g.formatNumber(number: detalle?.valorDestinoInicial, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    incremento += (detalle?.valor ?: 0)
                    montoFinal += (detalle?.valorDestinoInicial + detalle?.valor)
                    break
                case "A":
                    tablaTipo = tablaDetalleActividad
                    componenteTabla = detalle?.componente?.objeto
                    actividadTabla = detalle?.descripcionNuevaActividad
                    partidaTabla = detalle?.presupuesto?.numero
                    valorInicialTabla =  " --- "
                    finalTabla = g.formatNumber(number: detalle?.valor, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    incremento += (detalle?.valor ?: 0)
                    montoFinal += (detalle?.valor ?: 0)
                    break
                case "N":
                    tablaTipo = tablaDetalleTecho
                    componenteTabla = detalle?.componente?.marcoLogico?.objeto
                    actividadTabla = detalle?.componente?.numero + " - " + detalle?.componente?.objeto
                    partidaTabla = detalle?.presupuesto?.numero
                    valorInicialTabla =  g.formatNumber(number: detalle?.valorDestinoInicial, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    incremento += (detalle?.valor ?: 0)
                    montoFinal += (detalle?.valorDestinoInicial + detalle?.valor)
                    break
            }

            addCellTabla(tablaTipo, new Paragraph(detalle?.anio?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(detalle?.fuente?.codigo, times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(componenteTabla?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(actividadTabla?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(partidaTabla?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(valorInicialTabla?.toString(), times8normal), frmtDatoDerecha)
            addCellTabla(tablaTipo, new Paragraph(disminucionTabla?.toString(), times8normal), frmtDatoDerecha)
            addCellTabla(tablaTipo, new Paragraph(incrementoTabla?.toString(), times8normal), frmtDatoDerecha)
            addCellTabla(tablaTipo, new Paragraph(finalTabla?.toString(), times8normal), frmtDatoDerecha)

            totalInicial += (detalle?.valorDestinoInicial + detalle?.valorOrigenInicial)
        }

        addCellTabla(tablaTotales, new Paragraph("TOTAL", times8bold), frmtHd)
        addCellTabla(tablaTotales, new Paragraph(g.formatNumber(number: totalInicial, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)?.toString(), times8bold), frmtHdDerecha)
        addCellTabla(tablaTotales, new Paragraph(g.formatNumber(number: disminucion, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)?.toString(), times8bold), frmtHdDerecha)
        addCellTabla(tablaTotales, new Paragraph(g.formatNumber(number: incremento, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)?.toString(), times8bold), frmtHdDerecha)
        addCellTabla(tablaTotales, new Paragraph(g.formatNumber(number: montoFinal, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)?.toString(), times8bold), frmtHdDerecha)

        document.add(tablaCabecera);
        document.add(tablaCabecera2);
        document.add(tablaHeader);
        document.add(tablaDetalleOrigen)
        document.add(tablaDetalleIncremento)
        document.add(tablaDetallePartida)
        document.add(tablaDetalleActividad)
        document.add(tablaDetalleTecho)
        document.add(tablaTotales)
        document.add(tablaPie)

        if(firma_path) {
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

    def reporteAsignaciones (){

        def proyecto = Proyecto.get(params.id)

        def titulo = new Color(40, 140, 180)
        Font times12bold = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font times10bold = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
        Font fontProyecto = new Font(Font.HELVETICA, 18, Font.NORMAL, titulo);
        Font fontProyecto2 = new Font(Font.HELVETICA, 10, Font.NORMAL, titulo);
        Font times8bold = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)
        Font times8normal = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL)
        def fondo = new Color(240, 248, 250);
        def frmtHd = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bg: fondo, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
        def prmsCellHeadCentro = [border: Color.WHITE, align : Element.ALIGN_CENTER, valign: Element.ALIGN_LEFT]
        def frmtDato = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
        def frmtDatoDerecha = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]

        def baos = new ByteArrayOutputStream()
        Document document
        document = new Document(PageSize.A4);
        def pdfw = PdfWriter.getInstance(document, baos)
        document.open()
        document.addTitle("Asignaciones " + new Date().format("dd_MM_yyyy"))
        document.addSubject("Generado por el sistema FIDA")
        document.addKeywords("reporte, fida, asignaciones")
        document.addAuthor("FIDA")
        document.addCreator("Tedein SA")

        Paragraph preface = new Paragraph();
        Paragraph pr_firma = new Paragraph();
        addEmptyLine(preface, 1);
        preface.setAlignment(Element.ALIGN_CENTER);
        preface.add(new Paragraph("PROYECTO FAREPS", fontProyecto))
        addEmptyLine(preface, 1);
        document.add(preface);

        def actual
        def asignaciones = []

        if (params.anio) {
            actual = Anio.get(params.anio)
        } else {
            actual = Anio.findByAnio(new Date().format('yyyy'))
        }

        if (!actual) {
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()
        }
        def total = 0

        MarcoLogico.withCriteria {
            eq("proyecto", proyecto)
            eq("tipoElemento", TipoElemento.get(4))
            eq("estado", 0)
            marcoLogico {
                order("numero", "asc")
            }
            order("numero", "asc")
        }.each { ml ->
            def asig = Asignacion.withCriteria {
                eq("marcoLogico", ml)
                eq("anio", actual)
                order("id", "asc")
            }
            if (asig) {
                asignaciones += asig
                asig.each { asg ->
                    total = total + asg?.planificado
                }
            }
        }

        PdfPTable tablaCabecera2 = new PdfPTable(1)
        tablaCabecera2.setWidthPercentage(100)
        tablaCabecera2.setWidths(arregloEnteros([100]))
        addCellTabla(tablaCabecera2, new Paragraph("ASIGNACIONES DEL PROYECTO", fontProyecto2), prmsCellHeadCentro)
        addCellTabla(tablaCabecera2, new Paragraph(proyecto?.nombre, times10bold), prmsCellHeadCentro)
        addCellTabla(tablaCabecera2, new Paragraph(actual.toString(), times10bold), prmsCellHeadCentro)
        addCellTabla(tablaCabecera2, new Paragraph('', times12bold), prmsCellHeadCentro)
        addCellTabla(tablaCabecera2, new Paragraph('', times12bold), prmsCellHeadCentro)

        PdfPTable tablaHeader = new PdfPTable(6)
        tablaHeader.setWidthPercentage(100)
        tablaHeader.setWidths(arregloEnteros([20, 5, 30, 19, 10, 15]))

        addCellTabla(tablaHeader, new Paragraph("COMPONENTE", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("#", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("ACTIVIDAD", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("UNIDAD EJECUTORA", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("PARTIDA", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("PLANIFICADO", times8bold), frmtHd)

        PdfPTable tablaDetalle = new PdfPTable(6)
        tablaDetalle.setWidthPercentage(100)
        tablaDetalle.setWidths(arregloEnteros([20, 5, 30, 19, 10, 15]))

        asignaciones.each{asignacion->
            def plani =  g.formatNumber(number: asignacion?.planificado, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
            addCellTabla(tablaDetalle, new Paragraph(asignacion.marcoLogico.marcoLogico.toString(), times8normal), frmtDato)
            addCellTabla(tablaDetalle, new Paragraph(asignacion.marcoLogico.numero.toString(), times8normal), frmtDato)
            addCellTabla(tablaDetalle, new Paragraph(asignacion.marcoLogico.toString(), times8normal), frmtDato)
            addCellTabla(tablaDetalle, new Paragraph(asignacion.unidad.toString(), times8normal), frmtDato)
            addCellTabla(tablaDetalle, new Paragraph(asignacion.presupuesto.numero.toString(), times8normal), frmtDato)
            addCellTabla(tablaDetalle, new Paragraph(plani.toString(), times8normal), frmtDatoDerecha)
        }

        def totalPlani =  g.formatNumber(number: total, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)

        PdfPTable tablaTotales = new PdfPTable(2)
        tablaTotales.setWidthPercentage(100)
        tablaTotales.setWidths(arregloEnteros([85,15]))
        addCellTabla(tablaTotales, new Paragraph("TOTAL", times8bold), frmtHd)
        addCellTabla(tablaTotales, new Paragraph(totalPlani.toString(), times8bold), frmtDatoDerecha)

        document.add(tablaCabecera2)
        document.add(tablaHeader)
        document.add(tablaDetalle)
        document.add(tablaTotales)
        document.close();
        pdfw.close()
        byte[] b = baos.toByteArray();
        response.setContentType("application/pdf")
        response.setHeader("Content-disposition", "attachment; filename=" + "asignaciones_" + new Date().format("dd-MM-yyyy"))
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def reporteAsignacionesExcel () {

        def proyecto = Proyecto.get(params.id)
        def meses = Mes.list([sort: "id"])

        def actual
        if (params.anio) {
            actual = Anio.get(params.anio)
        } else {
            actual = Anio.findByAnio(new Date().format("yyyy"))
        }
        if (!actual) {
            actual = Anio.list([sort: 'anio', order: 'desc']).pop()
        }

        def asgProy = []

        MarcoLogico.findAll("from MarcoLogico where proyecto = ${proyecto} and tipoElemento=4 and estado=0").sort{it.numero}.each {
            def asig = Asignacion.findAllByMarcoLogicoAndAnio(it, actual, [sort: "id"])
            if (asig) {
                asgProy += asig
            }
        }

//        println(" - " + asgProy)

        //excel
        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default

        def file = File.createTempFile('myExcelDocument', '.xls')
        file.deleteOnExit()

        WritableWorkbook workbook = jxl.Workbook.createWorkbook(file, workbookSettings)
        WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
        WritableCellFormat formatXls = new WritableCellFormat(font)

        def row = 0
        WritableSheet sheet = workbook.createSheet('MySheet', 0)
        // fija el ancho de la columna
        // sheet.setColumnView(1,40)

        WritableFont times16font = new WritableFont(WritableFont.TIMES, 11, WritableFont.BOLD, false);
        WritableCellFormat times16format = new WritableCellFormat(times16font);
        sheet.setColumnView(0, 35)
        sheet.setColumnView(1, 8)
        sheet.setColumnView(2, 35)
        sheet.setColumnView(3, 12)
        sheet.setColumnView(4, 20)
        sheet.setColumnView(5, 15)
        sheet.setColumnView(6, 15)
        sheet.setColumnView(7, 15)
        sheet.setColumnView(8, 15)
        sheet.setColumnView(9, 15)
        sheet.setColumnView(10, 15)
        sheet.setColumnView(11, 15)
        sheet.setColumnView(12, 15)
        sheet.setColumnView(13, 15)
        sheet.setColumnView(14, 15)
        sheet.setColumnView(15, 15)
        sheet.setColumnView(16, 15)
        sheet.setColumnView(17, 15)
        sheet.setColumnView(18, 15)
        // inicia textos y numeros para asocias a columnas

        def label
        def nmro
        def number

        def fila = 6;

        NumberFormat nf = new NumberFormat("#.##");
        WritableCellFormat cf2obj = new WritableCellFormat(nf);

        label = new Label(1, 1, (proyecto?.nombre ?: ''), times16format); sheet.addCell(label);
        label = new Label(1, 2, "REPORTE EXCEL DE ASIGNACIONES", times16format); sheet.addCell(label);

        label = new Label(0, 4, "COMPONENTE: ", times16format); sheet.addCell(label);
        label = new Label(1, 4, "#", times16format); sheet.addCell(label);
        label = new Label(2, 4, "ACTIVIDAD", times16format); sheet.addCell(label);
        label = new Label(3, 4, "PARTIDA", times16format); sheet.addCell(label);
        label = new Label(4, 4, "FUENTE", times16format); sheet.addCell(label);
        label = new Label(5, 4, "VALOR", times16format); sheet.addCell(label);
        label = new Label(6, 4, "ENERO", times16format); sheet.addCell(label);
        label = new Label(7, 4, "FEBRERO", times16format); sheet.addCell(label);
        label = new Label(8, 4, "MARZO", times16format); sheet.addCell(label);
        label = new Label(9, 4, "ABRIL", times16format); sheet.addCell(label);
        label = new Label(10, 4, "MAYO", times16format); sheet.addCell(label);
        label = new Label(11, 4, "JUNIO", times16format); sheet.addCell(label);
        label = new Label(12, 4, "JULIO", times16format); sheet.addCell(label);
        label = new Label(13, 4, "AGOSTO", times16format); sheet.addCell(label);
        label = new Label(14, 4, "SEPTIEMBRE", times16format); sheet.addCell(label);
        label = new Label(15, 4, "OCTUBRE", times16format); sheet.addCell(label);
        label = new Label(16, 4, "NOVIEMBRE", times16format); sheet.addCell(label);
        label = new Label(17, 4, "DICIEMBRE", times16format); sheet.addCell(label);
        label = new Label(18, 4, "TOTAL", times16format); sheet.addCell(label);

        def ene = 0
        def feb = 0
        def mar = 0
        def abr = 0
        def may = 0
        def jun = 0
        def jul = 0
        def ago = 0
        def sep = 0
        def oct = 0
        def nov = 0
        def dic = 0
        def totalFinal = 0


        asgProy.each{asg->
            def totalFilas = 0
            label = new Label(0, fila, asg?.marcoLogico?.marcoLogico?.toString()); sheet.addCell(label);
            label = new Label(1, fila, asg?.marcoLogico?.numero?.toString()); sheet.addCell(label);
            label = new Label(2, fila, asg?.marcoLogico?.toString()); sheet.addCell(label);
            label = new Label(3, fila, asg?.presupuesto?.numero?.toString()); sheet.addCell(label);
            label = new Label(4, fila, asg?.fuente?.descripcion?.toString()); sheet.addCell(label);
            number = new jxl.write.Number(5, fila, asg?.planificado); sheet.addCell(number);
            meses.eachWithIndex{mes,j->
                def v = ProgramacionAsignacion.findByAsignacionAndMes(Asignacion.get(asg?.id),Mes.get(mes.id))
                number = new jxl.write.Number((j + 6), fila, v?.valor?.toDouble() ?: 0 ); sheet.addCell(number)
                totalFilas += (v?.valor?.toDouble() ?: 0)
                totalFinal += (v?.valor?.toDouble() ?: 0)
                if(mes.numero == 1){
                    ene += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 2){
                    feb += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 3){
                    mar += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 4){
                    abr += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 5){
                    may += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 6){
                    jun += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 7){
                    jul += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 8){
                    ago += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 9){
                    sep += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 10){
                    oct += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 11){
                    nov += (v?.valor?.toDouble() ?: 0)
                }
                if(mes.numero == 12){
                    dic += (v?.valor?.toDouble() ?: 0)
                }
            }
            number = new jxl.write.Number(18, fila, totalFilas ); sheet.addCell(number);
            fila++
        }

        label = new Label(0, fila, ''); sheet.addCell(label);
        label = new Label(1, fila, ''); sheet.addCell(label);
        label = new Label(2, fila, ''); sheet.addCell(label);
        label = new Label(3, fila, ''); sheet.addCell(label);
        label = new Label(4, fila, ''); sheet.addCell(label);
        label = new Label(5, fila, 'TOTALES'); sheet.addCell(label);
        number = new jxl.write.Number(6, fila, ene ); sheet.addCell(number);
        number = new jxl.write.Number(7, fila, feb ); sheet.addCell(number);
        number = new jxl.write.Number(8, fila, mar ); sheet.addCell(number);
        number = new jxl.write.Number(9, fila, abr ); sheet.addCell(number);
        number = new jxl.write.Number(10, fila, may ); sheet.addCell(number);
        number = new jxl.write.Number(11, fila, jun ); sheet.addCell(number);
        number = new jxl.write.Number(12, fila, jul ); sheet.addCell(number);
        number = new jxl.write.Number(13, fila, ago ); sheet.addCell(number);
        number = new jxl.write.Number(14, fila, sep ); sheet.addCell(number);
        number = new jxl.write.Number(15, fila, oct ); sheet.addCell(number);
        number = new jxl.write.Number(16, fila, nov ); sheet.addCell(number);
        number = new jxl.write.Number(17, fila, dic ); sheet.addCell(number);
        number = new jxl.write.Number(18, fila, totalFinal ); sheet.addCell(number);


        workbook.write();
        workbook.close();
        def output = response.getOutputStream()
        def header = "attachment; filename=" + "reporteExcelAsignaciones_" + new Date().format("dd-MM-yyyy") + ".xls";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        output.write(file.getBytes());

    }

    def mapa() {
        def cn = dbConnectionService.getConnection()
        def sql = "select unej__id, unejnmbr, cntnlatt, cntnlong from unej, parr, cntn " +
                "where parr.parr__id = unej.parr__id and cntn.cntn__id = parr.cntn__id and tpin__id = 2"

        def coord = '', nmbr = ''
        println "sql: $sql"

        cn.eachRow(sql.toString()) {d ->
            coord += (coord? '_' : '') + "${d.cntnlatt} ${d.cntnlong}"
            nmbr += (nmbr? '_' : '') + "${d.unejnmbr}"
        }
//        println "data: ${data as JSON}"

        return [cord: coord, nmbr: nmbr]
    }

    def reportes(){

    }

    public static void autoSizeColumns(WritableSheet sheet, int columns) {
        for (int c = 0; c < columns; c++) {
            CellView cell = sheet.getColumnView(c);
            cell.setAutosize(true);
            sheet.setColumnView(c, cell);
        }
    }

    def reportesEncuestasExcel(){

        def cantidadPreguntas = Pregunta.countByIdIsNotNull()

//        println("cp " + cantidadPreguntas)

        //excel
        WorkbookSettings workbookSettings = new WorkbookSettings()
        workbookSettings.locale = Locale.default

        def file = File.createTempFile('myExcelDocument', '.xls')
        file.deleteOnExit()

        WritableWorkbook workbook = jxl.Workbook.createWorkbook(file, workbookSettings)
        WritableFont font = new WritableFont(WritableFont.ARIAL, 12)
        WritableCellFormat formatXls = new WritableCellFormat(font)

        def row = 0
        WritableSheet sheet = workbook.createSheet('MySheet', 0)
//        sheet.setRowView(4,1000)

        // fija el ancho de la columna
        // sheet.setColumnView(1,40)

        WritableFont times16font = new WritableFont(WritableFont.TIMES, 11, WritableFont.BOLD, false);
        WritableFont times16fontNormal = new WritableFont(WritableFont.TIMES, 11, WritableFont.NO_BOLD, false);
        WritableCellFormat times16format = new WritableCellFormat(times16font);
        WritableCellFormat times16formatN = new WritableCellFormat(times16fontNormal);

        sheet.setColumnView(0, 35)
        for(def i=0; i< cantidadPreguntas; i++){
            sheet.setColumnView(i+1, 40)
        }

//        autoSizeColumns(sheet, (cantidadPreguntas.toInteger() + 1))

        def label
        def fila = 5;

        label = new Label(1, 2, "REPORTE ENCUESTAS", times16format); sheet.addCell(label);
        label = new Label(0, 4, "UNIDAD EJECUTORA", times16format); sheet.addCell(label);

        def preguntas = Pregunta.list().sort{it.descripcion}

        preguntas.eachWithIndex {pregunta, i->
            label = new Label(i+1, 4, pregunta?.descripcion?.toString(), times16format); sheet.addCell(label);
        }

        def encuestas = Encuesta.findAllByEstado('C').sort{it.unidadEjecutora.nombre}

        encuestas.each{encuesta->
            def detalles = DetalleEncuesta.findAllByEncuesta(encuesta).sort{it.respuestaPregunta.pregunta.descripcion}
            detalles.eachWithIndex{detalle,j->
                label = new Label(0, fila,  detalle?.encuesta?.unidadEjecutora?.nombre?.toString(), times16formatN); sheet.addCell(label);
                if(detalle?.valor){
                    label = new Label(j+1, fila, detalle?.valor?.toString(), times16formatN); sheet.addCell(label);
                }else{
                    label = new Label(j+1, fila, detalle?.respuestaPregunta?.respuesta?.opcion?.toString(), times16formatN); sheet.addCell(label);
                }
            }
            fila++
        }

//        asgProy.each{asg->
//            def totalFilas = 0
//            label = new Label(0, fila, asg?.marcoLogico?.marcoLogico?.toString()); sheet.addCell(label);
//            label = new Label(1, fila, asg?.marcoLogico?.numero?.toString()); sheet.addCell(label);
//            label = new Label(2, fila, asg?.marcoLogico?.toString()); sheet.addCell(label);
//            label = new Label(3, fila, asg?.presupuesto?.numero?.toString()); sheet.addCell(label);
//            label = new Label(4, fila, asg?.fuente?.descripcion?.toString()); sheet.addCell(label);
//            number = new jxl.write.Number(5, fila, asg?.planificado); sheet.addCell(number);
//            meses.eachWithIndex{mes,j->
//                def v = ProgramacionAsignacion.findByAsignacionAndMes(Asignacion.get(asg?.id),Mes.get(mes.id))
//                number = new jxl.write.Number((j + 6), fila, v?.valor?.toDouble() ?: 0 ); sheet.addCell(number)
//                totalFilas += (v?.valor?.toDouble() ?: 0)
//                totalFinal += (v?.valor?.toDouble() ?: 0)
//                if(mes.numero == 1){
//                    ene += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 2){
//                    feb += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 3){
//                    mar += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 4){
//                    abr += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 5){
//                    may += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 6){
//                    jun += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 7){
//                    jul += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 8){
//                    ago += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 9){
//                    sep += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 10){
//                    oct += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 11){
//                    nov += (v?.valor?.toDouble() ?: 0)
//                }
//                if(mes.numero == 12){
//                    dic += (v?.valor?.toDouble() ?: 0)
//                }
//            }
//            number = new jxl.write.Number(18, fila, totalFilas ); sheet.addCell(number);
//            fila++
//        }

//        label = new Label(0, fila, ''); sheet.addCell(label);
//        label = new Label(1, fila, ''); sheet.addCell(label);
//        label = new Label(2, fila, ''); sheet.addCell(label);
//        label = new Label(3, fila, ''); sheet.addCell(label);
//        label = new Label(4, fila, ''); sheet.addCell(label);
//        label = new Label(5, fila, 'TOTALES'); sheet.addCell(label);
//        number = new jxl.write.Number(6, fila, ene ); sheet.addCell(number);
//        number = new jxl.write.Number(7, fila, feb ); sheet.addCell(number);
//        number = new jxl.write.Number(8, fila, mar ); sheet.addCell(number);
//        number = new jxl.write.Number(9, fila, abr ); sheet.addCell(number);
//        number = new jxl.write.Number(10, fila, may ); sheet.addCell(number);
//        number = new jxl.write.Number(11, fila, jun ); sheet.addCell(number);
//        number = new jxl.write.Number(12, fila, jul ); sheet.addCell(number);
//        number = new jxl.write.Number(13, fila, ago ); sheet.addCell(number);
//        number = new jxl.write.Number(14, fila, sep ); sheet.addCell(number);
//        number = new jxl.write.Number(15, fila, oct ); sheet.addCell(number);
//        number = new jxl.write.Number(16, fila, nov ); sheet.addCell(number);
//        number = new jxl.write.Number(17, fila, dic ); sheet.addCell(number);
//        number = new jxl.write.Number(18, fila, totalFinal ); sheet.addCell(number);


        workbook.write();
        workbook.close();
        def output = response.getOutputStream()
        def header = "attachment; filename=" + "reporteExcelEncuestas_" + new Date().format("dd-MM-yyyy") + ".xls";
        response.setContentType("application/octet-stream")
        response.setHeader("Content-Disposition", header);
        output.write(file.getBytes());
    }

//    def reporteEncuestasPdf(){
//
//        def titulo = new Color(40, 140, 180)
//        Font times12bold = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
//        Font times10bold = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
//        Font fontProyecto = new Font(Font.HELVETICA, 18, Font.NORMAL, titulo);
//        Font fontProyecto2 = new Font(Font.HELVETICA, 10, Font.NORMAL, titulo);
//        Font times8bold = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)
//        Font times8normal = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL)
//        def fondo = new Color(240, 248, 250);
//        def frmtHd = [border: Color.LIGHT_GRAY, bwb: 0.1, bcb: Color.BLACK, bg: fondo, align: Element.ALIGN_CENTER, valign: Element.ALIGN_MIDDLE]
//        def prmsCellHeadCentro = [border: Color.WHITE, align : Element.ALIGN_CENTER, valign: Element.ALIGN_LEFT]
//        def frmtDato = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]
//        def frmtDatoDerecha = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_RIGHT, valign: Element.ALIGN_MIDDLE]
//
//        def baos = new ByteArrayOutputStream()
//        Document document
//        document = new Document(PageSize.A4);
//        def pdfw = PdfWriter.getInstance(document, baos)
//        document.open()
//        document.addTitle("Encuestas " + new Date().format("dd_MM_yyyy"))
//        document.addSubject("Generado por el sistema FIDA")
//        document.addKeywords("reporte, fida, encuestas")
//        document.addAuthor("FIDA")
//        document.addCreator("Tedein SA")
//
//        Paragraph preface = new Paragraph();
//        Paragraph pr_firma = new Paragraph();
//        addEmptyLine(preface, 1);
//        preface.setAlignment(Element.ALIGN_CENTER);
//        preface.add(new Paragraph("PROYECTO FAREPS", fontProyecto))
//        addEmptyLine(preface, 1);
//        document.add(preface);
//
//        def actual
//        def asignaciones = []
//        def total = 0
//
//        def encuestas = Encuesta.findAllByEstado("C").sort{it.unidadEjecutora.id}
//
//        PdfPTable tablaCabecera2 = new PdfPTable(1)
//        tablaCabecera2.setWidthPercentage(100)
//        tablaCabecera2.setWidths(arregloEnteros([100]))
//        addCellTabla(tablaCabecera2, new Paragraph("ENCUESTAS", fontProyecto2), prmsCellHeadCentro)
//        addCellTabla(tablaCabecera2, new Paragraph('', times12bold), prmsCellHeadCentro)
//        addCellTabla(tablaCabecera2, new Paragraph('', times12bold), prmsCellHeadCentro)
//
//        PdfPTable tablaHeader = new PdfPTable(3)
//        tablaHeader.setWidthPercentage(100)
//        tablaHeader.setWidths(arregloEnteros([20, 40, 40]))
//
//        addCellTabla(tablaHeader, new Paragraph("UNIDAD EJECUTORA", times8bold), frmtHd)
//        addCellTabla(tablaHeader, new Paragraph("PREGUNTA", times8bold), frmtHd)
//        addCellTabla(tablaHeader, new Paragraph("RESPUESTA", times8bold), frmtHd)
//
//        PdfPTable tablaDetalle = new PdfPTable(3)
//        tablaDetalle.setWidthPercentage(100)
//        tablaDetalle.setWidths(arregloEnteros([20, 40, 40]))
//
//        encuestas.each{encuesta->
//            def detalles = DetalleEncuesta.findAllByEncuesta(encuesta).sort{it.respuestaPregunta.pregunta.descripcion}
//            detalles.each {detalle->
//                addCellTabla(tablaDetalle, new Paragraph(detalle?.encuesta?.unidadEjecutora?.nombre?.toString(), times8normal), frmtDato)
//                addCellTabla(tablaDetalle, new Paragraph(detalle?.respuestaPregunta?.pregunta?.descripcion?.toString(), times8normal), frmtDato)
//                addCellTabla(tablaDetalle, new Paragraph(detalle?.valor?.toString(), times8normal), frmtDato)
//            }
//        }
//
//        document.add(tablaCabecera2)
//        document.add(tablaHeader)
//        document.add(tablaDetalle)
//        document.close();
//        pdfw.close()
//        byte[] b = baos.toByteArray();
//        response.setContentType("application/pdf")
//        response.setHeader("Content-disposition", "attachment; filename=" + "encuestas_" + new Date().format("dd-MM-yyyy"))
//        response.setContentLength(b.length)
//        response.getOutputStream().write(b)
//    }


}
