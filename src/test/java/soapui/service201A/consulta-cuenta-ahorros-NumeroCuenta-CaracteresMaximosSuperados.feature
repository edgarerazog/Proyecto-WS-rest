|Feature: servicio 201A para cuenta ahorros activa


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

    #optencion de los datos de respuesta v10



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









