package preguntas


import preguntas.Respuesta

class EncuestaController {

    def dbConnectionService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {

    }

    /**
     * tipo de ponePregunta: FE id: 4
     * tipo de informante: estudiante: 1, profesor: 2
     * seleccina pregunta que toca e invoca la acción correspondiente al tipo
     */
    def ponePregunta() {
        println "ponePregunta ----> $params sesión: ${session.unidad}"
        def cn = dbConnectionService.getConnection()
        def tx = "select max(coalesce(pregnmro,0)) nmro, encu.encu__id from dtec, rspg, preg, encu " +
                "where unej__id = ${session.unidad.id} and dtec.encu__id = encu.encu__id and " +
                "rspg.rspg__id = dtec.rspg__id and preg.preg__id = rspg.preg__id and encuetdo = 'I' group by encu.encu__id"
        println "sql: $tx"
        def ninguna
        def actual
        def encu
        def preg
        def pregunta
        def rp
        def resp

        cn.eachRow(tx.toString()) { d ->
            actual = d?.nmro
            encu = Encuesta.get(encu__id)
        }

        if(!actual) {
            println "no ha empezado la encuesta"
            /* crear encuesta y actualizar encu */
            encu = new Encuesta()
            actual = 1
        } else {
            println "ya está en: ${actual}"
        }

        preg = seleccionaPregunta(actual, encu.id)
//        println "preg:---> $preg"
        actual   = preg[0]
        pregunta = preg[1]  // id:dscr
        rp = preg[2]        // id:dscr
//        resp = [1, 877, null]    // id:rppg, id:dcta__id, id:prit__id lo ya contestado
        resp = preg[3]

//        println "encu: $encu \nactual: $actual \nmax: $total \npregunta: $pregunta \nrp: $rp \nresp: $resp \nmaterias: $matr"
//        println " -----> pregunta: $pregunta"
//        println " respondido ${resp}"

//        println "tiempo ejecución ponePregunta: ${TimeCategory.minus(pruebasFin, pruebasInicio)}"

//        println "pregunta ${pregunta.id}, persona: ${session.tipoPersona}"

        render (view: 'pregunta',
                model: [encu: encu.id, actual: actual, total: 100, pregunta: pregunta, rp: rp,
                resp: resp])
    }

    def seleccionaPregunta(actual, encu){
        def cn = dbConnectionService.getConnection()
        def tx = "select preg__id id, pregdscr, pregnmro from preg where pregnmro >= ${actual} order by pregnmro limit 1"
        def preg = []
        def resp = []
        def rp = [:]
        def contestado = []
//        println " a ejecutar seleccionaPregunta: ${tx}"

        def prte = cn.rows(tx.toString())[0]
//        println "dscr: ${prte.dscr}"
        preg.add(prte.pregnmro)
        preg.add([id: prte.id, dscr: prte.pregdscr])   //prte__id y pregunta respectiva

        tx = "select rspg.rspg__id id, respdscr dscr from rspg, resp " +
                "where rspg.preg__id = ${prte.id} and resp.resp__id = rspg.resp__id order by resp.resp__id"
        println "++seleccionaPregunta: ${tx}"
        cn.eachRow(tx.toString()) { d ->
            rp = [:]
            rp.id = d.id
            rp.dscr = d.dscr
            resp.add(rp)
        }
        preg.add(resp)

        tx = "select dtec.rspg__id, dtecvlor from dtec, rspg, preg " +
                "where encu__id = ${encu?:0} and rspg.rspg__id = dtec.rspg__id and " +
                "preg.preg__id = rspg.preg__id and pregnmro = ${actual}"
        println "++seleccionaPregunta: ${tx}"
        cn.eachRow(tx.toString()) { d ->
            contestado = [d.rspg__id?:0, d.dtecvlor?:0]
        }
        if(!contestado) {
            preg.add([0,0,0])
        } else {
            preg.add(contestado)
        }


//        println "+++++ resp: $resp"
        cn.close()
//        println "+++++++ pregunta: $preg"
        return preg
    }



}
