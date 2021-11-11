*** Settings ***
Library    RequestsLibrary
Library    JSONLibrary
Variables    ../vars.py
Resource    ../Authentication.robot

*** Keywords ***
list clients
    [Arguments]    ${token}
    ${headers}      create dictionary  Content-Type=application/json      Fineract-Platform-TenantId=default
    ...             Authorization=Basic ${token}
    ${res}          GET     ${BASEURL}/api/v1/clients     headers=${headers}      expected_status=200
    [Return]       ${res}

get all resource ids for ${res}
     ${res}     evaluate    $res.json()
      @{ids}         get value from json    ${res}    $.pageItems[*].id
      [Return]      @{ids}

get first name of client with id of ${id} from ${res}
      ${res}     evaluate    $res.json()
      ${val}         get value from json    ${res}    $.pageItems[?(@.id==${id})].firstname
      [Return]    ${val}[0]

get last name of client with id of ${id} from ${res}
      ${res}     evaluate    $res.json()
      ${val}         get value from json    ${res}    $.pageItems[?(@.id==${id})].lastname
      [Return]    ${val}[0]




