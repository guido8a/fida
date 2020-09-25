package utilitarios

import groovy.transform.CompileDynamic
import groovy.transform.CompileStatic
import wslite.soap.SOAPClient
import wslite.soap.SOAPResponse
import wslite.http.auth.*


class ConsultaController {

    def prueba() {
        //https://github.com/jwagenleitner/groovy-wslite
        //https://github.com/jwagenleitner/groovy-wslite/blob/master/README.md
        //otro: https://josdem.io/techtalk/spring/spring_wslite_soap/

/*        def file = new File("/tmp/file.xml")
        assert file.exists()
        String wsdl = 'https://server/servicios/soap/stamp.wsdl'

        def client = new SOAPClient(wsdl)
        def response = client.send(SOAPAction: 'stamp') {
            body {
                stamp('xmlns': 'https://server/WSDL') {
                    xml(file.bytes.encodeBase64().toString())
                    username(username)
                    password(password)
                }
            }
        }
        println response.dump()*/

        def client = new SOAPClient('http://interoperabilidad.dinardap.gob.ec:7979/interoperador?wsdl')
//        client.authorization = new HTTPBasicAuthorization("iOpaDRIeps", "6Tmq[]3ic}")
        println "...1"
        def response = client.send(
                login: "iOpaDRIeps",
                password: "6Tmq[]3ic}",
                connectTimeout:5000,
                readTimeout:20000,
                useCaches:false,
                followRedirects:false,
                sslTrustAllCerts:true) {
                    numeroIdentificacion: '1760003330001'
                    codigoPaquete: '186'
                }
        println "$response"
        render response

    }

    def prueba1() {
//        def parametros = [login: "iOpaDRIeps", password: "6Tmq[]3ic}", exceptions:true]
        def client = new SOAPClient('http://interoperabilidad.dinardap.gob.ec:7979/interoperador?wsdl')
//        client.authorization = new HTTPBasicAuthorization("iOpaDRIeps", "6Tmq[]3ic}")
        println "...1"

        def valoresBuscarSRI = [:]
        valoresBuscarSRI['login'] = 'iOpaDRIeps'
        valoresBuscarSRI['password'] = '6Tmq[]3ic}'
        valoresBuscarSRI['numeroIdentificacion'] = '1760003330001'
        valoresBuscarSRI['codigoPaquete'] = 186

        def resp = client.send("getFichaGeneral", valoresBuscarSRI);
        println "$resp"
        render resp
    }

    def prueba2() {
        def client = new SOAPClient('http://interoperabilidad.dinardap.gob.ec:7979/interoperador?wsdl')
        println "...1"

        def response = client.send(
                login: "iOpaDRIeps",
                password: "6Tmq[]3ic}",
                connectTimeout:5000,
                readTimeout:20000,
                useCaches:false,
                followRedirects:false,
                sslTrustAllCerts:true) {
            numeroIdentificacion: '1760003330001'
            codigoPaquete: '186'
        }
        println "$response"
        render response
    }

    def prueba3() {
        def client = new SOAPClient('http://interoperabilidad.dinardap.gob.ec:7979/interoperador?wsdl')
        println "...1"

        def response = client.send(
                login: "iOpaDRIeps",
                password: "6Tmq[]3ic}",
                connectTimeout:5000,
                readTimeout:20000,
                useCaches:false,
                followRedirects:false,
                sslTrustAllCerts:true,
                numeroIdentificacion: '1760003330001',
                codigoPaquete: '186')

        println "$response"
        render response
    }

    def prueba4() {
        def client = new SOAPClient('http://interoperabilidad.dinardap.gob.ec:7979/interoperador?wsdl')
        println "...1"

        def response = client.send(
                login: "iOpaDRIeps",
                password: "6Tmq[]3ic}",
                connectTimeout:5000,
                readTimeout:20000,
                numeroIdentificacion: '1760003330001',
                codigoPaquete: '186')

        println "$response"
        render response
    }

    def prueba5() {
        def client = new SOAPClient('http://interoperabilidad.dinardap.gob.ec:7979/interoperador?wsdl')
        println "...1"

        def response = client.send(
                login: "iOpaDRIeps",
                password: "6Tmq[]3ic}",
                exceptions: true,
                numeroIdentificacion: '1760003330001',
                codigoPaquete: '186')

        println "$response"
        render response
    }


    boolean httpInit() {
        println "...httpInit"

        def postRequest = null
        def baseUrl = new URL('http://interoperabilidad.dinardap.gob.ec:7979/interoperador?wsdl')
        def queryString = 'q=groovy&format=json&pretty=1'
        def connection = baseUrl.openConnection()
        println "...0"

        connection.with {
            println "...1"
            doOutput = true
            requestMethod = 'POST'
            outputStream.withWriter { writer ->
                writer << queryString
            }
            println "...2"
            response.success = { resp ->
                println "Success! ${resp.status}"
            }
            println "...3"
            response.failure = { resp ->
                println "Request failed with status ${resp.status}"
            }
//            println content.text
        }
        render"ok..."
    }

    String consultarCed(cedula) {
        String strRequest = ""
        strRequest += '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:agr="http://www.agricultura.gob.ec/">'
        strRequest += '<soap:Header/><soap:Body><agr:WBConsultaCed>'
        strRequest += '<agr:cadena>' + cedula + '</agr:cadena>'
        strRequest += '</agr:WBConsultaCed></soap:Body></soap:Envelope>'

        return ejecutar(strRequest, cedula)
    }

    String consultarRuc(ruc) {
        String strRequest = ""
        strRequest += '<soap:Envelope xmlns:soap="http://www.w3.org/2003/05/soap-envelope" xmlns:agr="http://www.agricultura.gob.ec/">'
        strRequest += '<soap:Header/><soap:Body>'
        strRequest += '<agr:WBConsultaRUC>'
        strRequest += '<agr:cadenaSRI>' + ruc + '</agr:cadenaSRI>'
        strRequest += '</agr:WBConsultaRUC></soap:Body></soap:Envelope>'

        return ejecutar(strRequest, ruc)
    }

/*
    String ejecutar(strRequest, id) {
        if(postRequest == null || httpClient == null) {
            return "CIRUC: ERROR LA SESION DE VALIDACIÓN NO HA SIDO INICIADA"
        } else {
            StringEntity input = new StringEntity(strRequest)
            input.setContentType("application/soap+xml")
            postRequest.setEntity(input)
            HttpResponse response = httpClient.execute(postRequest)
            def sc =response.getStatusLine().getStatusCode()
            def resultado = ''
            if(sc == 200) {
                resultado = response.getEntity().getContent().text
                def i = resultado.indexOf(';')
                if( i >= 0 ) {
                    resultado = resultado.substring(0,i+1) + id + resultado.substring(i)
                }
            }
            def src =  new XmlSlurper().parseText(resultado)
            resultado = "" + src.text() + ""
            sleep(24)
            return resultado
        }
    }
*/

    void httpFinish() {
        if(httpClient != null) {
            try {
                httpClient.getConnectionManager().shutdown()
            } catch (Exception e) {
                AppException('Cant close HTP Connection',e.getMessage(),'CirucJob')
            }
        }
        httpClient = null
        postRequest = null
    }

} //fin controller
