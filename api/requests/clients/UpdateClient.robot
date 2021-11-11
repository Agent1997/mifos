*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Variables    ../vars.py
Resource    ../Authentication.robot

*** Keywords ***
update client
    [Arguments]     ${id}   ${body}   ${token}
    ${headers}      create dictionary  Content-Type=application/json      Fineract-Platform-TenantId=default
    ...             Authorization=Basic ${token}

    ${res}          put    ${BASEURL}/api/v1/clients/${id}      headers=${headers}      data=${body}    expected_status=200


update deleted client
    [Arguments]     ${id}   ${body}   ${token}
    ${headers}      create dictionary  Content-Type=application/json      Fineract-Platform-TenantId=default
    ...             Authorization=Basic ${token}

    ${res}          put    ${BASEURL}/api/v1/clients/${id}      headers=${headers}      data=${body}    expected_status=404
    [Return]    ${res}

get error message from ${res}
    ${val}      evaluate    $res.json().get('developerMessage')
    [Return]    ${val}