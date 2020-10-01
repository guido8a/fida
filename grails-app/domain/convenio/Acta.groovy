package convenio

import audita.Auditable


class Acta implements Auditable{

    Convenio convenio
    String descripcion
    String nombre
    String numero
    String tipo
    Date fecha
    Date fechaRegistro
    int registrada
    int espacios

    static auditable = true

    static mapping = {
        table 'acta'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'acta__id'
            convenio column: 'cnvn__id'
            descripcion column: 'actadscr'
            nombre column: 'actanmbr'
            numero column: 'actanmro'
            tipo column: 'actatipo'
            fecha column: 'actafcha'
            fechaRegistro column: 'actafcrg'
            registrada column: 'actargst'
            espacios column: 'actaespc'

        }
    }

    static constraints = {
        convenio(nullable: false, blank: false)
        descripcion(nullable: true, blank: true)
        nombre(size:1..20,nullable: false, blank: false)
        numero(size: 1..20, nullable: true, blank: true)
        tipo(nullable: true, blank: true)
        fecha(nullable: true, blank:true)
        fechaRegistro(nullable: true, blank:true)
        registrada(nullable: true, blank:true)
        espacios(nullable: true, blank:true)
    }
}
