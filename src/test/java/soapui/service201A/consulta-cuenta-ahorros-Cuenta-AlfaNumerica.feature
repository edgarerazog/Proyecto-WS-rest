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


    #Optencion de los datos de respuesta v12















