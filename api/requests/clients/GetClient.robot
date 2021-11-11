*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Variables    ../vars.py
Resource    ../Authentication.robot

*** Keywords ***
get client
    [Arguments]    ${id}        ${token}
    ${headers}      create dictionary  Content-Type=application/json      Fineract-Platform-TenantId=default
    ...             Authorization=Basic ${token}
    ${res}          GET     ${BASEURL}/api/v1/clients/${id}    headers=${headers}      expected_status=200
    [Return]       ${res}

get first name from ${res}
    ${val}          evaluate    $res.json().get('firstname')
    [Return]        ${val}

get last name from ${res}
    ${val}          evaluate    $res.json().get('lastname')
    [Return]        ${val}

get office id from ${res}
    ${val}          evaluate    $res.json().get('officeId')
    ${val}          convert to string    ${val}
    [Return]        ${val}