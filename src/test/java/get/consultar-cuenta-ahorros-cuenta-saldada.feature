Feature: check a count - 201A saldada

  Background:
    * def get_token = call read('obtener-token-get.feature')
    * def var_string = "Bearer " + get_token.token
    * configure headers = { 'Authorization': '#(var_string)'}
    * def javaConect = Java.type('get.ConectarDBV12')
    * def result = new javaConect().getConn();
    * def estadoCuenta = 902
    * def tipoCuenta = 51
    * def jsonParameters = new javaConect().getParameters201A(result, estadoCuenta, tipoCuenta);
    * def jsonResponse = new javaConect().getDataCountSavingSuccessful(result, estadoCuenta, tipoCuenta);


  Scenario: consultar cuenta saldada
    Given url "http://10.160.1.90/WSGYG25REST_V12/Cuentas/validacion?id=" + jsonParameters.id + "&countNumber=" + jsonParameters.countNumber + "&ipAddress=10.160.1.90&tipId="+ jsonParameters.tipId
    When method get
    Then status 200
    * jsonResponse.requestHour = response.requestHour
    And match response == jsonResponse


