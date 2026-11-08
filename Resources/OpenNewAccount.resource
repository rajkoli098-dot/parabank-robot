*** Settings ***
Documentation       Open New Account page: choose a type and a funding account, then open the account.

Resource            ../Resources/Common.resource


*** Variables ***
${ACCOUNT_TYPE_XPATH}               //select[@id='type']
${FUNDING_ACCOUNT_XPATH}            //select[@id='fromAccountId']
${FUNDING_ACCOUNT_OPTIONS_XPATH}    //select[@id='fromAccountId']/option
${OPEN_ACCOUNT_BUTTON_XPATH}        //input[@value='Open New Account']
${ACCOUNT_OPENED_TITLE_XPATH}       //div[@id='openAccountResult']/h1
${NEW_ACCOUNT_NUMBER_XPATH}         //a[@id='newAccountId']


*** Keywords ***
Choose Account Type
    [Documentation]    Picks CHECKING or SAVINGS in the account type list.
    [Arguments]    ${account_type}
    Wait Until Element Is Visible    ${ACCOUNT_TYPE_XPATH}
    Select From List By Label    ${ACCOUNT_TYPE_XPATH}    ${account_type}

Choose Funding Account
    [Documentation]    Picks the existing account that pays the opening deposit.
    ...    The list fills in a moment after the page opens, so it waits for the options first.
    [Arguments]    ${account_number}
    Wait Until Page Contains Element    ${FUNDING_ACCOUNT_OPTIONS_XPATH}
    Select From List By Label    ${FUNDING_ACCOUNT_XPATH}    ${account_number}

Submit New Account
    [Documentation]    Clicks the Open New Account button.
    Click Element    ${OPEN_ACCOUNT_BUTTON_XPATH}

New Account Should Be Opened
    [Documentation]    Fails unless the page shows "Account Opened!", then returns the new account number.
    Wait Until Element Is Visible    ${NEW_ACCOUNT_NUMBER_XPATH}
    Element Text Should Be    ${ACCOUNT_OPENED_TITLE_XPATH}    Account Opened!
    ${new_account}=    Get Text    ${NEW_ACCOUNT_NUMBER_XPATH}
    RETURN    ${new_account}
