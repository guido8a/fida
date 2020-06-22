package compras

import org.springframework.dao.DataIntegrityViolationException
import seguridad.Departamento
import seguridad.Persona

class CantonController {

    static allowedMethods = [save: "POST", update: "POST", delete: "POST"]

    def editar = {
        redirect(action: 'editar' + (params.tipo).capitalize(), params: params)
    }

    def loadTreePart = {
        render(makeBasicTree(params.tipo, params.id))
    }


    def saveFromTree = {

        switch (params.tipo) {

            case "canton":

                def cantonInstance
                if (params.id) {
                    cantonInstance = Canton.get(params.id)
                    if (!cantonInstance) {
                        flash.clase = "alert-error"
                        flash.message = "No se encontró Canton con id " + params.id
//                        redirect(action: 'list')
                        return
                    }//no existe el objeto
                    cantonInstance.properties = params
                }//es edit
                else {
                    cantonInstance = new Canton(params)
                } //es create
                if (!cantonInstance.save(flush: true)) {
                    flash.clase = "alert-error"
                    def str = "<h4>No se pudo guardar Canton " + (cantonInstance.id ? cantonInstance.id : "") + "</h4>"

                    str += "<ul>"
                    cantonInstance.errors.allErrors.each { err ->
                        def msg = err.defaultMessage
                        err.arguments.eachWithIndex {  arg, i ->
                            msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                        } ''
                        str += "<li>" + msg + "</li>"
                    }
                    str += "</ul>"

                    flash.message = str
//                    redirect(action: 'list')

//                    loadTreePart()

                    return
                }

                if (params.id) {
                    flash.clase = "alert-success"
                    flash.message = "Se ha actualizado correctamente Canton " + cantonInstance.nombre





                } else {
                    flash.clase = "alert-success"
                    flash.message = "Se ha creado correctamente Canton " + cantonInstance.nombre
                }
                break;
            case "parroquia":

                def parroquiaInstance
                if (params.id) {
                    parroquiaInstance = Parroquia.get(params.id)
                    if (!parroquiaInstance) {
                        flash.clase = "alert-error"
//                        flash.message = "No se encontró Canton con id " + params.id
//                        redirect(action: 'list')
                        return
                    }//no existe el objeto
                    parroquiaInstance.properties = params
                }//es edit
                else {
                    parroquiaInstance = new Parroquia(params)
                } //es create
                if (!parroquiaInstance.save(flush: true)) {
                    flash.clase = "alert-error"
                    def str = "<h4>No se pudo guardar Parroquia " + (parroquiaInstance.id ? parroquiaInstance.id : "") + "</h4>"

                    str += "<ul>"
                    parroquiaInstance.errors.allErrors.each { err ->
                        def msg = err.defaultMessage
                        err.arguments.eachWithIndex {  arg, i ->
                            msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                        }
                        str += "<li>" + msg + "</li>"
                    }
                    str += "</ul>"

                    flash.message = str
                    render str
//                    redirect(action: 'list')

//                    loadTreePart()

                    return
                }

                if (params.id) {
                    flash.clase = "alert-success"
                    flash.message = "Se ha actualizado correctamente parroquia " + parroquiaInstance.nombre



                } else {
                    flash.clase = "alert-success"
                    flash.message = "Se ha creado correctamente Parroquia " + parroquiaInstance.nombre
                }



                break;

            case "comunidad":

                def comunidadInstance
                if (params.id) {
                    comunidadInstance = Comunidad.get(params.id)
                    if (!comunidadInstance) {
                        flash.clase = "alert-error"
                        return
                    }//no existe el objeto
                    comunidadInstance.properties = params
                }//es edit
                else {
                    comunidadInstance = new Comunidad(params)
                } //es create
                if (!comunidadInstance.save(flush: true)) {
                    flash.clase = "alert-error"
                    def str = "<h4>No se pudo guardar Comunidad " + (comunidadInstance.id ? comunidadInstance.id : "") + "</h4>"

                    str += "<ul>"
                    comunidadInstance.errors.allErrors.each { err ->
                        def msg = err.defaultMessage
                        err.arguments.eachWithIndex {  arg, i ->
                            msg = msg.replaceAll("\\{" + i + "}", arg.toString())
                        }
                        str += "<li>" + msg + "</li>"
                    }
                    str += "</ul>"

                    flash.message = str
                    return
                }

                if (params.id) {
                    flash.clase = "alert-success"
                    flash.message = "Se ha actualizado correctamente la Comunidad " + comunidadInstance.nombre



                } else {
                    flash.clase = "alert-success"
                    flash.message = "Se ha creado correctamente la Comunidad " + comunidadInstance.nombre
                }



                break;


        }


        render ("OK")

    }


