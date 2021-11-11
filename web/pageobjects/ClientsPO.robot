*** Settings ***
Library    SeleniumLibrary
Resource    ../Actions.robot

*** Variables ***
${Clients_url}            https://test.qe-360.com:8443/community-app/#/createclient
${Clients_tab}            xpath://span[normalize-space()='Client']
${ClientsPO_client_page_lable}     xpath:(//h3[normalize-space()='Create Client'])[1]
${ClientsPO_first_name}     id:firstname
${ClientsPO_last_name}     id:lastname
${ClientsPO_client_classification_dropdown}     clientClassificationId
${ClientsPO_client_type_dropdown}     clienttypeId
${ClientsPO_legal_form_dropdown}     legalFormId
${ClientsPO_gender_dropdown}     genderId
${ClientsPO_submitted_date_on}     submittedon
${ClientsPO_date}           xpath:(//button[@type='button'])[55]     #Date picker is a table and will take some time to make date selection more flexible. For now I'll use a fixed date
${ClientsPO_add_family_member}      xpath://i[@title='Add Family Member']
${ClientsPO_family_relationship}      xpath://div[@id='relationshipIdOption_chosen']//span[contains(text(),'Select an Option')]
${ClientsPO_family_first_name}      firstName
${ClientsPO_family_middle_name}      middleName
${ClientsPO_family_last_name}      lastName
${ClientsPO_family_qualifications}      qualification
${ClientsPO_family_mobileNumber}      mobileNumber
${ClientsPO_family_age}      age
${ClientsPO_family_is_dependent}      isDependent
${ClientsPO_family_gender}      //div[@id='genderIdOption_chosen']//span[contains(text(),'Select an Option')]
${ClientsPO_family_profession}      //div[@id='professionIdOption_chosen']//span[contains(text(),'Select an Option')]
${ClientsPO_family_marital_status}      //div[@id='maritalStatusId_chosen']//span[contains(text(),'Select an Option')]
${ClientsPO_family_date_of_birth}      dateofbirth
${ClientsPO_submit}      save
${ClientsPO_cancel}      cancel




*** Keywords ***
load page
#    go to    ${Clients_url}
    Actions.click ${Clients_tab} once visible

get count of available dropdown options
    [Arguments]     ${id}
    Actions.click ${id} once visible
    ${count}        get element count   //select[@id='${id}']//option
    log     ${count}
    [Return]        ${count}

get dropdown options
    [Arguments]    ${loc}
    ${options}      get list items    ${loc}
    log         ${options}
    [Return]   ${options}


fillout requiered client information
    [Arguments]    ${fn}    ${ln}
    Actions.input ${fn} to ${ClientsPO_first_name} once visible
    Actions.input ${ln} to ${ClientsPO_last_name} once visible
    Actions.click ${ClientsPO_submitted_date_on} once visible
    Actions.click ${ClientsPO_date} once visible

add family member
    Actions.click ${ClientsPO_add_family_member} once visible

#    For simplicity of the locators, I will assume that I will only adding one family member, otherwise ids will be duplicated
mark family member as dependent
    Actions.click ${ClientsPO_family_is_dependent} once visible

submit create client form
    Actions.click ${ClientsPO_submit} once visible

cancel client creation
    Actions.click ${ClientsPO_cancel} once visible