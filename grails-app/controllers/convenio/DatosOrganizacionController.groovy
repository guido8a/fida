package convenio

class DatosOrganizacionController {

    def datos(){
        def convenio = Convenio.get(params.id)
        def existe = DatosOrganizacion.findByUnidadEjecutora(convenio.unidadEjecutora)
        def dato
        if(existe){
            dato = existe
        }else{
            dato = new DatosOrganizacion()
        }

        return[dato:dato,unidad:convenio.unidadEjecutora,convenio:convenio]
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
