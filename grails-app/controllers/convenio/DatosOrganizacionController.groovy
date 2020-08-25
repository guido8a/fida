package convenio

import seguridad.UnidadEjecutora

class DatosOrganizacionController {

    def datos(){
        def unidad = UnidadEjecutora.get(params.id)
        def existe = DatosOrganizacion.findByUnidadEjecutora(unidad)
        def dato
        if(existe){
            dato = existe
        }else{
            dato = new DatosOrganizacion()
        }

        return[dato:dato,unidad:unidad]
    }

    def saveDatos_ajax(){
        println("params " + params)
        def dato

        if(params.id){
            dato = DatosOrganizacion.get(params.id)
        }else{
            dato = new DatosOrganizacion()
        }

        dato.properties = params

        if(!dato.save(flush:true)){
            println("error al guardar los datos " + dato.errors)
            render "no"
        }else{
            render"ok"
        }
    }
}
