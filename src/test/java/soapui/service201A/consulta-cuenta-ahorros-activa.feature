Feature: servicio 201A para cuenta ahorros activa


  Scenario: cuenta v10 activa
    * string stext = karate.readAsString('Data.csv')
  #  * print stext
    * replace stext
      | token | value |
      | ;     | ','   |
    * csv txtjson = stext
   # * print txtjson
    * def idUno = txtjson[0].id
  #  * print idUno
    * url 'http://10.160.1.90/GIROS_tst/GYFCOBOLServices/wsgyg15.asmx'
    Given request
    """
     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:jdb="http://jdbcservices.sbi.integracion.giros">
       <soapenv:Header/>
       <soapenv:Body>
            <jdb:generarRespuesta>
               <id>#(txtjson[0].idV10)</id>
               <countNumber>#(txtjson[0].countNumberV10)</countNumber>
               <ipAddress>#(txtjson[0].ipV10)</ipAddress>
            </jdb:generarRespuesta>
         </soapenv:Body>
      </soapenv:Envelope>
    """
    And header Content-Type = 'text/xml;charset=UTF-8'
    When soap action 'generarRespuesta'
    Then status 200
    And print response
    * xml responseTotalV10 = response
    #* json jsonresponsev10 = responseTotalV10
    #* print jsonresponsev10

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
    #* print stringv10
    #And match jsonv10.generarRespuestaReturn._ == read("esqueleto.json")


    # Validaciones campos v10
    And match idV10 == '#(txtjson[0].idV10)'
    And match countNumberV10 contains "00"+txtjson[0].countNumberV10
    And match ipAddressV10 == '#(txtjson[0].ipV10)'
    And match celNumberV10 != ''
    And match longNameV10 == ''
    And match shortNameV10 == ''


    #And match shortName == ''
    * xmlstring stringresponse1 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn


    * url 'http://10.122.5.250:8080/WSGYG15-0.0.1-SNAPSHOT/WSGYG15'

    Given request
    """
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:jdb="http://jdbcservices.sbi.integracion.giros/">
   <soapenv:Header/>
   <soapenv:Body>
      <jdb:generarRespuesta>
            <id>#(txtjson[0].idV12)</id>
            <tipId>#(txtjson[0].tipoIdV12)</tipId>
            <countNumber>#(txtjson[0].countNumberV12)</countNumber>
            <ipAddress>#(txtjson[0].ipV12)</ipAddress>
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
    And match jsonv12.generarRespuestaReturn contains read("esqueleto.json")



    # Validar el mismo response code
    And match responseCodeV10 == responseCodeV12



    # Valdiar que los campos de id, ip y cuenta con 2 ceros extra sean los mismos de la peticion
    And match idV12 == '#(txtjson[0].idV12)'
    And match countNumberV12 contains "00"+txtjson[0].countNumberV12
    And match ipAddressV12 == '#(txtjson[0].ipV12)'
    And match celNumberV12 != ''
    And match longNameV12 == ''
    And match shortNameV12 == ''

    #Validar formato fehca y hora
    * def javaValidaciones = Java.type('get.Validaciones')
    * def resultValidacionFecha = new javaValidaciones().validacionFecha(requestDateV12,requestDateV10);
    * def resultvalidacionHora = new javaValidaciones().validacionHora(requestHourV12,requestHourV10);
    And match resultValidacionFecha == true
    And match resultvalidacionHora == true

    #Validar Schemas
  * def resultv10 = new javaValidaciones().eliminarCaracteres(stringv10)
    * def resultv12 = new javaValidaciones().eliminarCaracteres(stringv12)
    And assert resultv10 == resultv12







