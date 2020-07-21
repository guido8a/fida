package reportes

import com.lowagie.text.Document
import com.lowagie.text.Element
import com.lowagie.text.Font
import com.lowagie.text.PageSize
import com.lowagie.text.Paragraph
import com.lowagie.text.pdf.PdfPCell
import com.lowagie.text.pdf.PdfPTable
import com.lowagie.text.pdf.PdfWriter
import modificaciones.DetalleReforma
import modificaciones.Reforma

import java.awt.Color

class ReportesController {

    def reporteAjustes() {

        println("params ra " + params)

        def reforma = Reforma.get(params.id)
        def detalles = DetalleReforma.findAllByReforma(reforma)

        def baos = new ByteArrayOutputStream()
        def name = "ajustes_" + new Date().format("ddMMyyyy_hhmm") + ".pdf";
        Font times12bold = new Font(Font.TIMES_ROMAN, 12, Font.BOLD);
        Font times10bold = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
        Font times14bold = new Font(Font.TIMES_ROMAN, 14, Font.BOLD);
        Font times18bold = new Font(Font.TIMES_ROMAN, 18, Font.BOLD);
        Font times8bold = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)
        Font times8normal = new Font(Font.TIMES_ROMAN, 8, Font.NORMAL)
        Font times10boldWhite = new Font(Font.TIMES_ROMAN, 10, Font.BOLD);
        Font times8boldWhite = new Font(Font.TIMES_ROMAN, 8, Font.BOLD)
        def titulo = new Color(40, 140, 180)
        Font fontTitulo = new Font(Font.TIMES_ROMAN, 12, Font.BOLD, titulo);

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
        def prmsCellHead3 = [border: Color.WHITE, align : Element.ALIGN_LEFT, valign: Element.ALIGN_LEFT]
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
        def frmtDato = [bwt: 0.1, bct: Color.BLACK, bwb: 0.1, bcb: Color.BLACK, border: Color.LIGHT_GRAY, align: Element.ALIGN_LEFT, valign: Element.ALIGN_MIDDLE]

//        Paragraph headersTitulo = new Paragraph();
//        addEmptyLine(headersTitulo, 1);
//        headersTitulo.setAlignment(Element.ALIGN_CENTER);
//        headersTitulo.add(new Paragraph('', times18bold));
//        headersTitulo.add(new Paragraph("AJUSTES", times14bold));
//        headersTitulo.add(new Paragraph('', times12bold));
//        headersTitulo.add(new Paragraph("", times12bold));
//        document.add(headersTitulo)

//        PdfPTable header = new PdfPTable(3)
//        header.setWidthPercentage(100)
//        header.setWidths(arregloEnteros([25, 8, 65]))

//        addCellTabla(header, new Paragraph("", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph("", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph("", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph("OBRA", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(" : ", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(obra?.nombre, times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph("CÓDIGO", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(" : ", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(obra?.codigo, times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph("DOCUMENTO DE REFERENCIA", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(" : ", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(obra?.oficioIngreso, times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph("FECHA", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(" : ", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(printFecha(obra?.fechaCreacionObra), times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph("FECHA ACT. PRECIOS", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(" : ", times8bold), prmsCellHead3)
//        addCellTabla(header, new Paragraph(printFecha(obra?.fechaPreciosRubros), times8bold), prmsCellHead3)


        Paragraph preface = new Paragraph();
        addEmptyLine(preface, 1);
        preface.setAlignment(Element.ALIGN_CENTER);
        preface.add(new Paragraph("AJUSTES", fontTitulo));
        preface.add(new Paragraph("SOLICITUD DE REFORMA", fontTitulo));
        addEmptyLine(preface, 1);
        document.add(preface);

//        document.add(header);

        PdfPTable tablaHeader = new PdfPTable(9)
        tablaHeader.setWidthPercentage(100)
        tablaHeader.setWidths(arregloEnteros([10, 10, 15, 15, 10, 10, 10, 10,10]))

