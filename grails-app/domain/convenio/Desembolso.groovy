package convenio

import audita.Auditable
import planes.FinanciamientoPlanNegocio

class Desembolso implements Auditable {

    FinanciamientoPlanNegocio financiamientoPlanNegocio
    Convenio convenio
    Garantia garantia
    String descripcion
    double valor
    Date fecha
    String cur

    static auditable = true

    static mapping = {
        table 'dsmb'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'dsmb__id'
            financiamientoPlanNegocio column: 'fnpn__id'
            convenio column: 'cnvn__id'
            garantia column: 'grnt__id'
            descripcion column: 'dsmbdscr'
            fecha column: 'dsmbfcha'
            valor column: 'dsmbvlor'
            cur column: 'dsmb_cur'
        }
    }

    static constraints = {
        financiamientoPlanNegocio(nullable: false, blank: false)
        convenio(nullable: false, blank: false)
        garantia(nullable: false, blank: false)
        descripcion(nullable: false, blank:false)
        valor(nullable: false, blank:false)
        fecha(nullable: false, blank:false)
        cur(nullable: false, blank:false)
    }
}
