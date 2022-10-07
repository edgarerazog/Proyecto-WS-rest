Feature: Get a token access

  Background:
    * configure headers = { 'UserName': 'WSGYG2',  'Password': 'GYF2'}

  Scenario: Get a token
    Given url "http://10.160.1.90/WSjwtgyf/Seguridad/Autenticacion"
    And request { "codTraExterno": "EGI", "nutOrigen": "", "valorEfectivo": 10000, "codMoneda": "0", "tipoIdentificacion": "1", "numIdentificacion": "1908936940", "fechaAplicacion": "20221005", "horaAplicacion": "045020", "agencia": "202", "codCajero": "1", "usuario": "1014251054" }
    When method post
    Then status 200
    And def token = response.acces_token