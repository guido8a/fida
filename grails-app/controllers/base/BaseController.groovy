package base



import grails.config.Config
import groovy.io.FileType
import groovy.json.JsonBuilder
import seguridad.Persona

import javax.imageio.ImageIO
import java.awt.image.BufferedImage

class BaseController {

    static allowedMethods = [save: "POST", delete: "POST", save_ajax: "POST", delete_ajax: "POST"]

    def index() {
        redirect(action: "list", params: params)
    } //index

    def getLista(params, all) {
        params = params.clone()
        if (all) {
            params.remove("offset")
            params.remove("max")
        }
        def lista
        if (params.search) {
            def c = Base.createCriteria()
            lista = c.list(params) {
                or {
                    /* TODO: cambiar aqui segun sea necesario */
                    ilike("codigo", "%" + params.search + "%")
                    ilike("descripcion", "%" + params.search + "%")
                }
            }
        } else {
            lista = Base.list(params)
        }
        return lista
    }

    def list() {
        params.max = Math.min(params.max ? params.max.toInteger() : 10, 100)
        def baseInstanceList = getLista(params, false)
        def baseInstanceCount = getLista(params, true).size()
        if (baseInstanceList.size() == 0 && params.offset && params.max) {
            params.offset = params.offset - params.max
        }
        baseInstanceList = getLista(params, false)
        return [baseInstanceList: baseInstanceList, baseInstanceCount: baseInstanceCount, params: params]
    } //list

//    def show_ajax() {
//        if (params.id) {
//            def baseInstance = Base.get(params.id)
//            if (!baseInstance) {
//                notFound_ajax()
//                return
//            }
//            return [baseInstance: baseInstance]
//        } else {
//            notFound_ajax()
//        }
//    } //show para cargar con ajax en un dialog

    def form_ajax() {
        def baseInstance = new Base(params)
        if (params.id) {
            baseInstance = Base.get(params.id)
            if (!baseInstance) {
                notFound_ajax()
                return
            }
        }
        return [baseInstance: baseInstance]
    } //form para cargar con ajax en un dialog

    def save_ajax() {
        def baseInstance = new Base()
        if (params.id) {
            baseInstance = Base.get(params.id)
            if (!baseInstance) {
                notFound_ajax()
                return
            }
        } //update
        baseInstance.properties = params
        if (!baseInstance.save(flush: true)) {
            def msg = "NO_No se pudo ${params.id ? 'actualizar' : 'crear'} Base."
            msg += renderErrors(bean: baseInstance)
            render msg
            return
        }
        render "OK_${params.id ? 'Actualización' : 'Creación'} de Base exitosa."
    } //save para grabar desde ajax

    def delete_ajax() {
        if (params.id) {
            def baseInstance = Base.get(params.id)
            if (baseInstance) {
                try {
                    baseInstance.delete(flush: true)
                    render "OK_Eliminación de Base exitosa."
                } catch (e) {
                    render "NO_No se pudo eliminar Base."
                }
            } else {
                notFound_ajax()
            }
        } else {
            notFound_ajax()
        }
    } //delete para eliminar via ajax

    protected void notFound_ajax() {
        render "NO_No se encontró Base."
    } //notFound para ajax

    def base() {
        def base = Base.get(params.id)

        def list = []
        def dir = new File("/var/bitacora/${base?.id}")
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

        return [base: base, lista: list, contadorImas: contadorImas, contadorOtros: contadorOtros]
    }

    def guardarProblema_ajax() {
//        println("guardarProblema params: " + params)

        def tema = Tema.get(params.tema)
        def usuario = Persona.get(session.usuario.id)
        def baseInstance
        def edita = params.id ? params.id : 0

        if (params.id) {
            baseInstance = Base.get(params.id)
        } else {
            baseInstance = new Base()
            baseInstance.fecha = new Date()
            baseInstance.persona = usuario

        }
        baseInstance.properties = params
        baseInstance.tema = tema

//        println "edita: $edita"
        try {
            println "...1"
            baseInstance.save(flush: true)
//            println "guardado ----- "
            baseInstance.refresh()
            println "....id: ${baseInstance.id}"
            render "ok_${baseInstance.id}"


/*
            if(!edita) {
                params.id = baseInstance.id
                redirect (action: "base", params: params)
            }
*/

        } catch (e) {
            println("error al guardar el problema " + baseInstance.errors)
            render "no"
        }

    }


