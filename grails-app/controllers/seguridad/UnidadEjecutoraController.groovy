package seguridad

class UnidadEjecutoraController {

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

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
//        println("params sue " + params)

        def unidad
        def texto

        if(params.fechaInicio){
            params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        }else{
            params.fechaInicio = null
        }

        if(!params.orden){
            params.orden = 0
        }

        if(!params.numero){
            params.numero = 0
        }

        if(params.id){
            unidad = UnidadEjecutora.get(params.id)
            texto = "Unidad actualizada correctamente"
        }else{
            unidad = new UnidadEjecutora()
            texto = "Unidad creada correctamente"
        }

        unidad.properties = params

        if(!unidad.save(flush:true)){
            println("Error en save de unidad ejecutora " + unidad.errors)
            render "no_Error al guardar la unidad"
        }else{
            render "ok_" + texto
        }
    }


    def show_ajax(){
        def unidad = UnidadEjecutora.get(params.id)

        return[unidad: unidad]
    }

    def borrarUnidad_ajax(){
        def unidad = UnidadEjecutora.get(params.id)

        unidad.fechaFin = new Date()

        if(!unidad.save(flush:true)){
            println("error al borrar la unidad ejecutora " + unidad.error)
            render "no"
        }else{
            render "ok"
        }
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
        def tam = 0

        if(id.contains("_")) {
            id = params.id.split("_")[1]
            tipo = params.id.split("_")[0]
        }

        if (!params.order) {
            params.order = "asc"
        }

        String tree = "", clase = "", rel = "", clase2=""
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
            hijos = UnidadEjecutora.findAllByPadreIsNullAndFechaFinIsNull().sort{it.nombre}
            def data = ""

            ico = ", \"icon\":\"fa fa-building text-success\""
            hijos.each { hijo ->
//                println "procesa ${hijo.nombre}"
                clase = UnidadEjecutora.findByPadre(hijo) ? "jstree-closed hasChildren" : "jstree-closed"
                clase2 = Persona.findAllByUnidadEjecutora(hijo) ? " hasChildren" : ''
//                clase += Persona.findAllByUnidadEjecutora(hijo) ? "jstree-closed hasChildren" : "jstree-closed"
                tree += "<li id='uni_" + hijo.id + "' class='" + clase + clase2 + "' ${data} data-jstree='{\"type\":\"${"unidadEjecutora"}\" ${ico}}' >"
                tree += "<a href='#' class='label_arbol'>" + hijo?.nombre + "</a>"
                tree += "</li>"
            }
        } else {
//            println ("---- no es raiz..." + tipo + " - " + id)
            switch(tipo) {
                case "uni":
                    hijos += UnidadEjecutora.findAllByPadreAndFechaFinIsNull(UnidadEjecutora.get(id), [sort: params.sort])
                    hijos += Persona.findAllByUnidadEjecutora(UnidadEjecutora.get(id), [sort: params.sort, order: params.order])
                    hijos.each { h ->
//                        println "procesa $h"
                        if(h instanceof UnidadEjecutora){
                            ico = ", \"icon\":\"fa fa-building text-success\""
                            clase = UnidadEjecutora.findByPadre(h) ? "jstree-closed hasChildren" : "jstree-closed"
                            clase2 = Persona.findAllByUnidadEjecutora(h) ? " hasChildren" : ''
//                            clase = tam > 0 ? "jstree-closed hasChildren" : "jstree-closed"
                            tree += "<li id='uni_" + h.id + "' class='" + clase + clase2 + "' data-jstree='{\"type\":\"${"unidadEjecutora"}\" ${ico}}' >"
                            tree += "<a href='#' class='label_arbol'>" + h?.nombre + "</a>"
                            tree += "</li>"
                        }else{
                            ico = ", \"icon\":\"fa fa-user-circle text-info\""
//                            clase = Persona.get(h.id)? "jstree-closed hasChildren" : ""
                            clase = "jstree-closed"
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
