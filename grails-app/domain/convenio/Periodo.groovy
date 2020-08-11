package convenio

class Periodo {

    int numero
    Date fechaInicio
    Date fechaFin
    double valor
    String tipo

    static mapping = {
        table 'prdo'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'prdo__id'
            numero column: 'prdonmro'
            fechaInicio column: 'prdofcin'
            fechaFin column: 'prdofcfn'
            valor column: 'prdovlor'
            tipo column: 'prdotipo'
        }
    }

    static constraints = {
        numero(nullable: false, blank: false)
        fechaInicio(nullable: false, blank: false)
        fechaFin(nullable: false, blank: false)
        valor(nullable: false, blank: false)
        tipo(size: 1, nullable: false, blank: false)
    }
}
