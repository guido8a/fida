package seguridad

class InicioController {

    def dbConnectionService
    def diasLaborablesService

    def index() {
/*
        if (session.usuario.getPuedeDirector()) {
            redirect(controller: "retrasadosWeb", action: "reporteRetrasadosConsolidadoDir", params: [dpto: Persona.get(session.usuario.id).departamento.id, inicio: "1", dir: "1"])
        } else {
            if (session.usuario.getPuedeJefe()) {
                redirect(controller: "retrasadosWeb", action: "reporteRetrasadosConsolidado", params: [dpto: Persona.get(session.usuario.id).departamento.id, inicio: "1"])
            } else {
            }

        }
*/

//        def fcha = new Date()
//        def fa = new Date(fcha.time - 2*60*60*1000)
//        def fb = new Date(fcha.time + 25*60*60*1000)
//        println "fechas: fa: $fa, fb: $fb"
//        def nada = diasLaborablesService.tmpoLaborableEntre(fa,fb)

    }

    def parametros = {

    }
}
