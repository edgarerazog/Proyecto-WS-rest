Feature: servicio 201A para cuenta ahorros activa


  Scenario: cuenta v10 activa
    * string stext = karate.readAsString('Data.csv')
    * print stext
    * replace stext
      | token | value |
      | ;     | ','   |
    * csv txtjson = stext
    * print txtjson
    * def idUno = txtjson[0].id
    * print idUno
    * url 'http://10.160.1.90/GIROS_tst/GYFCOBOLServices/wsgyg15.asmx'
    Given request
    """
     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:jdb="http://jdbcservices.sbi.integracion.giros">
       <soapenv:Header/>
       <soapenv:Body>
            <jdb:generarRespuesta>
               <id>8600379004</id>
               <countNumber>Casa1</countNumber>
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


    #And match shortName == ''
    * xmlstring stringresponse1 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn


    * url 'http://10.122.5.250:8080/WSGYG15-0.0.1-SNAPSHOT/WSGYG15'

    Given request
    """
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:jdb="http://jdbcservices.sbi.integracion.giros/">
   <soapenv:Header/>
   <soapenv:Body>
      <jdb:generarRespuesta>
            <id>#(txtjson[1].idV12)</id>
            <tipId>#(txtjson[1].tipoIdV12)</tipId>
            <countNumber>Casa1</countNumber>
            <ipAddress>#(txtjson[1].ipV12)</ipAddress>
      </jdb:generarRespuesta>
   </soapenv:Body>
</soapenv:Envelope>
    """
    And header Content-Type = 'text/xml;charset=UTF-8'
    When method POST
    Then status 200
    And print response

    #Se guarda la misma ruta de v10 si existe
    * xmlstring stringresponse2 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn


     # Validar la existencia de los campos
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

    # Validar el mismo Codigo de error
    * def javaValidaciones = Java.type('get.Validaciones')
    * def resultValidacionMismoError = new javaValidaciones().validacionErrores(msgErrorV12,msgErrorV10);
    And match resultValidacionMismoError == true



    # Validar campos vacios














