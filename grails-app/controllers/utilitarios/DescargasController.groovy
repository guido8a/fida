package utilitarios

class DescargasController {

    def manualAdmn() {
        def nombre = 'manual_administracion.pdf'
        def path = '/var/fida/manual administracion.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def manualAvales() {
        def nombre = 'manual_avales.pdf'
        def path = '/var/fida/manual avales.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def manualAjustes() {
        def nombre = 'manual_reformas.pdf'
        def path = '/var/fida/manual reformas.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def manualProy() {
        def nombre = 'manual_proyecto.pdf'
        def path = '/var/fida/manual proyecto.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def manualReportes() {
        def nombre = "manual_reportes.pdf"
        def path = '/var/fida/manual reportes.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }

    def manualEvaluaciones() {
        def nombre = "manual evaluaciones.pdf"
        def path = '/var/fida/manual evaluaciones.pdf'
        def file = new File(path)
        def b = file.getBytes()
        response.setContentType('pdf')
        response.setHeader("Content-disposition", "attachment; filename=" + nombre)
        response.setContentLength(b.length)
        response.getOutputStream().write(b)
    }


} //fin controller
