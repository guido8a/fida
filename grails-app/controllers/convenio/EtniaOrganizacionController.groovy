package convenio

import seguridad.UnidadEjecutora
import taller.Raza


class EtniaOrganizacionController {

    def formEtnias_ajax(){
        def unidad = UnidadEjecutora.get(params.unidad)
        return[unidad: unidad]
    }

    def tablaEtnias_ajax(){
        def unidad = UnidadEjecutora.get(params.id)
        def etnias = EtniaOrganizacion.findAllByUnidadEjecutora(unidad)

        return[etnias: etnias]
    }


    def agregarEtnia_ajax(){
        def unidad = UnidadEjecutora.get(params.id)
        def raza = Raza.get(params.raza)
        def etnias = EtniaOrganizacion.findByUnidadEjecutoraAndRaza(unidad, raza)
        def etniaOrg
        if(etnias){
            render "er"
        }else{

            etniaOrg = new EtniaOrganizacion()
            etniaOrg.unidadEjecutora = unidad
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

    def borrarEtnia_ajax(){
        def etnia = EtniaOrganizacion.get(params.id)

        try{
            etnia.delete(flush:true)
            render "ok"
        }catch(e){
            println("error al borrar el elemento del tabla etnia " + e + etnia.errors)
            render "no"
        }
    }

}
