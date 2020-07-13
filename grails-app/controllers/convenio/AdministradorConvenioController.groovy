package convenio

import seguridad.Persona


class AdministradorConvenioController {

    def administrador_ajax () {
        def convenio = Convenio.get(params.id)
        def administradores

        def existente = AdministradorConvenio.findByConvenioAndFechaFinIsNull(convenio)
        if(existente){
            administradores = Persona.findAllByUnidadEjecutora(convenio.unidadEjecutora) - Persona.get(existente.persona.id)
            println("--> " + administradores)
        }else{
            administradores = Persona.findAllByUnidadEjecutora(convenio.unidadEjecutora)
        }

        return [administradores: administradores, convenio: convenio]
    }

    def tablaAdminCon_ajax () {

        def convenio = Convenio.get(params.id)
        def administradores = AdministradorConvenio.findAllByConvenio(convenio).sort{it.fechaFin}

        return[administradores: administradores]
    }

    def guardarAdministrador_ajax() {
//        println("params ga " + params)

        def convenio = Convenio.get(params.id)
        def persona = Persona.get(params.persona)
        def existente = AdministradorConvenio.findByConvenioAndFechaFinIsNull(convenio)
        def fecha = new Date().parse("dd-MM-yyyy", params.fechaInicio)
        def administrador

        if(existente){
            existente.fechaFin = fecha
            existente.save(flush: true)
        }

        administrador = new AdministradorConvenio()
        administrador.convenio = convenio
        administrador.persona = persona
        administrador.fechaInicio = fecha

        if(!administrador.save(flush: true)){
            println("error al guardar el administrador " + administrador?.errors)
            render "no"
        }else{
            render "ok"
        }

    }

}
