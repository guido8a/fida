package preguntas


import preguntas.Respuesta
import seguridad.UnidadEjecutora

class EncuestaController {

    def dbConnectionService

    static allowedMethods = [save: "POST", update: "PUT", delete: "DELETE"]

    def index(Integer max) {

    }

    /**
     * inicia una nueva
     */
    def iniciaEncu() {
        println "iniciaEncu ----> $params"
        def cn = dbConnectionService.getConnection()
        def unidad = UnidadEjecutora.get(params.unej)
        def actual
        def encu
        def tx = "select count(*) nmro from preg"
        def total = cn.rows("select max(pregnmro) nmro from preg".toString())[0].nmro

        tx = "select max(coalesce(pregnmro,0)) nmro, encu.encu__id from dtec, rspg, encu, preg " +
                "where unej__id = ${params.unej} and dtec.encu__id = encu.encu__id and " +
                "rspg.rspg__id = dtec.rspg__id and preg.preg__id = rspg.preg__id and encuetdo = 'N' group by encu.encu__id"
        println "sql: $tx"

        cn.eachRow(tx.toString()) { d ->
            actual = d?.nmro + 1
            encu = Encuesta.get(d.encu__id)
        }

        if(!actual) {
            println "no ha empezado la encuesta"
            encu = new Encuesta()
            actual = 1
        } else {
            println "ya está en: ${actual}"
        }

        encu.fecha = new Date()
        encu.estado = 'N'
        encu.unidadEjecutora = unidad

        try{
            encu.save(flush: true)
            println "creado encuesta.. ok"
            creado = true
        } catch (e){
//                println "****** $e"
            println("error al crear ponePregunta: " + encu.errors)
        }
        ponePregunta(actual, total, encu.id, unidad)

    }

    def ponePregunta(actual, total, encu__id, unej) {
        def cn = dbConnectionService.getConnection()
        def preg = seleccionaPregunta(actual, encu__id)
//        println "preg:---> $preg"
        actual   = preg[0]
        def pregunta = preg[1]  // id:dscr
        def rp = preg[2]        // id:dscr
//        resp = [1, 877, null]    // id:rppg, id:dcta__id, id:prit__id lo ya contestado
        def resp = preg[3]

        println "resp ${resp}"
//        println "rp ${rp} --> actual: $actual, total: $total, ${actual.class} == ${total.class}"
        render (view: 'pregunta',
                model: [encu: encu__id, actual: actual, total: total.toInteger(), pregunta: pregunta, rp: rp,
                resp: resp, unidad: unej.id])
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
        println "++seleccionaResp: ${tx}"
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
        def actual = params.actual.toInteger() - 1
        def unidad = UnidadEjecutora.get(params.unej)
        ponePregunta(actual, params.total, params.encu__id, unidad)
    }

    /** registra respuesta de preguntaPrit
     * repuestas: rppg__id
     * materia:   dcta__id
     * preg__id:  prte__id  **/
    def respuesta() {
        println "respuesta: $params"
        def cn = dbConnectionService.getConnection()
        def dtec
        def unidad = UnidadEjecutora.get(params.unidad)
        //igual que en respuestaAsgn
        def tx = "select dtec__id from dtec, rspg where encu__id = ${params.encu__id} and " +
                "rspg.rspg__id = dtec.rspg__id and rspg.preg__id = ${params.preg__id}"
        println "respuesta sql: $tx"
        dtec = cn.rows(tx.toString())[0]?.dtec__id

        def numero = params.numero? Math.round(params?.numero?.toDouble()) : 0
        println "numero: $numero"
        //siempre se responde causa y respuesta
        if(dtec) {
            if(params.resp == '3') {
                tx = "update dtec set dtecvlor = ${numero} where dtec__id = ${dtec}"
            } else if(params.resp == '4') {
                tx = "update dtec set dtecvlor = '${params.texto}' where dtec__id = ${dtec}"
            } else {
                tx = "update dtec set rspg__id = ${params.respuestas} where dtec__id = ${dtec}"
            }
        } else if(params.resp == '3'){
            tx = "insert into dtec(rspg__id, encu__id, dtecvlor) " +
                    "values(${params.rspg}, ${params.encu__id}, ${numero})"
        } else if(params.resp == '4'){
            tx = "insert into dtec(rspg__id, encu__id, dtecvlor) " +
                    "values(${params.rspg}, ${params.encu__id}, '${params.texto}')"
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

        if(actual > params.total.toInteger()) {// ya ha terminado la ponePregunta
            finalizaEncuesta(params.encu__id)
        } else {
//            ponePregunta(actual, session.total, session.encuesta, session.tipoEncuesta)
            ponePregunta(actual, params.total, params.encu__id, unidad)
        }
    }

    def finalizaEncuesta(encu) {
        println "llega encu: $encu"
        def cn = dbConnectionService.getConnection()
        def tx = "update encu set encuetdo = 'C' where encu__id = $encu"
//        println "finalizaEncu: $tx"
        cn.execute(tx.toString())
        redirect action: 'index'
    }


}
