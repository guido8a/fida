package seguridad

import fida.Provincia
import grails.validation.ValidationException
import static org.springframework.http.HttpStatus.*

class UnidadEjecutoraController {

    UnidadEjecutoraService unidadEjecutoraService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond unidadEjecutoraService.list(params), model:[unidadEjecutoraCount: unidadEjecutoraService.count()]
    }

    def show(Long id) {
        respond unidadEjecutoraService.get(id)
    }

    def create() {
        respond new UnidadEjecutora(params)
    }

    def save(UnidadEjecutora unidadEjecutora) {
        if (unidadEjecutora == null) {
            notFound()
            return
        }

        try {
            unidadEjecutoraService.save(unidadEjecutora)
        } catch (ValidationException e) {
            respond unidadEjecutora.errors, view:'create'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.created.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), unidadEjecutora.id])
                redirect unidadEjecutora
            }
            '*' { respond unidadEjecutora, [status: CREATED] }
        }
    }

    def edit(Long id) {
        respond unidadEjecutoraService.get(id)
    }

    def update(UnidadEjecutora unidadEjecutora) {
        if (unidadEjecutora == null) {
            notFound()
            return
        }

        try {
            unidadEjecutoraService.save(unidadEjecutora)
        } catch (ValidationException e) {
            respond unidadEjecutora.errors, view:'edit'
            return
        }

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.updated.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), unidadEjecutora.id])
                redirect unidadEjecutora
            }
            '*'{ respond unidadEjecutora, [status: OK] }
        }
    }

    def delete(Long id) {
        if (id == null) {
            notFound()
            return
        }

        unidadEjecutoraService.delete(id)

        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.deleted.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), id])
                redirect action:"index", method:"GET"
            }
            '*'{ render status: NO_CONTENT }
        }
    }

    protected void notFound() {
        request.withFormat {
            form multipartForm {
                flash.message = message(code: 'default.not.found.message', args: [message(code: 'unidadEjecutora.label', default: 'UnidadEjecutora'), params.id])
                redirect action: "index", method: "GET"
            }
            '*'{ render status: NOT_FOUND }
        }
    }

    def arbol(){

    }


    def loadTreePart_ajax() {
        render(makeTreeNode(params))
    }



