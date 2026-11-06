*** Settings ***
Resource    ../Resources/Common.resource

*** Variables ***
${LOC_USERNAME}    //input[@name='username']
${LOC_PASSWORD}    //input[@name='password']
${LOC_LOGIN}    //input[@value='Log In' and @class='button']
${LOC_ERROR}    //h1[text()='Error!']/following-sibling::p
${LOC_LINK}    //a[text()='<<>>']


*** Keywords ***
Open Login Page & Verify Title
    [Documentation]    Keyword is going open Login Page on Browser and Valdating Title of Page
    [Arguments]    ${URL}    ${Browser}    ${Title}
    Open Browser    ${URL}    ${Browser}
    Title Should Be    ${Title}

Customer Login with Credentials
    [Documentation]    Keyword used for Login the Bank Website using Customer Credenatials
    [Arguments]    ${Username}    ${Password}
    Wait Until Element Is Visible    ${LOC_USERNAME}
    Input Text    ${LOC_USERNAME}    ${Username}
    Input Password    ${LOC_PASSWORD}    ${Password}
    Wait Until Element Is Visible    ${LOC_LOGIN}
    Click Button    ${LOC_LOGIN}

Clicking On Link and Page Title Finding
    [Documentation]    Keyword Help click on Link and Checking Title
    [Arguments]    ${Link_Text}    ${Expected_Title}
    ${Locator}=    Replace String    ${LOC_LINK}    <<>>    ${Link_Text}
    Wait Until Element Is Visible    ${Locator}
    Click Element    ${Locator}
    Title Should Be    ${Expected_Title}

Login Should Fail With
    [Documentation]    Checks the exact error text shown after a failed login.
    [Arguments]    ${expected_error}
    Wait Until Element Is Visible    ${LOC_ERROR}
    Element Text Should Be    ${LOC_ERROR}    ${expected_error}