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
                "rspg.rspg__id = dtec.rspg__id and preg.preg__id = rspg.preg__id and encuetdo = 'N' group by encu.encu__id"
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

        encu.fecha = new Date()
        encu.estado = 'N'
        encu.unidadEjecutora = session.unidad

        try{
//                println "inicia save"
            encu.save(flush: true)
            println "creado encuesta.. ok"
            creado = true
        } catch (e){
//                println "****** $e"
            println("error al crear ponePregunta: " + encu.errors)
        }


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

    def anterior() {
        println "params anterior: $params"
        def cn = dbConnectionService.getConnection()
        def actual = params.actual.toInteger() - 1
        def tx = "select teti__id from encu where encu__id = ${params.encu__id}"
//        println "anterior sql: $tx"
        if((cn.rows(tx.toString())[0]?.teti__id == 4) && params.actual.toInteger() == 3) {
            tx = "select count(*) cnta from encu, dtec where encu.encu__id = ${params.encu__id} and " +
                    "dtec.encu__id = encu.encu__id and prte__id = 68 and prit__id <> 2"
//            println "... $tx"
            if(cn.rows(tx.toString())[0]?.cnta == 0)
                actual--
        }

        ponePregunta(actual, session.total, session.encuesta, session.tipoEncuesta)
    }

    /** registra respuesta de preguntaPrit
     * repuestas: rppg__id
     * materia:   dcta__id
     * preg__id:  prte__id  **/
    def respuesta() {
        println "respuesta: $params"
        def cn = dbConnectionService.getConnection()
        def dtec
        //igual que en respuestaAsgn
        def tx = "select dtec__id from dtec, rspg where encu__id = ${params.encu__id} and " +
                "rspg.rspg__id = dtec.rspg__id and rspg.preg__id = ${params.preg__id}"
//        println "respuesta sql: $tx"
        dtec = cn.rows(tx.toString())[0]?.dtec__id

        //siempre se responde causa y respuesta
        if(dtec) {
            tx = "update dtec set rspg__id = ${params.respuestas} where dtec__id = ${dtec}"
        } else {
            tx = "insert into dtec(rspg__id, encu__id) " +
                    "values(${params.respuestas}, ${params.encu__id})"
        }
        try {
            cn.execute(tx.toString())
        }
        catch (e) {
            println e.getMessage()
        }
//        println "... sql: $tx"
        cn.close()
        //llamar al a siguiente pregunta
        def actual = params.actual.toInteger() + 1

        if(actual > session.total) {// ya ha terminado la ponePregunta
            finalizaEncuesta(session.encuesta.id)
        } else {
//            ponePregunta(actual, session.total, session.encuesta, session.tipoEncuesta)
            ponePregunta(actual, 100, params.encu__id)
        }
    }


}
