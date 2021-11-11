*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Variables    ../vars.py
Resource    ../Authentication.robot

*** Keywords ***
delete client
    [Arguments]     ${id}   ${token}
    ${headers}      create dictionary  Content-Type=application/json      Fineract-Platform-TenantId=default
    ...             Authorization=Basic ${token}
    ${res}          delete   ${BASEURL}/api/v1/clients/${id}      headers=${headers}       expected_status=200