    def validarProblema_ajax() {
        def problema = params.problema

        if (problema.size() < 15) {
            render false
            return
        } else {
            render true
            return
        }
    }

    def validarClave_ajax() {
        def clave = params.clave

        if (clave.size() < 3) {
            render false
            return
        } else {
            render true
            return
        }
    }

//    def ver_ajax() {
//        println "ver ajax: params: $params"
//        render view: 'show_ajax', model: [baseInstance: Base.get(params.id, lista: )]
//    }

    def show_ajax() {
        def base = Base.get(params.id)
        def list = []
        def dir = new File("/var/bitacora/${base?.id}")
        if (dir.size() > 0) {
            dir.eachFileRecurse(FileType.FILES) { file ->
                list << file
            }
        }
        return [baseInstance: base, lista: list]
    }


//    def renderImage = {
    def renderImage() {

//        println("params render" + params)

        String profileImagePath = "/var/bitacora/${params.id.trim()}/"

//        println("path " + profileImagePath)

        def parts = params.nombre.toString().split("\\.")

        //String profileImagePath = grailsApplication.grails.profile.images.path

//        String image  = 'gatos.jpeg' // or whatever name you saved in your db
        String image = params.nombre
        File imageFile = new File(profileImagePath + image);
        BufferedImage originalImage = ImageIO.read(imageFile);
        ByteArrayOutputStream baos = new ByteArrayOutputStream();
        ImageIO.write(originalImage, "${parts[1]}", baos);

        byte[] imageInByte = baos.toByteArray();

        response.setHeader('Content-length', imageInByte.length.toString())
        response.contentType = 'image/' + parts[1] // or the appropriate image content type
        response.outputStream << imageInByte
        response.outputStream.flush()
    }


    def carrusel_ajax() {

//        println("params carrusel " + params)

        def base = Base.get(params.id)
//        def listaImagenes = Imagen.findAllByBase(base)
//        def directorio = '/home/fabricio/imas/' + base?.id + "/"
//        def directorio = '/static/imagenes/' + base?.id + "/"

        Config config = grailsApplication.config
//        def p = config.getProperty("grails.nuevoPath.nuevo")
        def p = config.getProperty("grails.nuevoPath.nuevo3")
//        def p = "/var/bitacora/"
        def directorio = p + base?.id + "/"
//        def directorio = p + base?.id

//        println("directorio " + directorio)

        return [directorio: directorio, base: base]

    }


//    def subirImagen() {
//
////        println("params subir imagen " + params)
//
//        def base = Base.get(params.id)
//        def anio = new Date().format("yyyy")
////        def path = servletContext.getRealPath("/") + "/imagenes/"
////        def path = servletContext.getRealPath("/")
////        def cdnFolder = grailsApplication.config.getProperty("grails.guides.cdnFolder")
//        def cdnFolder = "/var/bitacora"
//        def path = cdnFolder + "/${params.id}/"
//
////        println "folder : $path"
////        File folder = new File(folderPath)
//        File folder = new File(path)
//
//        if (!folder.exists()) {
//            folder.mkdirs()
//        }
//
//
//        def f = request.getFile('file')  //archivo = name del input type file
//
//
////        def imageContent = ['image/png': "png", 'image/jpeg': "jpeg", 'image/jpg': "jpg"]
//        def okContents = [
//                'image/png' : "png",
//                'image/jpeg': "jpeg",
//                'image/jpg' : "jpg"
//        ]
//
//        if (f && !f.empty) {
//            def fileName = f.getOriginalFilename() //nombre original del archivo
//            def ext
//
//            def parts = fileName.split("\\.")
//            fileName = ""
//            parts.eachWithIndex { obj, i ->
//                if (i < parts.size() - 1) {
//                    fileName += obj
//                }
//            }
//
////            if (okContents.containsKey(f.getContentType())) {
//            ext = okContents[f.getContentType()]
//            fileName = fileName.size() < 40 ? fileName : fileName[0..39]
//            fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")
//
//            def nombre = fileName + "." + ext
//            def pathFile = path + nombre
//            println("---->" + pathFile)
//            def fn = fileName
//            def src = new File(pathFile)
//            def i = 1
//            while (src.exists()) {
//                nombre = fn + "_" + i + "." + ext
//                pathFile = path + nombre
//                src = new File(pathFile)
//                i++
//            }
//            try {
//                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path
//            } catch (e) {
//                println "----Error\n" + e + "\n-----"
//            }
//
//            def imagen = new Imagen([
//                    base       : base,
//                    descripcion: params.descripcion.toString(),
//                    ruta       : nombre
//            ])
//            def data
//            if (imagen.save(flush: true)) {
//                data = [
//                        files: [
//                                [
//                                        name: nombre,
//                                        size: f.getSize(),
//                                        url : pathFile
//                                ]
//                        ]
//                ]
//            } else {
//                println "error al guardar: " + imagen.errors
//                data = [
//                        files: [
//                                [
//                                        name : nombre,
//                                        size : f.getSize(),
//                                        error: "Ha ocurrido un error al guardar: " + renderErrors(bean: imagen)
//                                ]
//                        ]
//                ]
//            }
//            def json = new JsonBuilder(data)
//            render json
//
//        } //f && !f.empty
//    }
//

