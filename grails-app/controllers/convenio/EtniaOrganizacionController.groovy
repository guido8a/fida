package convenio

import taller.Raza


class EtniaOrganizacionController {

    def formEtnias_ajax(){
        def convenio = Convenio.get(params.convenio)
        return[convenio: convenio]
    }

    def tablaEtnias_ajax(){
        def convenio = Convenio.get(params.id)
        def etnias = EtniaOrganizacion.findAllByUnidadEjecutora(convenio.unidadEjecutora)

        return[etnias: etnias]
    }

    def revisar_ajax (){
        def convenio = Convenio.get(params.id)
        def raza = Raza.get(params.raza)
        def etnias = EtniaOrganizacion.findByUnidadEjecutoraAndRaza(convenio.unidadEjecutora, raza)

        if(etnias){
            render "ok"
        }else{
            render "no"
        }
    }

    def agregarEtnia_ajax(){
        def convenio = Convenio.get(params.id)
        def raza = Raza.get(params.raza)
        def etnias = EtniaOrganizacion.findByUnidadEjecutoraAndRaza(convenio.unidadEjecutora, raza)
        def etniaOrg
        if(etnias){
            render "er"
        }else{

            etniaOrg = new EtniaOrganizacion()
            etniaOrg.unidadEjecutora = convenio.unidadEjecutora
            etniaOrg.raza = raza
            etniaOrg.numero = params.numero.toInteger()

            if(!etniaOrg.save(flush:true)){
                println("errro al guardar la etnia " + etniaOrg.errors)
                render "no"
            }else{
                render "ok"
            }
        }
    }

}
