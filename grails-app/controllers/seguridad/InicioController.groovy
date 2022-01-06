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
//                        println "***** $rgst"

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
        def resp = 0

//        println "\n inicia cargado de datos para $rgst"
        cnta = 0
        if (rgst[1].toString().size() > 0) {
            tx = rgst[7].split('-').last().split(' ').last()
//            sqlParr = "select parr__id from parr where parrnmbr ilike '%${tx}%'"
            sqlParr = "select parr__id from parr, cntn, prov where parrnmbr ilike '%${tx}%' and " +
                    "cntn.cntn__id = parr.cntn__id and prov.prov__id = cntn.prov__id and " +
                    "provnmbr ilike '${rgst[5].toString().trim()}'"
//            println "sqlParr: $sqlParr"
            parr = cn.rows(sqlParr.toString())[0]?.parr__id
//            sql = "select count(*) nada from unej where unejnmbr = '${rgst[3].toString().trim()}'"
            sql = "select count(*) nada from unej where unejnmbr = '${rgst[3].toString().trim()}'"
            cnta = cn.rows(sql.toString())[0]?.nada
//            println "parr: $parr"
            if (!parr) {
                sqlParr = "select cntn__id from cntn where cntnnmbr ilike '%${rgst[6]}%'"
                def cntn = cn.rows(sqlParr.toString())[0]?.cntn__id
                if (cntn) {
                    sqlParr = "insert into parr(parr__id, cntn__id, parrnmbr) " +
                            "values (default, ${cntn}, '${rgst[7]}') returning parr__id"
                    cn.eachRow(sqlParr.toString()) { d ->
                        parr = d.parr__id
                    }
                    println "parr --> $parr"
                }
//                println "no existe parroquia: ${rgst[5]} ${rgst[6]} ${tx} --> cntn: ${cntn}"
//                println "sql: $sqlParr"
            }

            if (parr && (cnta == 0)) {
                if (rgst[2]?.size() > 6) {
                    fcha = new Date().parse("dd/MM/yyyy", rgst[2]).format('yyyy-MM-dd')
                } else {
                    fcha = '1-jan-1900'
                }
                zona = rgst[4].split(' ').last()
                /* crea la UNEJ*/
                sql = "insert into unej (unej__id, unejinst, unejfcin, unejnmbr, unejnmsr, parr__id, unejdire, " +
                        "unejrefe, unejtelf, unejlgal, unej_ruc, unej_rup, unejmail, " +
                        "unejanio, unejordn, tpin__id, unejactv, unejacsc, unejfort) " +
                        "values(default, '${rgst[1]}', '${fcha}', '${rgst[3]}', ${zona}, ${parr}, '${rgst[8]}', " +
                        "'${rgst[9]}', '${rgst[10]}', '${rgst[11][0]}', '${rgst[12]}', '${rgst[13]}', '${rgst[14]}', " +
                        "${rgst[15]}, ${orden}, 2, '${rgst[32]}', '${rgst[33]}', '${rgst[34]}')" +
                        "returning unej__Id"
//                        "on conflict (parr__id, cmndnmbr) DO NOTHING"
                println "sql ---> ${sql}"

                try {
                    cn.eachRow(sql.toString()) { d ->
                        id = d.unej__id
                        insertados++
                        orden++
                    }
                    println "---> id: ${id}"

                    /********** crea PRSN ***********/

                    nombres = rgst[16].split(' ').toList()
                    if (nombres.size() > 3) {
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
                            "values(default, ${id}, '${rgst[17]}', '${rgst[18]}', '${rgst[19].replaceAll('\'', '')}', '${rgst[20]}', " +
                            "'0000', '${nmbr}', '${apll}', 0, 'F', '${login}', md5('123'))"
                    println "sql2: $sql"
                    cn.execute(sql.toString())

                    resp = hallaResponsable(rgst[36])
                    println "resp: ${resp}"

                    sql = "insert into dtor (dtor__id, unej__id, " +
                            "dtornmhh, dtornmmj, dtornmjv, dtornmad, dtornsam, prsn__id) " +
                            "values(default, ${id}, " +
                            "${rgst[21].trim() ?: null}, ${rgst[22].trim() ?: null}, ${rgst[23].trim() ?: null}," +
                            " ${rgst[24].trim() ?: null}, ${rgst[25].trim() ?: null}, ${resp})"
                    println "sql2: $sql"
                    cn.execute(sql.toString())

                    println "insertaEtor.... ${rgst[26]},${rgst[27]},${rgst[28]},${rgst[29]},${rgst[30]},${rgst[31]}"
                    println "insertaEtor..>> ${rgst[26].trim().size() > 0 ? rgst[26] : 'vacío'}"
                    if (rgst[26].trim()?.size() > 0) insertaEtor(id, 2, rgst[26])
                    if (rgst[27].trim()?.size() > 0) insertaEtor(id, 4, rgst[27])
                    if (rgst[28].trim()?.size() > 0) insertaEtor(id, 3, rgst[28])
                    if (rgst[29].trim()?.size() > 0) insertaEtor(id, 5, rgst[29])
                    if (rgst[30].trim()?.size() > 0) insertaEtor(id, 1, rgst[30])
                    if (rgst[31].trim()?.size() > 0) insertaEtor(id, 6, rgst[31])

                    println "inicia insertaCtgr.... ${rgst[39]}, ${rgst[41]}"
                    /* tpct:1,2 col:39,41 es numérico */
                    if (rgst[39]?.toInteger() > 0) insertaCtgr(id, 1, rgst[39])
                    if (rgst[41]?.toInteger() > 0) insertaCtgr(id, 2, rgst[41])

                    if (rgst[42]) insertaCtgr(id, 3, rgst[42])
                    if (rgst[43]) insertaCtgr(id, 4, rgst[43])
                    if (rgst[44]) insertaCtgr(id, 5, rgst[44])
                    if (rgst[45]) insertaCtgr(id, 6, rgst[45])
                    if (rgst[46]) insertaCtgr(id, 7, rgst[46])
                    if (rgst[47]) insertaCtgr(id, 8, rgst[47])
                    if (rgst[48]) insertaCtgr(id, 9, rgst[48])
                    if (rgst[49]) insertaCtgr(id, 10, rgst[49])
                    if (rgst[50]) insertaCtgr(id, 11, rgst[50])
                    if (rgst[51]) insertaCtgr(id, 12, rgst[51])
                    if (rgst[52]) insertaCtgr(id, 13, rgst[52])

                    println "inicia insertaNecd.... ${rgst[53]}, ${rgst[60]}"
                    if (rgst[53]) insertaNecd(id, 1)
                    if (rgst[54]) insertaNecd(id, 2)
                    if (rgst[55]) insertaNecd(id, 3)
                    if (rgst[56]) insertaNecd(id, 4)
                    if (rgst[57]) insertaNecd(id, 5)
                    if (rgst[58]) insertaNecd(id, 6)
                    if (rgst[59]) insertaNecd(id, 7)
                    if (rgst[60]) insertaNecd(id, 8)


                } catch (Exception ex) {
                    repetidos++
                    println "Error principal $ex"
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
        def dtor = convenio.DatosOrganizacion.list()
        println "DatosOrganizacion ok"
        render "ok"
    }

    def insertaEtor(unej, raza, nmro) {
        def cn = dbConnectionService.getConnection()
        def sql = "insert into etor (etor__id, unej__id, raza__id, etornmro) " +
                "values(default, ${unej}, ${raza}, ${nmro})"
        println "sql2: $sql"
        try {
            cn.execute(sql.toString())
        } catch (Exception ex) {
            println "Error insertaEtor $ex"
            println "Error sql: $sql"
        }
    }

    def insertaCtgr(unej, tpct, vlor) {
        def cn = dbConnectionService.getConnection()
        def sql = "insert into ctgr (ctgr__id, unej__id, tpct__id, ctgrvlor) " +
                "values(default, ${unej}, ${tpct}, '${vlor}')"
//        println "insertaCtgr: $sql"
        try {
            cn.execute(sql.toString())
        } catch (Exception ex) {
            println "Error insertaCtgr $ex"
            println "Error sql: $sql"
        }
    }

    def insertaNecd(unej, ndfr) {
        def cn = dbConnectionService.getConnection()
        def sql = "insert into necd (necd__id, unej__id, ndfr__id) " +
                "values(default, ${unej}, ${ndfr})"
//        println "insertaNecd: $sql"
        try {
            cn.execute(sql.toString())
        } catch (Exception ex) {
            println "Error insertaNecd $ex"
            println "Error sql: $sql"
        }
    }

    def hallaResponsable(nmbr) {
        def apll = nmbr.split(' ').last()
        def cn = dbConnectionService.getConnection()
        def sql = "select prsn__id from prsn where prsnapll ilike '%${apll.toString().toLowerCase()}%' "
//        println "sql2: $sql"
        cn.rows(sql.toString())[0].prsn__id
    }


    /** carga datos desde un CSV - utf-8: si ya existe lo actualiza
     * */
    def leeTalleres() {
        println ">>leeTalleres.."
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

        if (tipo == 'prueba') { //botón: Cargar datos Minutos
            procesa = 5
            crea_log = false
        } else {
            procesa = 100000000000
            crea_log = true
        }

        def nmbr = ""
        def arch = new File('/home/guido/proyectos/FAREPS/data/talleres.csv')
        def cuenta = 0
        def line
        arch.withReader { reader ->
            while ((line = reader.readLine()) != null) {
                if (cuenta > 0 && cuenta < procesa) {

                    rgst = line.split('\t')
                    rgst = rgst*.trim()
//                    println "****(${cuenta}) $rgst"

                    inserta = cargaTaller(rgst)
                    cont += inserta.insertados
                    repetidos += inserta.repetidos

                    cuenta++
                } else {
                    cuenta++
                }
            }
            println "---> archivo: ${arch.toString()} --> cont: $cont, repetidos: $repetidos"
//        return "Se han cargado ${cont} líneas de datos y han existido : <<${repetidos}>> repetidos"
            render "Se han cargado ${cont} líneas de datos y han existido : <<${repetidos}>> repetidos"
        }
    }

    def cargaTaller(rgst) {
        def errores = ""
        def cnta = 0, cntaInas = 0
        def insertados = 0
        def repetidos = 0
        def cn = dbConnectionService.getConnection()
        def sqlParr = ""
        def sql = ""
        def parr = 0, cmnd = 0
        def tx = ""
        def fcha = ""
        def zona = ""
        def nombres
        def nmbr = "", apll = "", unej = "", tptl = "", raza = 0, inas = [], inst = 0
        def id = 0
        def resp = 0

//        println "\n inicia cargado de datos para $rgst"
        cnta = 0
        if (rgst[1].toString().size() > 0) {
            tx = rgst[4].split('-').last()
//            sqlParr = "select parr__id from parr where parrnmbr ilike '%${tx}%'"
            sqlParr = "select parr__id from parr, cntn, prov where parrnmbr ilike '%${tx}%' and " +
                    "cntn.cntn__id = parr.cntn__id and prov.prov__id = cntn.prov__id and " +
                    "provnmbr ilike '%${rgst[2].toString().trim()}%'"
            println "sqlParr: $sqlParr"
            parr = cn.rows(sqlParr.toString())[0]?.parr__id

            println "parr: ${tx} --> $parr"
            if (!parr) {
                sqlParr = "select cntn__id from cntn where cntnnmbr ilike '%${rgst[3]}%'"
                def cntn = cn.rows(sqlParr.toString())[0]?.cntn__id
                println "no existe parroquia: ${tx} --> cntn: ${cntn}"

                if (cntn) {
                    sqlParr = "insert into parr(parr__id, cntn__id, parrnmbr) " +
                            "values (default, ${cntn}, '${tx}') returning parr__id"
                    println "--> $sqlParr"
                    cn.eachRow(sqlParr.toString()) { d ->
                        parr = d.parr__id
                    }
                    println "parr --> $parr"
                }
            }

            def unejnmbr = rgst[8][rgst[8].indexOf(' ') + 1..-1]
            def unej_ruc = rgst[9].toString().trim()
            def tllrfcha

            def comilla = rgst[22] ? "'" : ""

//            sql = "select unej__id from unej where unejnmbr ilike '%${unejnmbr.trim()}%'"
            sql = "select unej__id from unej where unej_ruc = '${unej_ruc}'"
            unej = cn.rows(sql.toString())[0]?.unej__id

            /** Inserta la Organización si no existe */
            if(!unej) {
                zona = rgst[1].split(' ').last()
                sql = "insert into unej (unej__id, unejinst, unejfcin, unejnmbr, unejnmsr, parr__id, unejdire, " +
                        "unejlgal, unej_ruc, tpin__id) " +
                        "values(default, 'IEPS', '1-jan-2019', '${rgst[8]}', ${zona}, ${parr}, 'ND', " +
                        "'S', '${rgst[9]}', 2) returning unej__id"
                println "sql ---> ${sql}"
                    cn.eachRow(sql.toString()) { d ->
                        unej = d.unej__id
                    }
                    println "UNEJ --> $unej"
            }

            sql = "select tptl__id from tptl where tptldscr ilike '%${rgst[19]}%'"
            tptl = cn.rows(sql.toString())[0]?.tptl__id

            if(!tptl) {
                sql = "insert into tptl (tptl__id, tptldscr) " +
                        "values(default, '${rgst[19]}') returning tptl__id"
                println "sql ---> ${sql}"
                cn.eachRow(sql.toString()) { d ->
                    tptl = d.tptl__id
                }
                println "TPTL --> $tptl"
            }


            rgst[20] = rgst[20] ?: ''
            if (rgst[20]?.size() > 6) {
                tllrfcha = new Date().parse("dd/MM/yyyy", rgst[20]).format('yyyy-MM-dd')
                sql = "select count(*) nada from tllr where tllrfcha = '${tllrfcha}' and unej__id = ${unej}"
            } else {
                tllrfcha = rgst[0]
                sql = "select count(*) nada from tllr where tllrnmbr ilike '%${tllrfcha}%' and unej__id = ${unej}"
            }
            cnta = cn.rows(sql.toString())[0]?.nada

//            println "unej: ${unej} --> ${rgst[8]}, cnta: ${cnta}, tptl: ${tptl}, fcha: '${tllrfcha}'"

            if (parr && (cnta == 0)) {
                /* crea la UNEJ*/
                sql = "insert into tllr (tllr__id, parr__id, unej__id, unej_eps, tptl__id, tllrnmbr, " +
                        "tllrobjt, tllrfcha, tllrobsr) " +
                        "values(default, '${parr}', '${unej}', 2, ${tptl}, 'Taller ${tllrfcha}', " +
                        "'${rgst[19]}', '${tllrfcha}', ${comilla}${rgst[22] ?: null}${comilla}) " +
                        "returning tllr__id"
                println "sql ---> ${sql}"

                try {
                    cn.eachRow(sql.toString()) { d ->
                        id = d.tllr__id
                        insertados++
                    }
                } catch (Exception ex) {
                    repetidos++
                    println "Error taller $ex --> ${rgst[8]}"
//                    println "Error taller ${rgst[8]}"
//                    println "sql: $sql"
                }
            } else {
                sql = "select tllr__id from tllr where tllrnmbr ilike '%${tllrfcha}%' and unej__id = ${unej}"
                id = cn.rows(sql.toString())[0]?.tllr__id

//                    println "---> id: ${id}"

                /********** crea PRSN ***********/

                if (rgst[15]) {
                    sqlParr = "select cmnd__id from cmnd where parr__id = '${parr}' and " +
                            "cmndnmbr ilike '${rgst[15].toString().trim()}'"
//                    println "sqlParr: $sqlParr"
                    cmnd = cn.rows(sqlParr.toString())[0]?.cmnd__id

//                    println "cmnd: $cmnd"
                    if (!cmnd) {
                        sqlParr = "insert into cmnd(cmnd__id, parr__id, cmndnmbr, cmndnmro) " +
                                "values (default, ${parr}, '${rgst[15]}', 0) returning cmnd__id"
                        cn.eachRow(sqlParr.toString()) { d ->
                            cmnd = d.cmnd__id
                        }
                        println "cmnd --> $cmnd"
                    }

                } else {
                    cmnd = null
                }

                sql = "select raza__id from raza where razadscr ilike '%${rgst[12].trim()}%'"
                raza = cn.rows(sql.toString())[0]?.raza__id
//                println "raza: $raza"

                sql = "insert into prtl (prtl__id, tllr__id, cmnd__id, parr__id, raza__id, " +
                        "prtlcdla, prtlnmbr, prtlapll, prtlcrgo, prtlsexo, " +
                        "prtledad, prtlmail, prtltelf, prtlcell) " +
                        "values(default, ${id}, ${cmnd ?: null}, ${parr}, ${raza}, " +
                        "'${rgst[7] ?: "0000"}', '${rgst[5]}', '${rgst[6]}', '${rgst[10]}', '${rgst[11][1]}', " +
                        "${rgst[13] ?: 0}, '${rgst[18].toString().toLowerCase()}', '${rgst[17]}', '${rgst[16]}')"
//                println "sql2: $sql"

                try {
                    cn.execute(sql.toString())
                    insertados++

                    if (rgst[21]?.size() > 2) {
                        inas = rgst[21].split(',')
                        inas.each { d ->
                            sql = "select inst__id from inst where instdscr ilike '%${d.trim()}%'"
                            inst = cn.rows(sql.toString())[0]?.inst__id
                            sql = "select count(*) cnta from inas where inst__id = ${inst}"
                            cntaInas = cn.rows(sql.toString())[0]?.cnta
                            if(!cntaInas) {
                                sql = "insert into inas(tllr__id, inst__id) values (${id}, ${inst})"
                                cn.execute(sql.toString())
                            }
                        }
                    }

                } catch (Exception ex) {
                    repetidos++
                    println "Error prtl $ex"
                    println "sql: $sql"
                }
            }


//            println "sql: $sql"


        }

        cnta++
        return [errores: errores, insertados: insertados, repetidos: repetidos]
    }

}