    def subirArchivo() {

//        println("--->" + params)

        def base = Base.get(params.idBase)
        def path = "/var/bitacora/${base?.id}"   //web-app/archivos
        new File(path).mkdirs()

        def f = request.getFile('archivo')  //archivo = name del input type file

        if (!f && path) {
            println("no existe documento")
        } else {

            //        println("---> " + f?.getOriginalFilename())
            if (f && !f.empty && f.getOriginalFilename() != '') {
                def fileName = f.getOriginalFilename() //nombre original del archivo

                def accepted = ["jpg", 'png', "pdf"]
                def ext = ''
                def parts = fileName.split("\\.")
                fileName = ""
                parts.eachWithIndex { obj, i ->
                    if (i < parts.size() - 1) {
                        fileName += obj
                    } else {
                        ext = obj
                    }
                }

                if (!accepted.contains(ext)) {
                    flash.message = "El archivo tiene que ser de tipo jpg, png o pdf"
                    flash.clase = "alert-error"
                    redirect(action: 'list', id: params.concurso.id)
                    return
                }

                fileName = fileName.tr(/áéíóúñÑÜüÁÉÍÓÚàèìòùÀÈÌÒÙÇç .!¡¿?&#°"'/, "aeiounNUuAEIOUaeiouAEIOUCc_")
                def archivo = fileName
                fileName = fileName + "." + ext

                def i = 0
                def pathFile = path + File.separatorChar + fileName
                def src = new File(pathFile)

                while (src.exists()) { // verifica si existe un archivo con el mismo nombre
                    fileName = archivo + "_" + i + "." + ext
                    pathFile = path + File.separatorChar + fileName
                    src = new File(pathFile)
                    i++
                }

                f.transferTo(new File(pathFile)) // guarda el archivo subido al nuevo path

                flash.clase = "alert-success"
                flash.message = "Guardado correctamente"
                redirect(action: 'base', id: base?.id)

            } else {
                flash.clase = "alert-error"
                flash.message = "Error al guardar el documento. No se ha cargado ningún archivo!"
                redirect(action: 'base', id: base?.id)
            }
        }


    }

    def retornarArchivo() {

//        println("params retornar" + params)

        String profileImagePath = "/var/bitacora/${params.id.trim()}/"
        String filename = params.nombre
        File fileToReturn = new File(profileImagePath + filename)
        byte[] byteOutput = fileToReturn.readBytes()
        response.setHeader("Content-disposition", "attachment; filename=\"${filename}\"");
        response.outputStream << byteOutput
    }

    def tablaArchivos() {

        println("params ta " + params)

        def base = params.id
        def list = []
        def dir = new File("/var/bitacora/${base}")
        if (dir.size() > 0) {

            dir.eachFileRecurse(FileType.FILES) { file ->
                list << file.canonicalFile
            }
        }
        return [lista: list, base: base, bandera: params.band]
    }

    def borrarArchivo() {
//        println("params borrar " + params)
        String profileImagePath = "/var/bitacora/${params.id.trim()}/"
        String filename = params.nombre
        def parts = filename.split("\\.")

        if (parts.last() in ['jpeg', 'png', 'jpg']) {
            def imagen = Imagen.findByBaseAndRuta(Base.get(params.id.trim()), params.nombre)
            try {
                imagen.delete(flush: true)
            } catch (e) {
                render "no"
            }
        }

        File fileToReturn = new File(profileImagePath + filename)
        if (fileToReturn.delete()) {
            render "ok"
        } else {
            render "no"
        }

    }


}
