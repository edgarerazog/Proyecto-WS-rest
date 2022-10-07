Feature: create transaction


  Background:
    * def get_data = call read('../get/consultar-cuenta-get.feature')
    * def var_string = "Bearer " + get_data.token
    * configure headers = { 'Authorization': '#(var_string)'}

  Scenario: create a transaction
    Given url "http://10.160.1.90/WSGYG05REST_V12/Cuentas/transacciones"
    And request { "numerodeTransaccion": "73", "numeroCuentaCorriente": "01735600000111154", "valor": "100", "nut": "1132951", "codigoAgencia": "1", "requestCliente": "IAV", "codigoRed": "", "codigoPais": "", "codigoTransaccion": "", "estadoTransaccion": "", "NUEVAINVERSION": "1" }
    When
    Then

