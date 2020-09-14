package convenio

import audita.Auditable


class InformeAvance implements Auditable {

    AdministradorConvenio administradorConvenio
    Desembolso desembolso
    Date fecha
    String informeAvance
    String dificultadesAvance
    int porcentaje

    static auditable = true

    static mapping = {
        table 'info'
        cache usage: 'read-write', include: 'non-lazy'
        version false
        id generator: 'identity'
        columns {
            id column: 'info__id'
            administradorConvenio column: 'adcv__id'
            desembolso column: 'dsmb__id'
            fecha column: 'infofcha'
            informeAvance column: 'infoavnc'
            dificultadesAvance column: 'infodifc'
            porcentaje column: 'infopcnt'
        }
    }

    static constraints = {
        administradorConvenio(nullable: false, blank: false)
        desembolso(nullable: false, blank: false)
        fecha(nullable: true, blank: true)
        informeAvance(nullable: false, blank:false)
        dificultadesAvance(nullable: true, blank:true)
        porcentaje(nullable: false, blank: false)
    }

}
