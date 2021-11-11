*** Settings ***
Library    RequestsLibrary
Library    String
Variables    ../vars.py
Resource    ../Authentication.robot

*** Variables ***
${CreateClient_request_body_tpl}    {"officeId":%officeId%,"firstname":"%firstname%","lastname":"%lastname%","active":false,"dateFormat":"dd MMMM yyyy"}

*** Keywords ***
create an inactive client
    [Arguments]    ${office_id}     ${first_name}      ${last_name}    ${token}
    ${headers}      create dictionary  Content-Type=application/json      Fineract-Platform-TenantId=default
    ...             Authorization=Basic ${token}
    ${body}         String.replace string       ${CreateClient_request_body_tpl}    %officeId%    ${office_id}
    ${body}         String.replace string       ${body}     %firstname%    ${first_name}
    ${body}         String.replace string       ${body}     %lastname%    ${last_name}
    ${res}          POST     ${BASEURL}/api/v1/clients     headers=${headers}      data=${body}     expected_status=200
    [Return]         ${res}


client id from ${res}
    ${id}  evaluate    $res.json().get('clientId')
    [Return]      ${id}

resource id from ${res}
    ${id}  evaluate    $res.json().get('resourceId')
    [Return]      ${id}

office id from ${res}
    ${id}  evaluate    $res.json().get('officeId')
    [Return]      ${id}



