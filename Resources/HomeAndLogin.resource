*** Settings ***
Documentation       Home page login box and the left menu: log in, log out, and check who is logged in.

Resource            ../Resources/Common.resource


*** Variables ***
${CREDENTIALS_USERNAME_XPATH}       //input[contains(@name,'username')]
${CREDENTIALS_PASSWORD_XPATH}       //input[contains(@name,'password')]
${LOGIN_BUTTON_XPATH}               //input[contains(@value,'Log In')]
${LOGOUT_BUTTON_XPATH}              //a[text()='Log Out']


*** Keywords ***
Log In As
    [Documentation]    Logs in with the given username and password, then waits for the Log Out link.
    [Arguments]    ${username}    ${password}
    Wait Until Element Is Visible    ${LOGIN_BUTTON_XPATH}
    Input Text    ${CREDENTIALS_USERNAME_XPATH}    ${username}
    Input Password    ${CREDENTIALS_PASSWORD_XPATH}    ${password}
    Click Element    ${LOGIN_BUTTON_XPATH}
    Wait Until Element Is Visible    ${LOGOUT_BUTTON_XPATH}

Log Out
    [Documentation]    Clicks Log Out in the left menu and waits until the link is gone.
    Wait Until Element Is Visible    ${LOGOUT_BUTTON_XPATH}
    Click Element    ${LOGOUT_BUTTON_XPATH}
    Wait Until Element Is Not Visible    ${LOGOUT_BUTTON_XPATH}

Log Out Should Be Visible
    [Documentation]    Fails unless the left menu shows Log Out, which means a customer is logged in.
    Wait Until Element Is Visible    ${LOGOUT_BUTTON_XPATH}
