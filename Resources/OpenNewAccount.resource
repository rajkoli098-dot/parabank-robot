*** Settings ***
Documentation       Open New Account page: choose a type and a funding account, then open the account.

Resource            ../Resources/Common.resource
Resource            ../Resources/AccountsOverview.resource


*** Variables ***
${OPEN_ACCOUNT_LINK_XPATH}          //a[text()='Open New Account']
${OPEN_ACCOUNT_TITLE_XPATH}         //h1[@class='title' and text()='Open New Account']
${ACCOUNT_TYPE_XPATH}               //select[@id='type']
${FUNDING_ACCOUNT_XPATH}            //select[@id='fromAccountId']
${FUNDING_ACCOUNT_OPTIONS_XPATH}    //select[@id='fromAccountId']/option
${OPEN_ACCOUNT_BUTTON_XPATH}        //input[@value='Open New Account']
${ACCOUNT_OPENED_TITLE_XPATH}       //div[@id='openAccountResult']/h1
${NEW_ACCOUNT_NUMBER_XPATH}         //a[@id='newAccountId']


*** Keywords ***
Open New Account Link
    [Documentation]    Clicks Open New Account Link
    Wait Until Element Is Visible    ${OPEN_ACCOUNT_LINK_XPATH}
    Click Element    ${OPEN_ACCOUNT_LINK_XPATH}
    Wait Until Element Is Visible    ${OPEN_ACCOUNT_TITLE_XPATH}

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

New Savings Account Creation Using Primary Account
    [Documentation]    Creates the New SAVINGS Account using Primary Account and Return the New Account Number.
    @{Accounts}=    Accounts Overview Should List Accounts    1
    Open New Account Link
    Choose Account Type    SAVINGS
    Choose Funding Account    ${Accounts}[0]
    Submit New Account
    ${New_Account_Number}=    New Account Should Be Opened
    RETURN    ${New_Account_Number}
