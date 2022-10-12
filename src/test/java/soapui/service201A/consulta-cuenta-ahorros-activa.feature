Feature: servicio 201A para cuenta ahorros activa

  Background:
  * url 'http://10.160.1.90/GIROS_tst/GYFCOBOLServices/wsgyg15.asmx'

  Scenario: cuenta v10 activa
    Given request
    """
     <soapenv:Envelope xmlns:soapenv="http://schemas.xmlsoap.org/soap/envelope/" xmlns:jdb="http://jdbcservices.sbi.integracion.giros">
       <soapenv:Header/>
       <soapenv:Body>
            <jdb:generarRespuesta>
               <id>8600379004</id>
               <countNumber>01735600000111354</countNumber>
               <ipAddress>10.160.1.90</ipAddress>
            </jdb:generarRespuesta>
         </soapenv:Body>
      </soapenv:Envelope>
    """
    And header Content-Type = 'text/xml;charset=UTF-8'
    When soap action 'generarRespuesta'
    Then status 200
    And def responseV10 = response

    Given
