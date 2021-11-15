package seguridad

import taller.Raza


class PersonaOrganizacionController {

    def show_ajax(){
        def beneficiario = PersonaOrganizacion.get(params.id)
        return[beneficiario: beneficiario]
    }

    def form_ajax(){
        def unidad = UnidadEjecutora.get(params.unidad)
        def beneficiario
        if(params.id){
            beneficiario = PersonaOrganizacion.get(params.id)
        }else{
            beneficiario = new PersonaOrganizacion()
        }
        return[unidad:unidad, beneficiario: beneficiario]
    }

    def saveBeneficiario_ajax(){
//        println("params sb " + params)

        def unidad = UnidadEjecutora.get(params.unidad)
        def beneficiario

        if(params.fechaInicio){
            params.fechaInicio = new Date().parse("dd-MM-yyy",params.fechaInicio)
        }

        if(params.id){
            beneficiario = PersonaOrganizacion.get(params.id)
        }else{
            beneficiario = new PersonaOrganizacion()
            beneficiario.fecha = new Date()
        }

        beneficiario.properties = params
        beneficiario.unidadEjecutora = unidad

        if(!beneficiario.save(flush:true)){
            println("error al guardar el beneficiario " + beneficiario.errors)
            render "no"
        }else{
            render "ok"
        }
    }

    def borrarBeneficiario_ajax(){
        def beneficiario = PersonaOrganizacion.get(params.id)
        def representante = Representante.findByPersonaOrganizacion(beneficiario)

        if(representante){
            render "er"
        }else{

            beneficiario.fechaFin = new Date()
            if(!beneficiario.save(flush:true)){
                println("error al borrar el beneficiario " + beneficiario.error)
                render "no"
            }else{
                render "ok"
            }
        }
    }

    def resumenEtnias_ajax(){
        def unidad = UnidadEjecutora.get(params.unidad)
        def personas = PersonaOrganizacion.findAllByUnidadEjecutoraAndRaza(unidad)
        return[personas:personas]
    }
}
