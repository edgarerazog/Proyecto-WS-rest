Feature: servicio 201A para cuenta ahorros cancelada


  Scenario: cuenta v10 cancelada
    * string stext = karate.readAsString('Data.csv')
    #* print stext
    * replace stext
      | token | value |
      | ;     | ','   |
    * csv txtjson = stext
    #* print txtjson
    * def idUno = txtjson[0].id
    #* print idUno
    * url 'http://10.160.1.90/GIROS_tst/GYFCOBOLServices/wsgyg15.asmx'
    * def javaConectV10 = Java.type('get.ConectarDBV10')
    * def javaConectV12 = Java.type('get.ConectarDBV12')
    * def result = new javaConectV10().getConn();
    * def resultV12 = new javaConectV12().getConnV12();
    * def estadoCuenta = 901
    * def jsonCuentaCanceladaV10 = new javaConectV10().getParameters201AV10(result, estadoCuenta);
    * def jsonCuentaCanceladaV12 = new javaConectV12().getParameters201AV12(resultV12, estadoCuenta);

    Given request
    """
     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:jdb="http://jdbcservices.sbi.integracion.giros">
       <soapenv:Header/>
       <soapenv:Body>
            <jdb:generarRespuesta>
               <id>#(jsonCuentaCanceladaV10.id)</id>
               <countNumber>#(jsonCuentaCanceladaV10.countNumber)</countNumber>
               <ipAddress>10.160.1.90</ipAddress>
            </jdb:generarRespuesta>
         </soapenv:Body>
      </soapenv:Envelope>
    """
    And header Content-Type = 'text/xml;charset=UTF-8'
    When soap action 'generarRespuesta'
    Then status 200
    And print response
    * xml responseTotalV10 = response

    #optencion de los datos de respuesta v10
    And def responseCodeV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/responseCode
    And def msgErrorV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/msgError
    And def idV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/id
    And def countNumberV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/countNumber
    And def celNumberV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/celNumber
    And def shortNameV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/shortName
    And def longNameV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/longName
    And def requestDateV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/requestDate
    And def requestHourV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/requestHour
    And def ipAddressV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/ipAddress
    And def schemaV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn
    * json jsonv10 = schemaV10
    * string stringv10 = jsonv10.generarRespuestaReturn._
    #And match jsonv10.generarRespuestaReturn._ contains read("esqueleto.json")


    #And match shortName == ''
    And match idV10 == jsonCuentaCanceladaV10.id
    And match countNumberV10 contains "00"+jsonCuentaCanceladaV10.countNumber
    And match ipAddressV10 == '10.160.1.90'
    And match celNumberV10 == ''
    And match longNameV10 == ''
    And match shortNameV10 == ''

    * xmlstring stringresponse1 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn



    * url 'http://10.122.5.250:8080/WSGYG15-0.0.1-SNAPSHOT/WSGYG15'

    Given request
    """
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:jdb="http://jdbcservices.sbi.integracion.giros/">
   <soapenv:Header/>
   <soapenv:Body>
      <jdb:generarRespuesta>
            <id>#(jsonCuentaCanceladaV12.id)</id>
            <tipId>#(jsonCuentaCanceladaV12.tipId)</tipId>
            <countNumber>#(jsonCuentaCanceladaV12.countNumber)</countNumber>
            <ipAddress>10.160.1.90</ipAddress>
      </jdb:generarRespuesta>
   </soapenv:Body>
</soapenv:Envelope>
    """
    And header Content-Type = 'text/xml;charset=UTF-8'
    When method POST
    Then status 200
    And print response
    * xmlstring stringresponse2 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn

    #And match stringresponse2 contains 'celNumber'
    And match stringresponse2 contains 'responseCode'
    And match stringresponse1 contains 'responseCode'
    And match stringresponse2 contains 'msgError'
    And match stringresponse1 contains 'msgError'
    And match stringresponse2 contains 'id'
    And match stringresponse1 contains 'id'
    And match stringresponse2 contains 'countNumber'
    And match stringresponse1 contains 'countNumber'
    And match stringresponse2 contains 'celNumber'
    And match stringresponse1 contains 'celNumber'
    And match stringresponse2 contains 'shortName'
    And match stringresponse1 contains 'shortName'
    And match stringresponse2 contains 'longName'
    And match stringresponse1 contains 'longName'
    And match stringresponse2 contains 'requestDate'
    And match stringresponse1 contains 'requestDate'
    And match stringresponse2 contains 'requestHour'
    And match stringresponse1 contains 'requestHour'
    And match stringresponse2 contains 'ipAddress'
    And match stringresponse1 contains 'ipAddress'

    #Optencion de los datos de respuesta v12
    And def responseCodeV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/responseCode
    And def msgErrorV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/msgError
    And def idV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/id
    And def countNumberV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/countNumber
    And def celNumberV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/celNumber
    And def shortNameV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/shortName
    And def longNameV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/longName
    And def requestDateV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/requestDate
    And def requestHourV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/requestHour
    And def ipAddressV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/ipAddress
    And def schemaV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn
    * json jsonv12 = schemaV12
    * string stringv12 = jsonv12.generarRespuestaReturn
    #And match jsonv12.generarRespuestaReturn contains read("esqueleto.json")

    #And match stringresponse1 contains stringresponse2

    # Validar el mismo response code
    And match responseCodeV10 == responseCodeV12

    # Validar la existencia de los campos


    # Valdiar que los campos de id, ip y cuenta con 2 ceros extra sean los mismos de la peticion
    And match idV12 == '#(jsonCuentaCanceladaV12.id)'
    And match countNumberV12 contains "00"+jsonCuentaCanceladaV12.countNumber
    And match ipAddressV12 == '#(txtjson[0].ipV12)'
    And match celNumberV12 == ''
    And match longNameV12 == ''
    And match shortNameV12 == ''

    #Validar formato fehca y hora
    * def javaValidaciones = Java.type('get.Validaciones')
    * def resultValidacionFecha = new javaValidaciones().validacionFecha(requestDateV12,requestDateV10);
    * def resultvalidacionHora = new javaValidaciones().validacionHora(requestHourV12,requestHourV10);
    And match resultValidacionFecha == true
    And match resultvalidacionHora == true

#Validar Schema
    * def resultv10 = new javaValidaciones().eliminarCaracteres(stringv10)
    * def resultv12 = new javaValidaciones().eliminarCaracteres(stringv12)
    And assert resultv10 == resultv12







