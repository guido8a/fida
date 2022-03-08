package utilitarios

import javax.xml.soap.MessageFactory
import javax.xml.soap.MimeHeaders
import javax.xml.soap.SOAPConnection
import javax.xml.soap.SOAPConnectionFactory
import javax.xml.soap.SOAPMessage

class ConsultaService {

    def soap(id, cedula, ruc) {
        MessageFactory msgFactory     = MessageFactory.newInstance();
        SOAPMessage message           = msgFactory.createMessage();

        String userAndPassword = String.format("%s:%s", 'iOpaDRIeps', '6Tmq[]3ic}');
        String basicAuth = new sun.misc.BASE64Encoder().encode(userAndPassword.getBytes());

        MimeHeaders mimeHeaders = message.getMimeHeaders();
        mimeHeaders.addHeader("Authorization", "Basic " + basicAuth);

        System.setProperty("java.net.useSystemProxies", "true");  //proxy
        println ".... proxy....."

        SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
        SOAPConnection soapConnection = soapConnectionFactory.createConnection();

        String url = 'http://interoperabilidad.dinardap.gob.ec:7979/interoperador?wsdl';

        /* id: 1 Cédula, 2, RUC, 3 Organización */
//        def sobre_xml = consulta(cédula o ruc, paquete)
        def sobre_xml
        switch (id) {
            case '1':
                sobre_xml = consulta(cedula, 185)
                break
            case '2':
                sobre_xml = consultaRuc(ruc) //186
                break
            case '3':
                sobre_xml = consultaSeps(ruc)  //1119
                break
        }

//        println sobre_xml

//        SOAPBody body = message.setSOAPBody(sobre_xml);
        SOAPMessage soapRequest = MessageFactory.newInstance().createMessage(mimeHeaders,
                new ByteArrayInputStream(sobre_xml.getBytes()));

        SOAPMessage soapResponse = soapConnection.call(soapRequest, url);

        ByteArrayOutputStream out = new ByteArrayOutputStream();
        soapResponse.writeTo(out);
        String strMsg = new String(out.toByteArray())
//        println "xml: ${strMsg}"

        switch (id) {
            case '1':
//                println "respuesta: ${parseXml(strMsg)}"
                return parseXml(strMsg)
                break
            case '2':
//                println "respuesta: ${parseXmlRuc(strMsg)}"
                return parseXmlRuc(strMsg)
                break
            case '3':
                println "respuesta: ${parseXmlOrganizacion(strMsg)}"
                render(  "razón social: " + parseXmlOrganizacion(strMsg)."RAZON SOCIAL" )
                break
        }

//        println "respuesta: ${parseXml(strMsg)}"
    }


    def parseXml(texto) {
        def list = new XmlParser().parseText(texto)
        def response = new XmlSlurper().parseText(texto)
        def codigoPaquete = response.Body.getFichaGeneralResponse.return.codigoPaquete
        def nombre = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[0].valor
        def ciudadano = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[1].valor
        def fecha = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[2].valor
        def lugar = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[3].valor
        def nacionalidad = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[4].valor

        return ["persona":  nombre.text(), "fcna": fecha.text(),
                "lugar": lugar.text(), "nacionalidad": nacionalidad.text()]
    }


    def parseXmlRuc(text){
        def response = new XmlSlurper().parseText(text)
        def codigoPaquete = response.Body.getFichaGeneralResponse.return.codigoPaquete
        def personaSociedad = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[0].valor
        def razonSocial = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[1].valor
        def actividadEconomicaPrincipal = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[2].valor
        def estadoSociedad = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[3].valor
        def tipoContribuyente = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[4].valor
        def ubicacion = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[5].valor
        def numeroEstableciminiento = response.Body.getFichaGeneralResponse.return.instituciones.detalle.items[0].registros[0].valor
        def nombreFantasiaComercial = response.Body.getFichaGeneralResponse.return.instituciones.detalle.items[0].registros[1].valor
        def estadoEstablecimiento = response.Body.getFichaGeneralResponse.return.instituciones.detalle.items[0].registros[2].valor
        def calle = response.Body.getFichaGeneralResponse.return.instituciones.detalle.items[0].registros[3].valor
        def interseccion = response.Body.getFichaGeneralResponse.return.instituciones.detalle.items[0].registros[4].valor
        def numero = response.Body.getFichaGeneralResponse.return.instituciones.detalle.items[0].registros[5].valor
        def representanteLegalId = response.Body.getFichaGeneralResponse.return.instituciones.detalle.items[1].registros[0].valor
        def representanteLegalNombre = response.Body.getFichaGeneralResponse.return.instituciones.detalle.items[1].registros[1].valor

        return ["persona": personaSociedad.text(), "nombre": razonSocial.text(),
                "actividad": actividadEconomicaPrincipal.text(), lugar: ubicacion.text()]

//        println("CP:  " + codigoPaquete.text())
//        println("PERSONA SOCIEDAD:  " + personaSociedad.text())
//        println("RAZON SOCIAL:  " + razonSocial.text())
//        println("ACTIVIDAD ECONOMICA:  " + actividadEconomicaPrincipal.text())
//        println("ESTADO SOCIEDAD:  " + estadoSociedad.text())
//        println("TIPO DE CONTRIBUYENTE:  " + tipoContribuyente.text())
//        println("UBICACION:  " + ubicacion.text())
//        println("NUMERO ESTABLECIMIENTO:  " + numeroEstableciminiento.text())
//        println("FANTASIA COMERCIAL:  " + nombreFantasiaComercial.text())
//        println("ESTADO ESTABLECIMIENTO:  " + estadoEstablecimiento.text())
//        println("CALLE:  " + calle.text())
//        println("INTERSECCION:  " + interseccion.text())
//        println("NUMERO:  " + numero.text())
//        println("REPRESENTANTE LEGAL IDENTIFICACION:  " + representanteLegalId.text())
//        println("REPRESENTANTE LEGAL NOMBRE:  " + representanteLegalNombre.text())

    }


