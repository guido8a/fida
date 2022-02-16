package taller

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
        return[unidad:unidad]
    }

    def tablaBeneficiarios_ajax(){

    }


}
