Feature: servicio 201A para cuenta ahorros activa


  Scenario: cuenta v10 activa
    * string stext = karate.readAsString('Data.csv')
    #* print stext
    * replace stext
      | token | value |
      | ;     | ','   |
    * csv txtjson = stext
    #* print txtjson
    * def idUno = txtjson[0].id
   # * print idUno
    * url 'http://10.160.1.90/GIROS_tst/GYFCOBOLServices/wsgyg15.asmx'
    Given request
    """
     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:jdb="http://jdbcservices.sbi.integracion.giros">
       <soapenv:Header/>
       <soapenv:Body>
            <jdb:generarRespuesta>
               <id></id>
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
    And def schemaV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn
    * json jsonv10 = schemaV10
    * string stringv10 = jsonv10.generarRespuestaReturn._
    And def responseCodeV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/responseCode
    And def msgErrorV10 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/msgError




    #And match shortName == ''
    * xmlstring stringresponse1 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn


    * url 'http://10.122.5.250:8080/WSGYG15-0.0.1-SNAPSHOT/WSGYG15'

    Given request
    """
    <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:jdb="http://jdbcservices.sbi.integracion.giros/">
   <soapenv:Header/>
   <soapenv:Body>
      <jdb:generarRespuesta>
            <id></id>
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
    And def schemaV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn
    * json jsonv12 = schemaV12
    * string stringv12 = jsonv12.generarRespuestaReturn
    And def responseCodeV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/responseCode
    And def msgErrorV12 = /Envelope/Body/generarRespuestaResponse/generarRespuestaReturn/msgError

    #And match responseCodeV12 == responseCodeV10
    And match msgErrorV12 == msgErrorV10

    #Validacion schema
    * def resultv10 = new javaValidaciones().eliminarCaracteres(stringv10)
    * def resultv12 = new javaValidaciones().eliminarCaracteres(stringv12)
    And assert resultv10 == resultv12








