package utilitarios

import audita.Auditable

class Parametros implements Auditable {
    static auditable = true

    String imagenes
    String institucion

    static mapping = {
        table 'prmt'
        cache usage: 'read-write', include: 'non-lazy'
        id column: 'prmt__id'
        id generator: 'identity'
        version false
        columns {
            imagenes column: 'prmtimgn'
            institucion column: 'prmtinst'
        }
    }
    static constraints = {
        imagenes(blank: true, nullable: true, attributes: [title: 'Imagen'])
        institucion(blank: false, nullable: false, attributes: [title: 'Nombre de la Institución'])
    }

    def getInicioJornada() {
        return this.horaInicio.toString().padLeft(2, '0') + ":" + this.minutoInicio.toString().padLeft(2, '0')
    }

    def getFinJornada() {
        return this.horaFin.toString().padLeft(2, '0') + ":" + this.minutoFin.toString().padLeft(2, '0')
    }
}
