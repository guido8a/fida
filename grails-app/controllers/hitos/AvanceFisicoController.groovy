package hitos

import avales.ProcesoAval


class AvanceFisicoController {

    /**
     * Acción que muestra la lista de avances físicos de un proceso y permite agregar nuevos
     */
    def list = {
        def proceso = ProcesoAval.get(params.id)
        def ultimoAvance = AvanceFisico.findAllByProceso(proceso, [sort: "fecha", order: "desc"])
        def minAvance = 0
        def minDate = "";
        if (ultimoAvance.size() > 0) {
            def ua = ultimoAvance.first()
            minAvance = ua.avance
            minDate = (ua.fecha + 1).format("dd-MM-yyyy")
        }
        def maxAvance = 100 - minAvance

        def totalAvance = AvanceFisico.findAllByProceso(proceso)
        if (totalAvance.size() > 0) {
            totalAvance = totalAvance.sum { it.avance }
        } else {
            totalAvance = 0
        }
        maxAvance = 100 - totalAvance

        def tot = 0
        AvanceFisico.findAllByProceso(proceso).each {
            println "\t" + it.avance
            tot += it.avance
        }
        println "????? " + tot

        println ">>>>>>>>>>>>>>> " + totalAvance + " max " + maxAvance

        return [proceso: proceso, minAvance: minAvance, maxAvance: maxAvance, minDate: minDate]
    }

    /**
     * Acción cargada con ajax que retorna la lista de avances físicos de un proceso
     */
    def avanceFisicoProceso_ajax = {
        def proceso = ProcesoAval.get(params.id)
        def avances = AvanceFisico.findAllByProceso(proceso, [sort: "inicio"])
        return [proceso: proceso, avances: avances]
    }

    /**
     * Acción llamada con ajax que agrega un avance físico a un proceso
     */
    def addAvanceFisicoProceso_ajax = {
//        println("params af " + params)

        def proceso = ProcesoAval.get(params.id)
        def avance = new AvanceFisico()
        params.inicio = new Date().parse("dd-MM-yyyy", params.inicio)
        params.fin = new Date().parse("dd-MM-yyyy", params.fin)
        params.avance = params.avance.toString().toDouble()
        avance.properties = params
        avance.proceso = proceso
        if (avance.save(flush: true)) {
            def max = 100 - avance.avance
            def totalAvance = AvanceFisico.findAllByProceso(proceso).sum { it.avance }
            max = 100 - totalAvance
            def minDate = (avance.fecha + 1).format("dd-MM-yyyy")
            render "SUCCESS*Avance físico " + avance.observaciones + " agregado"
        } else {
            render "error*Ha ocurrido un error"
        }
    }

    def agregarAvance = {
        def avance = AvanceFisico.get(params.id)
        def av = new AvanceAvance()
        av.avanceFisico = avance
        av.avance = params.avance.toDouble()
        av.descripcion = params.desc
        av.save(flush: true)
        render "ok"
    }
}
