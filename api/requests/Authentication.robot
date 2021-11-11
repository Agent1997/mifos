*** Settings ***
Library    RequestsLibrary
Variables    vars.py
*** Keywords ***
Get Token for
    [Arguments]    ${username}      ${password}
    ${headers}      create dictionary  Content-Type=application/json      Fineract-Platform-TenantId=default
    ${params}       create dictionary    username=${username}       password=${password}
    ${res}    POST       ${BASEURL}/api/v1/authentication      headers=${headers}    params=${params}   expected_status=200
    ${token}   evaluate    $res.json().get('base64EncodedAuthenticationKey')
    [Return]    ${token}