    def deleteFromTree = {

//        println(params)


        switch (params.tipo) {

            case "canton":
                def canton = Canton.get(params.id)
                def parroquias = Parroquia.findAllByCanton(canton)

//                println(parroquias.size())

                def band = true
                def p = [:]
                p.actionName = "deleteFromTree: Canton"
                p.controllerName = "Zona"
                if (parroquias.size() != 0  ){


                    render ("No se puede borrar el Cantón " + canton?.nombre)



                }else {

                    canton.delete(flush:  true)
                    render ("OK")

//                    parroquias.each { parroquia ->
////                    p.id = parroquia.id
//                        parroquia.delete(flush: true)
//
//                    }
//
//                    if (canton.delete(flush: true)) {
//                        render("OK")
//                    } else {
//                        render("NO")
//                    }


                }


                break;
            case "parroquia":


                def parroquia = Parroquia.get(params.id)

                def obra = Obra.findAllByParroquia(parroquia)

                def comunidad = Comunidad.findAllByParroquia(parroquia)

                params.actionName = "deleteFromTree: Parroquia"

                if (comunidad.size() != 0 && obra.size() != 0 ){

                    render("No se puede borrar la Parroquia " + parroquia.nombre)

                } else {


                    parroquia.delete(flush: true)
                    render ("OK")

//
//                    if (parroquia.delete(flush: true)) {
//                        render("OK")
//                    } else {
//                        render("NO")
//                    }

                }


                break;


            case "comunidad":

                def comunidad = Comunidad.get(params.id)

                def obra = Obra.findAllByComunidad(comunidad)

                params.actionName = "deleteFromTree: Comunidad"

                comunidad.delete(flush:  true)
                render ("OK")

//                if (comunidad.size() != 0 && obra.size() != 0 ){
//
//                    render("No se puede borrar la Parroquia " + parroquia.nombre)
//
//                } else {
//
//
//                    comunidad.delete(flush: true)
//                    render ("OK")
//
//                }


                break;

        }

    }




    def editarCanton = {
        def obj, crear
        if (params.id) {
            obj = Canton.get(params.id)
            crear = false
        } else {
            obj = new Canton()
            obj.provincia = Provincia.get(params.padre)
            crear = true
        }
        return [cantonInstance: obj, tipo: params.tipo, crear: crear]
    }
    def editarParroquia = {
        def obj, crear
        if (params.id) {
            obj = Parroquia.get(params.id)
            crear = false
        } else {
            obj = new Parroquia()
            obj.canton = Canton.get(params.padre)
            crear = true
        }
        return [parroquiaInstance: obj, tipo: params.tipo, crear: crear]
    }

