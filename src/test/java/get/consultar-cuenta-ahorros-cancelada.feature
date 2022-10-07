Feature: check a count - 201A cancelada

  Background:
    * def javaConect = Java.type('get.ConectarDB')
    * def result = new javaConect().getConn();
    * def estadoCuenta = 901
    * def tipoCuenta = 51
    * def jsonParameters = new javaConect().getParameters201A(result, estadoCuenta, tipoCuenta);
    * def jsonResponse = new javaConect().getDataCountSavingSuccessful(result, estadoCuenta, tipoCuenta);
    * def get_token = call read('obtener-token-get.feature')
    * def var_string = "Bearer " + get_token.token
    * configure headers = { 'Authorization': '#(var_string)'}


  Scenario: consultar cuenta cancelada
    Given url "http://10.160.1.90/WSGYG25REST_V12/Cuentas/validacion?id=" + jsonParameters.id + "&countNumber=" + jsonParameters.countNumber + "&ipAddress=10.160.1.90&tipId="+ jsonParameters.tipId
    When method get
    Then status 200
    * jsonResponse.requestHour = response.requestHour
    And match response == jsonResponse