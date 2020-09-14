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
                params.padre = null
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
                params.padre = padre
                garantia = new Garantia()
                break;
        }

        params.codigo = params.codigo.trim()?.toUpperCase()
        params.estado = EstadoGarantia.get(1)
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

    def calcularDias_ajax(){

        def d1 = new Date().parse("dd-MM-yyyy",params.inicio)
        def d2 = new Date().parse("dd-MM-yyyy",params.fin)

        if(d1 > d2){
            render "er"
        }else{
            def duration = groovy.time.TimeCategory.minus(
                    new Date().parse("dd-MM-yyyy",params.inicio),
                    new Date().parse("dd-MM-yyyy",params.fin)
            );

//        println("du " + duration.days)
            render duration.days * -1
        }
    }

    def retornaGarantia(){
        def garantia = Garantia.get(params.id)
        def datos = garantia?.diasGarantizados + "_" + garantia?.fechaFinalizacion?.format("dd-MM-yyyy") + "_" + garantia?.fechaInicio?.format("dd-MM-yyyy") + "_" + garantia?.monto + "_" + garantia?.codigo?.trim() + "_" + garantia?.padre?.codigo + "_" + garantia?.estado?.id + "_" + garantia?.aseguradora?.id + "_" + garantia?.tipoDocumentoGarantia?.id + "_" + garantia?.tipoGarantia?.id + "_" + garantia?.id
//        println("datos: "+ datos)
        render datos
    }

}
