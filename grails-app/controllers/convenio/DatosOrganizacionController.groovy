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

        return[dato:dato,unidad:convenio.unidadEjecutora]
    }

    def saveDatos_ajax(){

    }
}
