package convenio


class CodigoComprasPublicasController {
    def dbConnectionService

    def tablaCodigosCompras () {

        println("params " + params)

        def sql = "select * from cpac where cpacnmro ilike '%${params.codigo}%' and cpacdscr ilike '%${params.nombre}%' order by cpacnmro limit 100"
        def cn = dbConnectionService.getConnection()
        def tabla = cn.rows(sql.toString())

        return[lista: tabla, tipo: params.tipo]
    }

    def buscarCodigo () {
        return[tipo: params.tipo]
    }


}
