*** Settings ***
Library    SeleniumLibrary
Library    Dialogs
Resource    ../Actions.robot

*** Variables ***
${LoginPO_url}            https://test.qe-360.com:8443/community-app/#/tasks
${LoginPO_username}             uid
${LoginPO_password}             pwd
${LoginPO_submit}               login-button

*** Keywords ***
load page
    Actions.launch browser    ${LoginPO_url}       chrome

login as
    [Arguments]     ${username}     ${password}
    Actions.force input text using javascript   ${LoginPO_username}     ${username}
    Actions.force input text using javascript   ${LoginPO_password}      ${password}
    Actions.force click element using javascript    ${LoginPO_submit}



