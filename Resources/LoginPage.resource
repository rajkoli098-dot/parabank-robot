*** Settings ***
Library    SeleniumLibrary
Library    String

*** Variables ***
${TIMEOUT}    5s
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
    Wait Until Element Is Visible    ${LOC_USERNAME}    ${TIMEOUT}
    Clear Element Text    ${LOC_USERNAME}
    Input Text    ${LOC_USERNAME}    ${Username}
    Wait Until Element Is Visible    ${LOC_PASSWORD}    ${TIMEOUT}
    Clear Element Text    ${LOC_PASSWORD}
    Input Password    ${LOC_PASSWORD}    ${Password}
    Wait Until Element Is Visible    ${LOC_LOGIN}    ${TIMEOUT}
    Click Button    ${LOC_LOGIN}
    Run Keyword And Return    Login Succesfull or Not

Login Succesfull or Not
    [Documentation]     Keyword used After Lofing Button Clicked to Check if Login Successful or Error Message Received
    ${Logged_In}=    Run Keyword And Return Status    Title Should Be    ParaBank | Accounts Overview
    IF    not ${Logged_In}
        ${error}=    Get Text    ${LOC_ERROR}
        Fail    Login failed. The bank said: ${error}
    END


Clicking On Link and Page Title Finding
    [Documentation]    Keyword Help click on Link and Checking Title
    [Arguments]    ${Link_Text}    ${Expected_Title}
    ${Locator}=    Replace String    ${LOC_LINK}    <<>>    ${Link_Text}
    Wait Until Element Is Visible    ${Locator}    ${TIMEOUT}
    Click Element    ${Locator}
    Title Should Be    ${Expected_Title}
    ${Title_Found}=    Get Title
    Log    ${Title_Found}

