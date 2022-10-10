Feature: create transaction


  Scenario Outline: create a transaction
    * def get_data = call read('<rutas>')
    * def var_string = get_data.token
    * def var_numeroCuenta = get_data.countNumber
    * def numeroCuenta = var_numeroCuenta.substring(2)
    * configure headers = { 'Authorization': '#(var_string)'}
    Given url "http://10.160.1.90/WSGYG05REST_V12/Cuentas/transacciones"
    And request { "numerodeTransaccion": "73", "numeroCuentaCorriente": "#(numeroCuenta)", "valor": "100", "nut": "40213162000000361", "codigoAgencia": "274", "requestCliente": "IAV", "codigoRed": "", "codigoPais": "", "codigoTransaccion": "", "estadoTransaccion": "", "NUEVAINVERSION": "" }
    When method post
    Then status 200
    And print response
    Examples:
      | rutas                                              |
      | ../get/consultar-cuenta-ahorros-activa-get.feature |
      | ../get/consultar-cuenta-ahorros-cancelada.feature  |
