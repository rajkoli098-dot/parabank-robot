*** Settings ***
Library    SeleniumLibrary    timeout=10s
Resource    ../Resources/Register.resource

*** Variables ***
${CREDENTIALS_USERNAME_XPATH}    //input[contains(@name,'username')]
${CREDENTIALS_PASSWORD_XPATH}    //input[contains(@name,'password')]
${LOGIN_BUTTON_XPATH}    //input[contains(@value,'Log In')]
${LOGOUT_BUTTON_XPATH}    //a[text()='Log Out']



*** Keywords ***
Log Out From New Customer Creation Page
    Wait Until Element Is Visible    ${LOGOUT_BUTTON_XPATH}
    Click Element    ${LOGOUT_BUTTON_XPATH}
    Wait Until Element Is Not Visible    ${LOGOUT_BUTTON_XPATH}
    Capture Page Screenshot

Log In using New Customer Credentials
    Wait Until Element Is Visible    ${LOGIN_BUTTON_XPATH}
    Input Text    ${CREDENTIALS_USERNAME_XPATH}    ${Username}
    Input Password    ${CREDENTIALS_PASSWORD_XPATH}    ${Password}
    Capture Page Screenshot
    Click Element    ${LOGIN_BUTTON_XPATH}
    Wait Until Element Is Visible    ${LOGOUT_BUTTON_XPATH}