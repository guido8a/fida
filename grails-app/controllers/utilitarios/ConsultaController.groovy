package utilitarios

import javax.xml.soap.MessageFactory
import javax.xml.soap.MimeHeaders
import javax.xml.soap.SOAPConnection
import javax.xml.soap.SOAPConnectionFactory
import javax.xml.soap.SOAPMessage


class ConsultaController {


    def soap() {
        MessageFactory msgFactory     = MessageFactory.newInstance();
        SOAPMessage message           = msgFactory.createMessage();

        String userAndPassword = String.format("%s:%s", 'iOpaDRIeps', '6Tmq[]3ic}');
        String basicAuth = new sun.misc.BASE64Encoder().encode(userAndPassword.getBytes());

        MimeHeaders mimeHeaders = message.getMimeHeaders();
        mimeHeaders.addHeader("Authorization", "Basic " + basicAuth);

        SOAPConnectionFactory soapConnectionFactory = SOAPConnectionFactory.newInstance();
        SOAPConnection soapConnection = soapConnectionFactory.createConnection();

        String url = 'http://interoperabilidad.dinardap.gob.ec:7979/interoperador?wsdl';

        /* id: 1 Cédula, 2, RUC, 3 Organización */
        println "--> params: ${params.id}"
//        def sobre_xml = consulta(cédula o ruc, paquete)
        def sobre_xml
        switch (params.id) {
            case '1':
                sobre_xml = consulta(params.cedula, 185)
                break
            case '2':
                sobre_xml = consulta(params.ruc, 186)
                break
            case '3':
                sobre_xml = consulta(params.ruc, 1119)
                break
        }

        println sobre_xml

//        SOAPBody body = message.setSOAPBody(sobre_xml);
        SOAPMessage soapRequest = MessageFactory.newInstance().createMessage(mimeHeaders,
                new ByteArrayInputStream(sobre_xml.getBytes()));

        SOAPMessage soapResponse = soapConnection.call(soapRequest, url);

        ByteArrayOutputStream out = new ByteArrayOutputStream();
        soapResponse.writeTo(out);
        String strMsg = new String(out.toByteArray())
        println "xml: ${strMsg}"
        println "respuesta: ${parseXml(strMsg)}"
        render( parseXml(strMsg) )
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

        println("CP:  " + codigoPaquete.text())
        println("NOMBRE:  " + nombre.text())
        println("CONDICION:  " + ciudadano.text())
        println("FECHA  " + fecha.text())
        println("LUGAR  " + lugar.text())
        println("NACIONALIDAD  " + nacionalidad.text())
//        println("list " + list)

        return [nombre: nombre.text()]
    }

    String consulta(cedula, paquete) {
        println "llega: $cedula, $paquete"
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

} //fin controller
