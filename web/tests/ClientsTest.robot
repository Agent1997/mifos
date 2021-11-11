*** Settings ***
Library    Dialogs
Resource    ../pageobjects/ClientsPO.robot
Resource    ../pageobjects/LoginPO.robot
Resource    ../pageobjects/ClientListPO.robot
Suite Setup     login
Test Setup      test setup
Suite Teardown    teardown

*** Keywords ***
teardown
    close all browsers

login
    LoginPO.load page
#    LoginPO.login as    mifos       password

#   I had trouble automating the login page due to the login dialog I tried different ways to handle it but I could not make it work.
#   And given the short time I had set for myself to do this activity I decided to skip that part.
#   Login will be done will be done manually. Please see LoginPO for the login script I would use if I was able to work around the login dialog.
    Dialogs.pause execution     Please login manually using username: mifos and password: password Then click OK on this modal once logged in. Thanks!

test setup
    ClientsPO.load page

*** Test Cases ***
User should see the correct and complete list of the dropdown fields
    [Documentation]    User should see the correct and complete list of the following dropdown fields under Create client section:
    ...                Gender, Client Classification, Client Type,  Legal Form
#   Though I know that gender options can only be Male or Female, I'll will only assert if there are more than one options since
#   I don't know what the actual options should be. More than one because the --Select Gender-- is also an option but those are not
#   actual options were expecting.
    ${gender_options_count}           ClientsPO.get count of available dropdown options    ${ClientsPO_gender_dropdown}
    run keyword and continue on failure    should be true    ${gender_options_count} > 1
    ...                                     Expecting gender options count to be more than 1 but found ${gender_options_count}

    ${client_classification_options_count}           ClientsPO.get count of available dropdown options    ${ClientsPO_client_classification_dropdown}
    run keyword and continue on failure    should be true    ${client_classification_options_count} > 1
    ...                                    Expecting client classification options count to be more than 1 but found ${client_classification_options_count}


    ${client_type_options_count}           ClientsPO.get count of available dropdown options    ${ClientsPO_client_type_dropdown}
    run keyword and continue on failure    should be true    ${client_type_options_count} > 1
    ...                                     Expecting client type options count to be more than 1 but found ${client_type_options_count}


    ${legal_form_options}          ClientsPO.get dropdown options    ${ClientsPO_legal_form_dropdown}
    run keyword and continue on failure    should contain    ${legal_form_options}      PERSON
    ...                                     Expecting ${legal_form_options} to have PERSON but not found
    run keyword and continue on failure    should contain    ${legal_form_options}      ENTITY
    ...                                     Expecting ${legal_form_options} to have ENTITY but not found

User should be able to add a family member
    [Documentation]    User should be able to add a family member
# For this test, I wont be able to actually add family member since "Relationship" is a required field but the search functionality is not working
# or I just don't have a test data. So instead, I'll validate that the ff fields are present upon clicking on the add family member icon (+)
    ClientsPO.fillout requiered client information    dummy     lastdummy

#    For simplicity of the locators, I will assume that I will only adding one family member, otherwise ids will be duplicated
    ClientsPO.add family member
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_relationship}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_first_name}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_middle_name}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_last_name}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_qualifications}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_mobileNumber}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_age}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_is_dependent}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_gender}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_profession}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_marital_status}
    run keyword and continue on failure    element should be visible    ${ClientsPO_family_date_of_birth}

User should be able to mark a family member as a dependent
    [Documentation]    User should be able to mark a family member as a dependent
#   For the same reason as Verify adding family member test I won't be filling out the form. I'll
#   just validate that when I click on the tickbox it will be selected.*** Keywords ***
    ClientsPO.fillout requiered client information   dummy     lastdummy3
    ClientsPO.add family member
    ClientsPO.mark family member as dependent
    checkbox should be selected      ${ClientsPO_family_is_dependent}

Submit the form without filling the required fields
    ClientsPO.submit create client form

#   Will just check if user is still in the same page, because he should not be able to proceed to next
#   page without filling out the form correctly
    element should be visible   ${ClientsPO_client_page_lable}

User should be able to cancel client creation
    ClientsPO.fillout requiered client information   dummy     lastdummy1
    ClientsPO.cancel client creation
#    Just a quick check that user was able to proceed to the next page after filling out table header should contain
#    required fields. For this one the assertion is inside the page object
    ClientListPO.user should be at view at the client list page
