package convenio


class GarantiaController {

    def garantias(){
        def convenio = Convenio.get(params.id)
        return[convenio: convenio]
    }

    def saveGarantia_ajax(){

        println("params sg " + params)

        def garantia
        def padre = null

        switch (params.tipo.toString().trim().toLowerCase()) {
            case "add":
                garantia = new Garantia()
                break;
            case "edit":
                garantia = Garantia.get(params.id)
                break;
            case "renew":
                garantia = new Garantia()
                padre = Garantia.get(params.id)
                padre.estado = EstadoGarantia.get(6) //renovada
                if (!padre.save(flush: true)) {
                    println "error save padre" + padre.errors
                }
                break;
        }

        params.diasGarantizados = 0
        params.estado = EstadoGarantia.get(1)
        params.padre = padre
        params.estadoGarantia = "N"
        params.monto = params.monto.toDouble()
        params.diasGarantizados = params.diasGarantizados.toInteger()
        params.fechaInicio = new Date().parse("dd-MM-yyyy", params.fechaEmision)
        params.fechaFinalizacion = new Date().parse("dd-MM-yyyy", params.fechaFinalizacion)
        garantia.properties = params

        if (!garantia.save(flush: true)) {
            println "Error al guardar la garantia " + garantia.errors
            render "no"
        } else {
            render "ok"
        }

    }

    def tablaGarantias_ajax(){
        def convenio = Convenio.get(params.id)
        def garantias = Garantia.findAllByConvenio(convenio)
        return[garantias: garantias]
    }

}