    def editarComunidad = {

        def obj,crear
        if (params.id){
            obj =  Comunidad.get(params.id)
            crear = false

        }else {
            obj = new Comunidad();
            obj.parroquia = Parroquia.get(params.padre)
            crear = true


        }

        return [comunidadInstance: obj, tipo: params.tipo, crear: crear]


    }





//    String makeBasicTree(tipo, id) {
//        String tree = "", clase = ""
//        switch (tipo) {
//            case "init": //cargo "Division politica"
//                tree += "<ul type='pais'>" // <ul pais
//                clase = ""
//                tree += "<li id='pais_' class='pais jstree-closed' rel='pais'>" // <li pais
//                tree += "<a href='#' class='label_arbol'>División política</a>" // </> a href pais
//                tree += "</ul>"
//                break;
//
//
//            case "provincia": // cargo los cantones de la provincia
//                def provincia = Provincia.get(params.id)
//
//                def cantones = Canton.findAllByProvincia(provincia, [sort: 'nombre'])
//                clase = (cantones.size() > 0) ? "jstree-closed" : ""
//
//                if (cantones.size() > 0) {
//                    tree += "<ul type='canton'>" // < ul cantones
//                    cantones.each { canton ->
//                        def parroquias = Parroquia.findAllByCanton(canton, [sort: 'nombre'])
//
//                        clase = (parroquias.size() > 0) ? "jstree-closed" : ""
//                        tree += "<li id='canton_" + canton.id + "' class='canton " + clase + "' rel='canton'>" // <li canton
//                        tree += "<a href='#' id='link_canton_" + canton.id + "' class='label_arbol'>" + canton.nombre + "</a>" // </> a href canton
//                        tree += "</li>" // </> li canton
//                    }
//                    tree += "</ul>" // </> ul cantones
//                }
//                break;
//            case "canton":
//                def canton = Canton.get(params.id)
//
//                def parroquias = Parroquia.findAllByCanton(canton, [sort: 'nombre'])
//
//                clase = ""
//
//                if (parroquias.size() > 0) {
//                    tree += "<ul type='parroquia'>" // < ul parroquias
//                    parroquias.each { parroquia ->
//
//
//                        def comunidades = Comunidad.countByParroquia(parroquia)
//
//                        clase = (comunidades > 0) ? "jstree-closed" : ""
//
//                        tree += "<li id='parroquia_" + parroquia.id + "' class='parroquia " + clase + "' rel='parroquia'>" // <li parroquia
//                        tree += "<a href='#' id='link_parroquia_" + parroquia.id + "' class='label_arbol'>" + parroquia.nombre + "</a>" // </> a href parroquia
//                        tree += "</li>" // </> li parroquia
//                    }
//                    tree += "</ul>" // </> ul parroquias
//                }
//                break;
//            case "parroquia":
//                def parroquia = Parroquia.get(params.id)
//                def comunidades = Comunidad.findAllByParroquia(parroquia, [sort: 'nombre'])
//
//                clase = ""
//                if (comunidades.size() > 0) {
//
//
//                    tree += "<ul type='comunidad'>" // < ul parroquias
//                    comunidades.each { comunidad ->
//                        tree += "<li id='comunidad_" + comunidad.id + "' class='comunidad " + clase + "' rel='comunidad'>" // <li parroquia
//                        tree += "<a href='#' id='link_comunidad_" + comunidad.id + "' class='label_arbol'>" + comunidad.nombre + "</a>" // </> a href parroquia
//                        tree += "</li>" // </> li parroquia
//
//                    }
//                    tree += "</ul>"
//
//                }
//
//
//                break;
//
//        }
//
//        return tree
//    }








    def infoForTree = {
        redirect(action: 'info' + (params.tipo).capitalize(), params: params)
    }
//
    def infoProvincia = {
        def obj = Provincia.get(params.id)
        return [provinciaInstance: obj]
    }
    def infoCanton = {
        def obj = Canton.get(params.id)
        return [cantonInstance: obj]
    }
    def infoParroquia = {
        def obj = Parroquia.get(params.id)
        return [parroquiaInstance: obj]
    }

    def infoComunidad = {

        def obj = Comunidad.get(params.id)
        return [comunidadInstance: obj]

    }



    def arbol () {

    }



    def loadTreePart_ajax() {
        render(makeTreeNode(params))
    }


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
            def hh = Provincia.countByZonaIsNull()
            if (hh > 0) {
                clase = "hasChildren jstree-closed"
            }

