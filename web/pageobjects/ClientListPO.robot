*** Settings ***
Library    SeleniumLibrary

*** Variables ***
${ClientListPO_page_identifier}     xpath://h4[normalize-space()='List of Clients']

*** Keywords ***
user should be at view at the client list page
    run keyword and continue on failure    wait until element is visible    ${ClientListPO_page_identifier}
    element should be visible    ${ClientListPO_page_identifier}