        PdfPTable tablaTitulo = new PdfPTable(2)
        tablaTitulo.setWidthPercentage(100)
        tablaTitulo.setWidths(arregloEnteros([90, 10]))

        PdfPTable tablaComposicion = new PdfPTable(8)
        tablaComposicion.setWidthPercentage(100)
        tablaComposicion.setWidths(arregloEnteros([12, 36, 5, 9, 9, 9, 10, 10]))

        PdfPTable tablaTotales = new PdfPTable(2)
        tablaTotales.setWidthPercentage(100)
        tablaTotales.setWidths(arregloEnteros([70, 30]))

        addCellTabla(tablaHeader, new Paragraph("AÑO", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("FUENTE", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("COMPONENTE", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("ACTIVIDAD", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("PARTIDA", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("VALOR INICIAL", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("DISMINUCIÓN", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("INCREMENTO", times8bold), frmtHd)
        addCellTabla(tablaHeader, new Paragraph("MONTO FINAL", times8bold), frmtHd)

//        PdfPTable tablaTitulo2 = new PdfPTable(2)
//        tablaTitulo2.setWidthPercentage(100)
//        tablaTitulo2.setWidths(arregloEnteros([90, 10]))
//
//        PdfPTable tablaComposicion2 = new PdfPTable(8)
//        tablaComposicion2.setWidthPercentage(100)
//        tablaComposicion2.setWidths(arregloEnteros([12, 36, 5, 9, 9, 9, 10, 10]))
//
//        PdfPTable tablaTotalesMano = new PdfPTable(2)
//        tablaTotalesMano.setWidthPercentage(100)
//        tablaTotalesMano.setWidths(arregloEnteros([70, 30]))
//
//        PdfPTable tablaTitulo3 = new PdfPTable(2)
//        tablaTitulo3.setWidthPercentage(100)
//        tablaTitulo3.setWidths(arregloEnteros([90, 10]))

        PdfPTable tablaDetalleOrigen = new PdfPTable(9)
        tablaDetalleOrigen.setWidthPercentage(100)
        tablaDetalleOrigen.setWidths(arregloEnteros([10, 10, 15, 15, 10, 10, 10, 10,10]))

        PdfPTable tablaDetalleIncremento = new PdfPTable(9)
        tablaDetalleIncremento.setWidthPercentage(100)
        tablaDetalleIncremento.setWidths(arregloEnteros([10, 10, 15, 15, 10, 10, 10, 10,10]))

        PdfPTable tablaDetallePartida = new PdfPTable(9)
        tablaDetallePartida.setWidthPercentage(100)
        tablaDetallePartida.setWidths(arregloEnteros([10, 10, 15, 15, 10, 10, 10, 10,10]))

        PdfPTable tablaDetalleActividad = new PdfPTable(9)
        tablaDetalleActividad.setWidthPercentage(100)
        tablaDetalleActividad.setWidths(arregloEnteros([10, 10, 15, 15, 10, 10, 10, 10,10]))

        PdfPTable tablaDetalleTecho = new PdfPTable(9)
        tablaDetalleTecho.setWidthPercentage(100)
        tablaDetalleTecho.setWidths(arregloEnteros([10, 10, 15, 15, 10, 10, 10, 10,10]))

        def tablaTipo
        def componenteTabla = ''
        def actividadTabla = ''
        def partidaTabla = ''
        def valorInicialTabla = 0


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
                    break
                case "E":
                    tablaTipo = tablaDetalleIncremento
                    componenteTabla = detalle?.componente?.objeto
                    actividadTabla = detalle?.asignacionOrigen?.marcoLogico?.numero + " - " + detalle?.asignacionOrigen?.marcoLogico?.objeto
                    partidaTabla = detalle?.asignacionOrigen?.presupuesto?.numero
                    valorInicialTabla =  g.formatNumber(number: detalle?.valorDestinoInicial, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    break
                case "P":
                    tablaTipo = tablaDetallePartida
                    componenteTabla = detalle?.componente?.marcoLogico?.objeto
                    actividadTabla = detalle?.componente?.numero + " - " + detalle?.componente?.objeto
                    partidaTabla = detalle?.presupuesto?.numero
                    valorInicialTabla =  g.formatNumber(number: detalle?.valorDestinoInicial, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    break
                case "A":
                    tablaTipo = tablaDetalleActividad
                    componenteTabla = detalle?.componente?.objeto
                    actividadTabla = detalle?.descripcionNuevaActividad
                    partidaTabla = detalle?.presupuesto?.numero
                    valorInicialTabla =  " --- "
                    finalTabla = g.formatNumber(number: detalle?.valor, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    break
                case "N":
                    tablaTipo = tablaDetalleTecho
                    componenteTabla = detalle?.componente?.marcoLogico?.objeto
                    actividadTabla = detalle?.componente?.numero + " - " + detalle?.componente?.objeto
                    partidaTabla = detalle?.presupuesto?.numero
                    valorInicialTabla =  g.formatNumber(number: detalle?.valorDestinoInicial, format: "##,##0", maxFractionDigits: 2, minFractionDigits: 2)
                    break
            }

            addCellTabla(tablaTipo, new Paragraph(detalle?.anio?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(detalle?.fuente?.codigo, times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(componenteTabla?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(actividadTabla?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(partidaTabla?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(valorInicialTabla?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(disminucionTabla?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(incrementoTabla?.toString(), times8normal), frmtDato)
            addCellTabla(tablaTipo, new Paragraph(finalTabla?.toString(), times8normal), frmtDato)
        }

//        res.each { k ->
//
//            if (k?.grid == 3) {
//                addCellTabla(tablaComposicion3, new Paragraph(k?.codigo, times8normal), prmsCellIzquierda)
//                addCellTabla(tablaComposicion3, new Paragraph(k?.item, times8normal), prmsCellIzquierda)
//                addCellTabla(tablaComposicion3, new Paragraph(k?.unidad, times8normal), prmsCellHead)
//                addCellTabla(tablaComposicion3, new Paragraph(g.formatNumber(number: k?.cantidad, minFractionDigits:
//                        3, maxFractionDigits: 3, format: "##,##0", locale: "ec"), times8normal), prmsNum)
//                addCellTabla(tablaComposicion3, new Paragraph(g.formatNumber(number: k?.punitario, minFractionDigits:
//                        3, maxFractionDigits: 3, format: "##,##0", locale: "ec"), times8normal), prmsNum)
//                addCellTabla(tablaComposicion3, new Paragraph(g.formatNumber(number: k?.transporte, minFractionDigits:
//                        3, maxFractionDigits: 3, format: "##,##0", locale: "ec"), times8normal), prmsNum)
//                addCellTabla(tablaComposicion3, new Paragraph(g.formatNumber(number: k?.costo, minFractionDigits:
//                        3, maxFractionDigits: 3, format: "##,##0", locale: "ec"), times8normal), prmsNum)
//                addCellTabla(tablaComposicion3, new Paragraph(g.formatNumber(number: k?.total, minFractionDigits:
//                        3, maxFractionDigits: 3, format: "##,##0", locale: "ec"), times8normal), prmsNum)
//
//                totalesEquipos = k?.total
//                valorTotalEquipos = (total3 += totalesEquipos)
//            }
//        }

//        addCellTabla(tablaTotalesEquipos, new Paragraph("Total Equipos:", times10bold), prmsCellDerecha)
//        addCellTabla(tablaTotalesEquipos, new Paragraph(g.formatNumber(number: valorTotalEquipos, minFractionDigits:
//                3, maxFractionDigits: 3, format: "##,##0", locale: "ec"), times10bold), prmsNum)

//        document.add(tablaTitulo3)
        document.add(tablaHeader);
        document.add(tablaDetalleOrigen)
        document.add(tablaDetalleIncremento)
        document.add(tablaDetallePartida)
        document.add(tablaDetalleActividad)
        document.add(tablaDetalleTecho)

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

}
