package convenio

import audita.Auditable

class Periodo implements Auditable {

    Convenio convenio
    int numero
    Date fechaInicio
    Date fechaFin
    double valor
    String tipo


    static auditable = true

    static mapping = {
        table 'prdo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'prdo__id'
            convenio column: 'cnvn__id'
            numero column: 'prdonmro'
            fechaInicio column: 'prdofcin'
            fechaFin column: 'prdofcfn'
            valor column: 'prdovlor'
            tipo column: 'prdotipo'
        }
    }

    static constraints = {
        convenio(nullable: false, blank:false)
        numero(nullable: false, blank: false)
        fechaInicio(nullable: true, blank: true)
        fechaFin(nullable: true, blank: true)
        valor(nullable: true, blank: true)
        tipo(nullable: true, blank: true)
    }
}
