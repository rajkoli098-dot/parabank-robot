*** Settings ***
Documentation       Home page login box and the left menu: log in, log out, move between pages.

Resource            ../Resources/Common.resource


*** Variables ***
${CREDENTIALS_USERNAME_XPATH}       //input[@name='username']
${CREDENTIALS_PASSWORD_XPATH}       //input[@name='password']
${LOGIN_BUTTON_XPATH}               //input[@value='Log In']
${LOGOUT_BUTTON_XPATH}              //div[@id='leftPanel']//a[text()='Log Out']
${MENU_OPEN_NEW_ACCOUNT_XPATH}      //div[@id='leftPanel']//a[text()='Open New Account']
${MENU_ACCOUNTS_OVERVIEW_XPATH}     //div[@id='leftPanel']//a[text()='Accounts Overview']
${MENU_TRANSFER_FUNDS_XPATH}        //div[@id='leftPanel']//a[text()='Transfer Funds']
${NEWS_DATE_XPATH}                  //h4[text()='Latest News']/following-sibling::ul/li[@class='captionthree']


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

Navigate To Open New Account
    [Documentation]    Opens the Open New Account page from the left menu.
    Click Element    ${MENU_OPEN_NEW_ACCOUNT_XPATH}

Navigate To Accounts Overview
    [Documentation]    Opens the Accounts Overview page from the left menu.
    Click Element    ${MENU_ACCOUNTS_OVERVIEW_XPATH}

Navigate To Transfer Funds
    [Documentation]    Opens the Transfer Funds page from the left menu.
    Click Element    ${MENU_TRANSFER_FUNDS_XPATH}

Latest News Should Be Today
    [Documentation]    The Date under "Latest News" equals today's date, in the Site Format.
    Wait Until Element Is Visible    ${NEWS_DATE_XPATH}
    ${site_date} =    Get Text    ${NEWS_DATE_XPATH}
    ${today} =    Get Current Date    result_format=%m/%d/%Y
    Should Be Equal    ${site_date}    ${today}
