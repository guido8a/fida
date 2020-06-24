package seguridad

class UnidadEjecutoraController {

    UnidadEjecutoraService unidadEjecutoraService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {
        params.max = Math.min(max ?: 10, 100)
        respond unidadEjecutoraService.list(params), model:[unidadEjecutoraCount: unidadEjecutoraService.count()]
    }

    def form_ajax(){

        def unidad

        if(params.id){
            unidad = UnidadEjecutora.get(params.id)
        }else{
            unidad =  new UnidadEjecutora()
        }

        return [unidad:unidad]
    }

    def saveUnidad_ajax(){
        println("params sue " + params)
    }

    def arbol(){

    }

    def loadTreePart_ajax() {
        render(makeTreeNode(params))
    }

    def makeTreeNode(params) {
//        println "makeTreeNode.. $params"
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

        //root
        if (id == "#") {
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
            ico = ", \"icon\":\"fa fa-underline text-success\""
            hijos.each { hijo ->
//                println "procesa ${hijo.nombre}"
                clase = UnidadEjecutora.findByPadre(hijo) ? "jstree-closed hasChildren" : "jstree-closed"
                tree += "<li id='uni_" + hijo.id + "' class='" + clase + "' ${data} data-jstree='{\"type\":\"${"unidadEjecutora"}\" ${ico}}' >"
                tree += "<a href='#' class='label_arbol'>" + hijo?.nombre + "</a>"
                tree += "</li>"
            }
        } else {
//            println ("---- no es raiz..." + tipo + " - " + id)
            switch(tipo) {
                case "uni":
                    hijos += UnidadEjecutora.findAllByPadre(UnidadEjecutora.get(id), [sort: params.sort])
                    hijos += Persona.findAllByUnidadEjecutora(UnidadEjecutora.get(id), [sort: params.sort, order: params.order])
//                    liId = "usu_"
                    hijos.each { h ->
//                        println "procesa $h"
                        if(h instanceof UnidadEjecutora){
                            ico = ", \"icon\":\"fa fa-underline text-success\""
                            clase = UnidadEjecutora.findByPadre(h) ? "jstree-closed hasChildren" : "jstree-closed"
                            tree += "<li id='uni_" + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"unidadEjecutora"}\" ${ico}}' >"
                            tree += "<a href='#' class='label_arbol'>" + h?.nombre + "</a>"
                            tree += "</li>"
                        }else{
                            ico = ", \"icon\":\"fa fa-parking text-info\""
                            clase = Persona.get(h.id)? "jstree-closed hasChildren" : ""
                            tree += "<li id='usu_" + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"persona"}\" ${ico}}'>"
                            tree += "<a href='#' class='label_arbol'>" + h.nombre + "</a>"
                            tree += "</li>"
                        }
                    }
                    break
                case "usu":
                    break
            }
        }
        return tree
    }

    def arbolSearch_ajax() {
        println "arbolSearch_ajax $params"
        def search = params.str.trim()
        if (search != "") {
            def c = Persona.createCriteria()
            def find = c.list(params) {
                or {
                    ilike("nombre", "%" + search + "%")
                    ilike("apellido", "%" + search + "%")
                    ilike("login", "%" + search + "%")
                    unidadEjecutora {
                        or {
                            ilike("nombre", "%" + search + "%")
                        }
                    }
                }
            }
//            println find
            def unidades = []
            find.each { pers ->
                if (pers.unidadEjecutora && !unidades.contains(pers.unidadEjecutora)) {
                    unidades.add(pers.unidadEjecutora)
                    def dep = pers.unidadEjecutora
                    def padre = dep.padre
                    while (padre) {
                        dep = padre
                        padre = dep.padre
                        if (!unidades.contains(dep)) {
                            unidades.add(dep)
                        }
                    }
                }
            }
            unidades = unidades.reverse()
            def ids = "["
            if (find.size() > 0) {
                ids += "\"#root\","
                unidades.each { dp ->
                    ids += "\"#lidep_" + dp.id + "\","
                }
                ids = ids[0..-2]
            }
            ids += "]"
            render ids
        } else {
            render ""
        }
    }
}