//    def makeTreeNode(params) {
//        println "makeTreeNode.. $params"
//        def id = params.id
//        if (!params.sort) {
//            params.sort = "apellido"
//        }
//        if (!params.order) {
//            params.order = "asc"
//        }
//        String tree = "", clase = "", rel = ""
//        def padre
//        def hijos = []
//
//        if (id == "#") {
//            //root
////            def hh = UnidadEjecutora.countByPadreIsNull([sort: "nombre"])
//            def hh = UnidadEjecutora.countByPadreIsNull()
//            if (hh > 0) {
//                clase = "hasChildren jstree-closed"
//            }
//
//            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' data-level='0' >" +
//                    "<a href='#' class='label_arbol'>Estructura Principal</a>" +
//                    "</li>"
//            if (clase == "") {
//                tree = ""
//            }
//        } else if (id == "root") {
//            hijos = UnidadEjecutora.findAllByPadreIsNull().sort{it.nombre}
//        } else {
//            def parts = id.split("_")
//            def node_id = parts[1].toLong()
//            padre = UnidadEjecutora.get(node_id)
//            if (padre) {
//                hijos = []
//                hijos += Persona.findAllByUnidadEjecutora(padre, [sort: params.sort, order: params.order])
//                hijos += UnidadEjecutora.findAllByPadre(padre, [sort: "nombre"])
//            }
//        }
//
//        if (tree == "" && (padre || hijos.size() > 0)) {
//            tree += "<ul>"
//            def lbl = ""
//
//            hijos.each { hijo ->
//                def tp = ""
//                def data = ""
//                def ico = ""
//                ico = ", \"icon\":\"fa fa-parking text-success\""
//                if (hijo instanceof UnidadEjecutora) {
//                    lbl = hijo.nombre
//                    if (hijo.codigo) {
//                        lbl += " (${hijo.codigo})"
//                    }
//                    tp = "dep"
//                    def hijosH = UnidadEjecutora.findAllByPadre(hijo, [sort: "nombre"])
//                    if (hijo.padre) {
//                        rel = (hijosH.size() > 0) ? "unidadPadre" : "unidadHijo"
//                    } else {
//                        rel = "principal"
//                    }
//
//                    if (hijo.padre) {
//                        rel += hijo.activo ? "Activo" : "Inactivo"
//                    }
//                    hijosH += Persona.findAllByUnidadEjecutora(hijo, [sort: "apellido"])
//                    clase = (hijosH.size() > 0) ? "jstree-closed hasChildren" : ""
//                    if (hijosH.size() > 0) {
//                        clase += " ocupado "
//                    }
//                } else if (hijo instanceof Persona) {
//                    switch (params.sort) {
//                        case 'apellido':
//                            lbl = "${hijo.apellido} ${hijo.nombre} ${hijo.login ? '(' + hijo.login + ')' : ''}"
//                            break;
//                        case 'nombre':
//                            lbl = "${hijo.nombre} ${hijo.apellido} ${hijo.login ? '(' + hijo.login + ')' : ''}"
//                            break;
//                        default:
//                            lbl = "${hijo.apellido} ${hijo.nombre} ${hijo.login ? '(' + hijo.login + ')' : ''}"
//                    }
//
////                    if (hijo.esDirector) {
////                        ico = ", \"icon\":\"fa fa-user-secret text-warning\""
////                    } else if (hijo.esGerente) {
////                        ico = ", \"icon\":\"fa fa-user-secret text-danger\""
////                    }
//
//                    tp = "usu"
//                    rel = "usuario"
//                    clase = "usuario"
//
//                    data += "data-usuario='${hijo.login}'"
//
//                    if (hijo.estaActivo) {
//                        rel += "Activo"
//                    } else {
//                        rel += "Inactivo"
//                    }
//                }
//
//                tree += "<li id='li${tp}_" + hijo.id + "' class='" + clase + "' ${data} data-jstree='{\"type\":\"${rel}\" ${ico}}' >"
//                tree += "<a href='#' class='label_arbol'>" + lbl + "</a>"
//                tree += "</li>"
//            }
//
//            tree += "</ul>"
//        }
////        println "arbol: $tree"
//        return tree
//    }

    def makeTreeNode(params) {
        println "makeTreeNode.. $params"
        def id = params.id
        def tipo = ""
        def liId = ""
        def ico = ""

        if(id.contains("_")) {
            id = params.id.split("_")[1]
            tipo = params.id.split("_")[0]
        }

        if (!params.order) {
            params.order = "asc"
        }

        String tree = "", clase = "", rel = ""
        def padre
        def hijos = []

//        println "---> id: $id, tipo: $tipo, es #: ${id == '#'}"

        if (id == "#") {
            //root
            def hh = UnidadEjecutora.countByPadreIsNull()

            if (hh > 0) {
                clase = "hasChildren jstree-closed"
            }

            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' data-level='0' >" +
                    "<a href='#' class='label_arbol'>Estructura Principal</a>" +
                    "</li>"
            if (clase == "") {
                tree = ""
            }

        } else if (id == "root") {
            hijos = UnidadEjecutora.findAllByPadreIsNull().sort{it.nombre}
            def data = ""
            ico = ", \"icon\":\"fa fa-parking text-success\""
            hijos.each { hijo ->
                println "procesa ${hijo.nombre}"
                clase = UnidadEjecutora.findByPadre(hijo) ? "jstree-closed hasChildren" : "jstree-closed"
                tree += "<li id='prov_" + hijo.id + "' class='" + clase + "' ${data} data-jstree='{\"type\":\"${"principal"}\" ${ico}}' >"
                tree += "<a href='#' class='label_arbol'>" + hijo?.nombre + "</a>"
                tree += "</li>"
            }
        } else {
//            println ("---- no es raiz..." + tipo + " - " + id)
            switch(tipo) {
                case "prov":

                    hijos += UnidadEjecutora.findAllByPadre(UnidadEjecutora.get(id), [sort: params.sort])
                    hijos += Persona.findAllByUnidadEjecutora(UnidadEjecutora.get(id), [sort: params.sort, order: params.order])

                    liId = "cntn_"
//                    println "tipo: $tipo, ${hijos.size()}"
                    ico = ", \"icon\":\"fa fa-copyright text-info\""
                    hijos.each { h ->
                        println "procesa $h"

                        if(h instanceof UnidadEjecutora){
                            clase = UnidadEjecutora.findByPadre(h) ? "jstree-closed hasChildren" : "jstree-closed"
                            tree += "<li id='prov_" + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"unidadEjecutora"}\" ${ico}}' >"
                            tree += "<a href='#' class='label_arbol'>" + h?.nombre + "</a>"
                            tree += "</li>"
                        }else{
                            clase = Persona.get(h.id)? "jstree-closed hasChildren" : ""
                            tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"persona"}\" ${ico}}'>"
                            tree += "<a href='#' class='label_arbol'>" + h.nombre + "</a>"
                            tree += "</li>"
                        }

                    }
                    break
                case "cntn":
//                    hijos = Persona.findAllByUnidadEjecutora(UnidadEjecutora.get(id), [sort: params.sort])
//                    liId = "parr_"
//                    println "tipo: $tipo, ${hijos.size()}"
//                    ico = ", \"icon\":\"fa fa-registered text-danger\""
//                    hijos.each { h ->
//                        println "procesa $h"
//                        clase = Persona.findByUnidadEjecutora(h)? "jstree-closed hasChildren" : ""
//                        tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"parroquia"}\" ${ico}}'>"
//                        tree += "<a href='#' class='label_arbol'>" + h.nombre + "</a>"
//                        tree += "</li>"
//                    }
                    break
            }

        }

//        println "---> tipo: $tipo"
//        switch (tipo) {
//
//        }
//        println "arbol: $tree"
        return tree
    }
}
