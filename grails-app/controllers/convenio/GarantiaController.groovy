package convenio


class GarantiaController {

    def garantias(){
        def convenio = Convenio.get(params.id)
        return[convenio: convenio]
    }

}
