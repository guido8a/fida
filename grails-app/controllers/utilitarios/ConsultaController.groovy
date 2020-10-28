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


    def parseXmlRuc(text){

//
//        def text = '''
//<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
//<soap:Body>
//<ns2:getFichaGeneralResponse xmlns:ns2="http://servicio.interoperadorws.interoperacion.dinardap.gob.ec/">
//<return>
//<codigoPaquete>186</codigoPaquete>
//<instituciones>
//<datosPrincipales>
//<registros>
//<campo>personaSociedad</campo>
//<codigo>115</codigo>
//<valor>SCD</valor>
//</registros>
//<registros>
//<campo>razonSocial</campo>
//<codigo>116</codigo>
//<valor>TEDEIN S.A.</valor>
//</registros>
//<registros>
//<campo>actividadEconomicaPrincipal</campo>
//<codigo>124</codigo>
//<valor>VENTA AL POR MENOR DE PROGRAMAS INFORMATICOS NO PERSONALIZADOS, EN ESTABLECIMIENTOS ESPECIALIZADOS.</valor>
//</registros>
//<registros>
//<campo>estadoSociedad</campo>
//<codigo>126</codigo>
//<valor>ACT</valor>
//</registros>
//<registros>
//<campo>tipoContribuyente</campo>
//<codigo>127</codigo>
//<valor>COMPAÑIAS ANONIMAS</valor>
//</registros>
//<registros>
//<campo>DESCRIPCION UBICACION GEAOGRAFICA</campo>
//<codigo>1073</codigo>
//<valor>\\ COSTA\\ GUAYAS</valor>
//</registros>
//</datosPrincipales>
//<detalle>
//<items>
//<nombre>SRI Establecimiento</nombre>
//<registros>
//<campo>numeroEstableciminiento</campo>
//<codigo>130</codigo>
//<valor>1</valor>
//</registros>
//<registros>
//<campo>nombreFantasiaComercial</campo>
//<codigo>131</codigo>
//<valor></valor>
//</registros>
//<registros>
//<campo>estadoEstablecimiento</campo>
//<codigo>132</codigo>
//<valor>ABIERTO</valor>
//</registros>
//<registros>
//<campo>calle</campo>
//<codigo>133</codigo>
//<valor>TUNGURAHUA</valor>
//</registros>
//<registros>
//<campo>interseccion</campo>
//<codigo>134</codigo>
//<valor>HURTADO</valor>
//</registros>
//<registros>
//<campo>numero</campo>
//<codigo>135</codigo>
//<valor>600</valor>
//</registros>
//</items>
//<items>
//<nombre>REPRESENTANTE LEGAL</nombre>
//<registros>
//<campo>REPRESENTANTE LEGAL::IDENTIFICACION</campo>
//<codigo>1106</codigo>
//<valor>0601983869</valor>
//</registros><registros>
//<campo>REPRESENTANTE LEGAL::NOMBRE</campo>
//<codigo>1107</codigo>
//<valor>OCHOA MORENO GUIDO EDUARDO</valor>
//</registros>
//</items>
//</detalle>
//<nombre>SRI</nombre>
//</instituciones>
//</return>
//</ns2:getFichaGeneralResponse></soap:Body></soap:Envelope>
//        '''
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

        println("CP:  " + codigoPaquete.text())
        println("PERSONA SOCIEDAD:  " + personaSociedad.text())
        println("RAZON SOCIAL:  " + razonSocial.text())
        println("ACTIVIDAD ECONOMICA:  " + actividadEconomicaPrincipal.text())
        println("ESTADO SOCIEDAD:  " + estadoSociedad.text())
        println("TIPO DE CONTRIBUYENTE:  " + tipoContribuyente.text())
        println("UBICACION:  " + ubicacion.text())
        println("NUMERO ESTABLECIMIENTO:  " + numeroEstableciminiento.text())
        println("FANTASIA COMERCIAL:  " + nombreFantasiaComercial.text())
        println("ESTADO ESTABLECIMIENTO:  " + estadoEstablecimiento.text())
        println("CALLE:  " + calle.text())
        println("INTERSECCION:  " + interseccion.text())
        println("NUMERO:  " + numero.text())
        println("REPRESENTANTE LEGAL IDENTIFICACION:  " + representanteLegalId.text())
        println("REPRESENTANTE LEGAL NOMBRE:  " + representanteLegalNombre.text())

    }


    def parseXmlOrganizacion(text) {

//        def text = '''
//
//<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
//<soap:Body>
//<ns2:getFichaGeneralResponse xmlns:ns2="http://servicio.interoperadorws.interoperacion.dinardap.gob.ec/">
//<return>
//<codigoPaquete>1119</codigoPaquete>
//<instituciones>
//<datosPrincipales>
//<registros>
//<campo>calle</campo>
//<codigo>930</codigo>
//<valor>QUINTA</valor>
//</registros>
//<registros>
//<campo>canton</campo>
//<codigo>931</codigo>
//<valor>ESMERALDAS</valor>
//</registros>
//<registros>
//<campo>cedulaRepresentante</campo>
//<codigo>932</codigo>
//<valor>0800822207</valor>
//</registros>
//<registros>
//<campo>claseOrganizacion</campo>
//<codigo>934</codigo>
//<valor>TEXTIL</valor>
//</registros>
//<registros>
//<campo>correoOrganizacion</campo>
//<codigo>937</codigo>
//<valor>perlatex_2014@hotmail.com</valor>
//</registros>
//<registros>
//<campo>estadoOrganizacion</campo>
//<codigo>939</codigo>
//<valor>ACTIVA</valor>
//</registros>
//<registros>
//<campo>fechaRegistroSeps</campo>
//<codigo>940</codigo>
//<valor>2014-05-19T00:00:00-05:00</valor>
//</registros>
//<registros>
//<campo>grupoOrganizacion</campo>
//<codigo>941</codigo>
//<valor>PRODUCCION</valor>
//</registros>
//<registros>
//<campo>interseccion</campo>
//<codigo>942</codigo>
//<valor>OCTAVA</valor>
//</registros>
//<registros>
//<campo>nombreRepresentanteLegal</campo>
//<codigo>943</codigo>
//<valor>ORTIZ ARIAS ANGEL ROSENDO</valor>
//</registros>
//<registros>
//<campo>numero</campo>
//<codigo>945</codigo>
//<valor>S/N</valor>
//</registros>
//<registros>
//<campo>numeroResolucionSeps</campo>
//<codigo>946</codigo>
//<valor>SEPS-ROEPS-2014-900322</valor>
//</registros>
//<registros>
//<campo>parroquia</campo>
//<codigo>947</codigo>
//<valor>SIMÓN PLATA TORRES</valor>
//</registros>
//<registros>
//<campo>provincia</campo>
//<codigo>948</codigo>
//<valor>ESMERALDAS</valor>
//</registros>
//<registros>
//<campo>razonSocial</campo>
//<codigo>949</codigo>
//<valor>ASOCIACION DE CONFECCIONISTAS TEXTILES PERLATEX ASOPERLAT</valor>
//</registros>
//<registros>
//<campo>ruc</campo>
//<codigo>951</codigo>
//<valor>0891744609001</valor>
//</registros>
//<registros>
//<campo>telefono</campo>
//<codigo>952</codigo>
//<valor>022156123</valor>
//</registros>
//<registros>
//<campo>tipoOrganizacion</campo>
//<codigo>953</codigo>
//<valor>ASOCIACION</valor>
//</registros>
//</datosPrincipales>
//<nombre>Superintendencia de Economía Popular y Solidaria</nombre>
//</instituciones>
//</return>
//</ns2:getFichaGeneralResponse>
//</soap:Body>
//</soap:Envelope>
//
//        '''
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