            tree = "<li id='root' class='root ${clase}' data-jstree='{\"type\":\"root\"}' data-level='0' >" +
                    "<a href='#' class='label_arbol'>Estructura Principal</a>" +
                    "</li>"
            if (clase == "") {
                tree = ""
            }
//            println "clase: $clase, hh: $hh"
            hijos = Provincia.findAllByZonaIsNull().sort{it.nombre}
            def data = ""
            ico = ", \"icon\":\"fa fa-parking text-success\""
            hijos.each { hijo ->
                println "procesa ${hijo.nombre}"
                    clase = Canton.findByProvincia(hijo) ? "jstree-closed hasChildren" : "jstree-closed"

//                    tree += "<ul>"
                    tree += "<li id='prov_" + hijo.id + "' class='" + clase + "' ${data} data-jstree='{\"type\":\"${"principal"}\" ${ico}}' >"
                    tree += "<a href='#' class='label_arbol'>" + hijo?.nombre + "</a>"
                    tree += "</li>"
            }

        } else {
//            println "---- no es raiz... procesa: $tipo"
            switch(tipo) {
                case "prov":
                    hijos = Canton.findAllByProvincia(Provincia.get(id), [sort: params.sort])
                    liId = "cntn_"
//                    println "tipo: $tipo, ${hijos.size()}"
                    ico = ", \"icon\":\"fa fa-copyright text-info\""
                    hijos.each { h ->
//                        println "procesa $h"
                        clase = Parroquia.findByCanton(h)? "jstree-closed hasChildren" : ""
                        tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"canton"}\" ${ico}}'>"
                        tree += "<a href='#' class='label_arbol'>" + h.nombre + "</a>"
                        tree += "</li>"
                    }
                    break
                case "cntn":
                    hijos = Parroquia.findAllByCanton(Canton.get(id), [sort: params.sort])
                    liId = "parr_"
//                    println "tipo: $tipo, ${hijos.size()}"
                    ico = ", \"icon\":\"fa fa-registered text-danger\""
                    hijos.each { h ->
//                        println "procesa $h"
                        clase = Comunidad.findByParroquia(h)? "jstree-closed hasChildren" : ""
                        tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"parroquia"}\" ${ico}}'>"
                        tree += "<a href='#' class='label_arbol'>" + h.nombre + "</a>"
                        tree += "</li>"
                    }
                    break
                case "parr":
                    hijos = Comunidad.findAllByParroquia(Parroquia.get(id), [sort: params.sort])
                    liId = "cmnd_"
//                    println "tipo: $tipo, ${hijos.size()}"
                    ico = ", \"icon\":\"fa fa-info-circle text-warning\""
                    hijos.each { h ->
//                        println "procesa $h"
                        clase = ""
                        tree += "<li id='" + liId + h.id + "' class='" + clase + "' data-jstree='{\"type\":\"${"comunidad"}\" ${ico}}'>"
                        tree += "<a href='#' class='label_arbol'>" + h.nombre + "</a>"
                        tree += "</li>"
                    }
                    break
            }

        }

//        println "---> tipo: $tipo"
        switch (tipo) {

        }
//        println "arbol: $tree"
        return tree
    }

    def index() {
        redirect(action: "list", params: params)
    } //index

    def list() {
        params.max = Math.min(params.max ? params.int('max') : 10, 100)
        [cantonInstanceList: Canton.list(params), cantonInstanceTotal: Canton.count(), params: params]
    } //list

    def form_ajax() {


        def cantonInstance = new Canton(params)
        if (params.id) {
            cantonInstance = Canton.get(params.id)
            if (!cantonInstance) {
                flash.clase = "alert-error"
                flash.message = "No se encontró Canton con id " + params.id
                redirect(action: "list")
                return
            } //no existe el objeto
        } //es edit
        return [cantonInstance: cantonInstance, padre: params.padre ?: cantonInstance?.provincia?.id]
    } //form_ajax

    def save() {

        println("params c " + params)


        def cantonInstance

        if(params.id) {
            cantonInstance = Canton.get(params.id)
            if(!cantonInstance) {
                render "no_No se encontró el cantón"
                return
            }//no existe el objeto

            if(cantonInstance?.numero.toInteger() == params.numero.toInteger()){
                cantonInstance.properties = params
            }else{
                if(Canton.findAllByNumero(params.numero)){
                    render "no_Ya existe un cantón registrado con este número!"
                    return
                }else{
                    cantonInstance.properties = params
                }
            }
        }//es edit
        else {
            if(Canton.findAllByNumero(params.numero)){
                render "no_Ya existe un cantón registrado con este número!"
                return
            }else{
                cantonInstance = new Canton(params)
            }
        } //es create
        if (!cantonInstance.save(flush: true)) {
            render "no_Error al guardar el cantón"
            return
        }else{
            if(params.id) {
                render  "ok_Se ha actualizado correctamente el Cantón "
            } else {
                render "ok_Se ha creado correctamente el Cantón "
            }
        }
    } //save

    def show_ajax() {
        def cantonInstance = Canton.get(params.id)
        if (!cantonInstance) {
            flash.clase = "alert-error"
            flash.message = "No se encontró Canton con id " + params.id
            redirect(action: "list")
            return
        }
        [cantonInstance: cantonInstance]
    } //show

    def borrarCanton_ajax () {
        def canton = Canton.get(params.id)

        try{
            canton.delete(flush: true)
            render "ok"
        }catch(e){
            println("error al borrar la canton " + e)
            render "no"
        }
    }

} //fin controller
