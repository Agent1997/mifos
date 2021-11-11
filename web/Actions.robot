*** Settings ***
Library    SeleniumLibrary
Library    String

*** Keywords ***
launch browser
    [Arguments]    ${url}    ${browser}
    Open Browser    ${url}    browser=${browser}
    maximize browser window

dismiss alert
    handle alert    ACCEPT     10s

force click on coordinates using javascript
    [Arguments]    ${x-coor}        ${y-coor}
    execute javascript
    execute javascript    document.elementFromPoint(${x-coor},${y-coor}).click();

force input text using javascript
    [Arguments]    ${id}    ${text}
    run keyword and continue on failure    wait until element is visible    ${id}
    execute javascript    document.getElementById("${id}").value = "${text}";

force input text using javascript then enter
    [Arguments]    ${id}    ${text}
    run keyword and continue on failure    wait until element is visible    ${id}
    execute javascript    document.getElementById("${id}").value = "${text}";
    press keys    ${id}     ENTER

click ${element_loc1} once ${element_loc2} is not visible
    wait until element is not visible   ${element_loc2}
    Actions.click ${element_loc1} once visible

click ${element_locator} once visible
    [Documentation]    ${element_locator}: Locator for the element to be clicked
    wait until element is visible    ${element_locator}
    click element    ${element_locator}

input ${text} to ${text_field_loc} once visible
    [Documentation]   ${text_field_loc}: Locator of the text field
    ...               ${text}: String to input in the text field
    wait until element is visible    ${text_field_loc}
    input text    ${text_field_loc}   ${text}
    log    Typing text:${text} to locator:${text_field_loc}




