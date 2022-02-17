package taller

import seguridad.PersonaOrganizacion
import seguridad.UnidadEjecutora


class AsisteController {

    def list(){

    }

    def tablaAsistentes_ajax(){
        def taller = Taller.get(params.id)
        def prsnTaller = Asiste.withCriteria {
            eq("taller",taller)
            if (params.search && params.search != "") {
                personaOrganizacion {
                    or {
                        ilike("nombre", "%" + params.search + "%")
                        ilike("apellido", "%" + params.search + "%")
                    }
                    order("nombre", "asc")
                }
            }
            order("personaOrganizacion", "asc")
        }
        return [prsnTaller: prsnTaller]
    }

    def listaTallerAsistentes(){
        def taller = Taller.get(params.id)
        return [taller: taller, unidad: taller.unidadEjecutora]
    }

    def listaBeneficiarios_ajax(){
        def taller = Taller.get(params.taller)
        def unidad = taller.unidadEjecutora
        return[unidad:unidad, taller: taller]
    }

    def tablaBeneficiariosAsiste_ajax(){
        def taller = Taller.get(params.taller)
        def unidad = UnidadEjecutora.get(params.id)
        def beneficiarios = PersonaOrganizacion.findAllByUnidadEjecutoraAndFechaFinIsNull(unidad).sort{it.apellido}
        return[beneficiarios: beneficiarios, unidad:unidad, taller: taller]
    }

    def guardarAsistente_ajax(){
        def persona = PersonaOrganizacion.get(params.id)
        def taller = Taller.get(params.taller)
        def asistente

        if(params.estado == '1'){
            asistente = new Asiste()
            asistente.fecha = new Date()
            asistente.personaOrganizacion = persona
            asistente.taller = taller

            if(!asistente.save(flush:true)){
                println("error al agregar el asistente " + asistente.errors)
                render "no"
            }else{
                render "ok"
            }

        }else{
            asistente = Asiste.findByPersonaOrganizacionAndTaller(persona, taller)

            try{
                asistente.delete(flush:true)
                render "er"
            }catch(e){
                println("error al borrar el asistente " + asistente.errors)
                render "no"
            }
        }
    }


}
