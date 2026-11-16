*** Settings ***
Documentation    Transfer Funds page: move an amount from one account to another.

Resource    ../Resources/AccountsOverview.resource
Resource    ../Resources/Common.resource
Resource    ../Resources/Flows.resource
Resource    ../Resources/HomeAndLogin.resource
Resource    ../Resources/OpenNewAccount.resource


*** Variables ***
${TRANSFER_FUNDS_LINK_XPATH}    //a[text()='Transfer Funds']
${TRANSFER_FUNDS_TITLE_XPATH}   //h1[@class='title' and contains(text(),'Transfer Funds')]
${AMOUNT_XPATH}                 //input[@id='amount']
${FROM_ACCOUNT_XPATH}           //select[@id='fromAccountId']
${FROM_ACCOUNT_OPTIONS_XPATH}   //select[@id='fromAccountId']/option
${TO_ACCOUNT_XPATH}             //select[@id='toAccountId']
${TO_ACCOUNT_OPTIONS_XPATH}     //select[@id='toAccountId']/option
${TRANSFER_BUTTON_XPATH}        //input[@value='Transfer']
${TRANSFER_TITLE_XPATH}         //div[@id='showResult']/h1
${TRANSFERRED_AMOUNT_XPATH}     //span[@id='amountResult']


*** Keywords ***
Enter Transfer Amount
    [Documentation]    Types the amount to transfer, without the $ sign.
    [Arguments]    ${amount}
    Wait Until Element Is Visible    ${AMOUNT_XPATH}
    Input Text    ${AMOUNT_XPATH}    ${amount}

Choose Transfer Accounts
    [Documentation]    Picks the account to take money from and the account to put it into.
    ...    The lists fill in a moment after the page opens, so it waits for the options first.
    [Arguments]    ${from_account}    ${to_account}
    Wait Until Page Contains Element    ${FROM_ACCOUNT_OPTIONS_XPATH}
    Select From List By Label    ${FROM_ACCOUNT_XPATH}    ${from_account}
    Select From List By Label    ${TO_ACCOUNT_XPATH}    ${to_account}

Submit Transfer
    [Documentation]    Clicks the Transfer button.
    Click Element    ${TRANSFER_BUTTON_XPATH}

Transfer Should Be Complete
    [Documentation]    Fails unless the page shows "Transfer Complete!" for the given amount.
    [Arguments]    ${amount}
    Wait Until Element Is Visible    ${TRANSFER_TITLE_XPATH}
    Element Text Should Be    ${TRANSFER_TITLE_XPATH}    Transfer Complete!
    Element Should Contain    ${TRANSFERRED_AMOUNT_XPATH}    ${amount}

Before Transfer Amounts Accounts Balance And Total Balance
    [Documentation]    Registers a customer, opens a savings account, then returns the new account number
    ...    and a dictionary of both accounts, e.g. {'13344': {'Balance': '$415.55', ...}, '13455': {...}}.
    [Arguments]    ${ROW_ID}
    Register New Customer From Excel    ${ROW_ID}
    ${New_Acccount_Number}=    New Savings Account Creation Using Primary Account
    ${All_Accounts}=    Get Account Balance
    Log    ${All_Accounts}
    RETURN    ${All_Accounts}


After Transfer Amounts Accounts Balance And Total Balance
    [Documentation]    Returns a dictionary of both accounts, e.g. {'13344': {'Balance': '$415.55', ...}, '13455': {...}}.
    [Arguments]    ${Amount}    ${From_Account}    ${To_Account}
    Wait Until Element Is Visible    ${TRANSFER_FUNDS_LINK_XPATH}
    Click Element    ${TRANSFER_FUNDS_LINK_XPATH} 
    Wait Until Element Is Visible    ${TRANSFER_FUNDS_TITLE_XPATH}
    Enter Transfer Amount    ${Amount}
    Choose Transfer Accounts    ${From_Account}     ${To_Account}
    Submit Transfer
    Wait Until Element Is Visible    ${TRANSFER_TITLE_XPATH}
    ${All_Accounts}=    Get Account Balance
    Log    ${All_Accounts}
    RETURN    ${All_Accounts}


Compare Before And After Transaction Amounts
    [Documentation]    Compares the balances of two accounts before and after a transfer, ensuring the correct amounts were debited and credited.
    [Arguments]    ${Before_Transfer}    ${After_Transfer}    ${Amount}    ${From_Account}    ${To_Account}
    ${Before_From_Balance}=    Set Variable    ${Before_Transfer}[${From_Account}][Balance]
    ${Before_To_Balance}=      Set Variable    ${Before_Transfer}[${To_Account}][Balance]
    ${After_From_Balance}=     Set Variable    ${After_Transfer}[${From_Account}][Balance]
    ${After_To_Balance}=       Set Variable    ${After_Transfer}[${To_Account}][Balance]
    ${Before_From_Balance_Number}=    Remove String And Convert To The Number    ${Before_From_Balance}    $    ,
    ${Before_To_Balance_Number}=    Remove String And Convert To The Number    ${Before_To_Balance}    $    ,
    ${After_From_Balance_Number}=    Remove String And Convert To The Number    ${After_From_Balance}    $    ,
    ${After_To_Balance_Number}=    Remove String And Convert To The Number    ${After_To_Balance}     $    ,
    ${Expected_After_From_Balance}=    Evaluate    ${Before_From_Balance_Number} - ${Amount}
    ${Expected_After_To_Balance}=      Evaluate    ${Before_To_Balance_Number} + ${Amount}
    Should Be Equal As Numbers    ${After_From_Balance_Number}    ${Expected_After_From_Balance}
    Should Be Equal As Numbers    ${After_To_Balance_Number}    ${Expected_After_To_Balance}

Get Account Balance
    [Documentation]    Shows Each account, Account Balance in Dictionary Format
    @{Accounts}=    Accounts Overview Should List Accounts    2
    &{All_Accounts}=    Create Dictionary
    FOR    ${Account}    IN    @{Accounts}
        ${OBJ}=    Replace String    ${ACCOUNT_OVERVIEW_ROW_XPATH}    <<>>    ${Account}
        @{LIST_OBJ}=    Get WebElements    ${OBJ}
        ${Balance}=    Get Text    ${LIST_OBJ}[1]
        ${Available_Amount}=    Get Text    ${LIST_OBJ}[2]
        &{Account_Details}=    Create Dictionary
        ...    Account_Number=${Account}    Balance=${Balance}    Available_Amount=${Available_Amount}
        Set To Dictionary    ${All_Accounts}    ${Account}    ${Account_Details}
    END
    RETURN   ${All_Accounts}