    def parseXmlOrganizacion(text) {

        def response = new XmlSlurper().parseText(text)
        def codigoPaquete = response.Body.getFichaGeneralResponse.return.codigoPaquete
        def calle = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[0].valor
        def canton = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[1].valor
        def cedulaRepresentante = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[2].valor
        def claseOrganizacion = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[3].valor
        def correoOrganizacion = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[4].valor
        def estadoOrganizacion = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[5].valor
        def fechaRegistroSeps = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[6].valor
        def grupoOrganizacion = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[7].valor
        def interseccion = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[8].valor
        def nombreRepresentanteLegal = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[9].valor
        def numero = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[10].valor
        def numeroResolucionSeps = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[11].valor
        def parroquia = response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[12].valor
        def provincia= response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[13].valor
        def razonSocial= response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[14].valor
        def ruc= response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[15].valor
        def telefono= response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[16].valor
        def tipoOrganizacion= response.Body.getFichaGeneralResponse.return.instituciones.datosPrincipales.registros[17].valor

        return ["CP": codigoPaquete.text(), "RAZON SOCIAL": razonSocial.text(), "TIPO": tipoOrganizacion.text()]

        println("CP:  " + codigoPaquete.text())
        println("CALLE:  " + calle.text())
        println("CANTON:  " + canton.text())
        println("CEDULA REPRESENTANTE:  " + cedulaRepresentante.text())
        println("CLASE:  " + claseOrganizacion.text())
        println("CORREO:  " + correoOrganizacion.text())
        println("ESTADO:  " + estadoOrganizacion.text())
        println("FECHA REGISTRO SEPS:  " + fechaRegistroSeps.text())
        println("GRUPO:  " + grupoOrganizacion.text())
        println("INTERSECCION:  " + interseccion.text())
        println("REPRESENTANTE LEGAL NOMBRE:  " + nombreRepresentanteLegal.text())
        println("NUMERO:  " + numero.text())
        println("NUMERO RESOLUCION SEPS:  " + numeroResolucionSeps.text())
        println("PARROQUIA:  " + parroquia.text())
        println("PROVINCIA:  " + provincia.text())
        println("RAZON SOCIAL:  " + razonSocial.text())
        println("RUC:  " + ruc.text())
        println("TELEFONO:  " + telefono.text())
        println("TIPO:  " + tipoOrganizacion.text())

    }


    String consulta(cedula, paquete) {
//        println "llega: $cedula, $paquete"
        def sobre_xml = """<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
              xmlns:ser="http://servicio.interoperadorws.interoperacion.dinardap.gob.ec/">
                <soapenv:Header/>
                <soapenv:Body>
                <ser:getFichaGeneral>
                <codigoPaquete>${paquete}</codigoPaquete>
                <numeroIdentificacion>${cedula}</numeroIdentificacion>
                </ser:getFichaGeneral>
                </soapenv:Body>
              </soapenv:Envelope>"""

        return sobre_xml
    }

    String consultaRuc(ruc) {
        def sobre_xml = """<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
              xmlns:ser="http://servicio.interoperadorws.interoperacion.dinardap.gob.ec/">
                <soapenv:Header/>
                <soapenv:Body>
                <ser:getFichaGeneral>
                <codigoPaquete>186</codigoPaquete>
                <numeroIdentificacion>${ruc}</numeroIdentificacion>
                </ser:getFichaGeneral>
                </soapenv:Body>
              </soapenv:Envelope>"""

        return sobre_xml
    }

    String consultaSeps(ruc) {
        def sobre_xml = """<soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" 
              xmlns:ser="http://servicio.interoperadorws.interoperacion.dinardap.gob.ec/">
                <soapenv:Header/>
                <soapenv:Body>
                <ser:getFichaGeneral>
                <codigoPaquete>1119</codigoPaquete>
                <numeroIdentificacion>${ruc}</numeroIdentificacion>
                </ser:getFichaGeneral>
                </soapenv:Body>
              </soapenv:Envelope>"""

        return sobre_xml
    }

}
