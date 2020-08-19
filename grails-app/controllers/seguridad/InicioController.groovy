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


    /** carga datos desde un CSV - utf-8: si ya existe lo actualiza
     * */
    def leeCSV() {
//        println ">>leeCSV.."
        def contador = 0
        def cn = dbConnectionService.getConnection()
        def estc
        def rgst = []
        def cont = 0
        def repetidos = 0
        def procesa = 5
        def crea_log = false
        def inserta
        def fcha
        def magn
        def sqlp
        def directorio
//        def tipo = 'prueba'
        def tipo = 'prod'

        if (grails.util.Environment.getCurrent().name == 'development') {
            directorio = '/home/guido/proyectos/FAREPS/data/'
        } else {
            directorio = '/home/obras/data/'
        }

        if (tipo == 'prueba') { //botón: Cargar datos Minutos
            procesa = 5
            crea_log = false
        } else {
            procesa = 100000000000
            crea_log = true
        }

        def nmbr = ""
        def arch = ""
        def cuenta = 0
        new File(directorio).traverse(type: groovy.io.FileType.FILES, nameFilter: ~/.*\.csv/) { ar ->
            nmbr = ar.toString() - directorio
            arch = nmbr.substring(nmbr.lastIndexOf("/") + 1)

            /*** procesa las 5 primeras líneas del archivo  **/
            def line
            cont = 0
            repetidos = 0
            ar.withReader('UTF-8') { reader ->
                print "Cargando datos desde: $ar "
                while ((line = reader.readLine()) != null) {
                    if (cuenta > 0 && cuenta < procesa) {

                        rgst = line.split('\t')
                        rgst = rgst*.trim()
                        println "***** $rgst"

                        inserta = cargaData(rgst)
                        cont += inserta.insertados
                        repetidos += inserta.repetidos

                        if (rgst.size() > 2 && rgst[-2] != 0) cuenta++  /* se cuentan sólo si hay valores */

                    } else {
                        cuenta++
                    }
                }
            }
            println "---> archivo: ${ar.toString()} --> cont: $cont, repetidos: $repetidos"
        }
//        return "Se han cargado ${cont} líneas de datos y han existido : <<${repetidos}>> repetidos"
        render "Se han cargado ${cont} líneas de datos y han existido : <<${repetidos}>> repetidos"
    }


    def cargaData(rgst) {
        def errores = ""
        def cnta = 0
        def insertados = 0
        def repetidos = 0
        def cn = dbConnectionService.getConnection()
        def sqlParr = ""
        def sql = ""
        def parr = 0
        def tx = ""
        def fcha = ""
        def zona = ""
        def nombres
        def nmbr = "", apll = "", login = "", orden = 0
        def id = 0

//        println "\n inicia cargado de datos para $rgst"
        cnta = 0
        if (rgst[1].toString().size() > 0) {
            tx = rgst[7].split('-').last()
//            sqlParr = "select parr__id from parr where parrnmbr ilike '%${tx}%'"
            sqlParr = "select parr__id from parr, cntn, prov where parrnmbr ilike '%${tx}%' and " +
                    "cntn.cntn__id = parr.cntn__id and prov.prov__id = cntn.prov__id and " +
                    "provnmbr ilike '${rgst[5].toString().trim()}'"
            println "sqlParr: $sqlParr"
            parr = cn.rows(sqlParr.toString())[0]?.parr__id
//            sql = "select count(*) nada from unej where unejnmbr = '${rgst[3].toString().trim()}'"
            sql = "select count(*) nada from unej where unejnmbr = '${rgst[3].toString().trim()}'"
            cnta = cn.rows(sql.toString())[0]?.nada
            if (parr && (cnta == 0)) {
                if(rgst[2]?.size() > 6) {
                    fcha =  new Date().parse("dd/MM/yyyy", rgst[2]).format('yyyy-MM-dd')
                } else {
                    fcha = '1-jan-1900'
                }
                zona =  rgst[4].split(' ').last()
                /* crea la UNEJ*/
                sql = "insert into unej (unej__id, unejobsr, unejfcin, unejnmbr, unejnmsr, parr__id, unejdire, " +
                        "unejrefe, unejtelf, unejlgal, unej_ruc, unej_rup, unejmail, " +
                        "unejanio, unejordn) " +
                        "values(default, '${rgst[0]}', '${fcha}', '${rgst[3]}', ${zona}, ${parr}, '${rgst[8]}', " +
                        "'${rgst[9]}', '${rgst[10]}', '${rgst[11][0]}', '${rgst[12]}', '${rgst[13]}', '${rgst[14]}', " +
                        "${rgst[15]}, ${orden})" +
                        "returning unej__Id"
//                        "on conflict (parr__id, cmndnmbr) DO NOTHING"

                try {
                    cn.eachRow(sql.toString()) { d ->
                        id = d.unej__id
                        insertados++
                        orden++
                    }
                    println "---> id: ${id}"

                    /* crea PRSN*/
                    nombres = rgst[16].split(' ').toList()
                    if(nombres.size() > 3) {
                        nmbr = "${nombres[0]} ${nombres[1]}"
                        apll = "${nombres[2]} ${nombres[3]}"
                        login = "${nmbr[0]}${nombres[2]}"
                    } else {
                        nmbr = nombres[0]
                        nombres.remove(0)
                        login = "${nmbr[0]}${nombres[0]}"
                        apll = nombres.join(' ')
                    }

                    sql = "insert into prsn (prsn__id, unej__id, prsndire, prsnrefe, prsntelf, prsnmail, " +
                            "prsncdla, prsnnmbr, prsnapll, prsnactv, prsnsexo, prsnlogn, prsnpass) " +
                            "values(default, ${id}, '${rgst[17]}', '${rgst[18]}', '${rgst[19]}', '${rgst[20]}', " +
                            "'0000', '${nmbr}', '${apll}', 0, 'F', '${login}', md5('123'))"
                    println "sql2: $sql"
                    cn.execute(sql.toString())

                } catch (Exception ex) {
                    repetidos++
                    println "Error al insertar $ex"
                    println "sql: $sql"
                }


            }
//            println "sql: $sql"


        }
        cnta++
        return [errores: errores, insertados: insertados, repetidos: repetidos]
    }

    def verifica() {
        def prsn = Persona.list()
        println "personas ok"
        def unej = UnidadEjecutora.list()
        println "Unidades ok"
        render "ok"
    }


}
