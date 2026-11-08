*** Settings ***
Documentation       Transfer Funds page: move an amount from one account to another.

Resource            ../Resources/Common.resource


*** Variables ***
${AMOUNT_XPATH}                 //input[@id='amount']
${FROM_ACCOUNT_XPATH}           //select[@id='fromAccountId']
${FROM_ACCOUNT_OPTIONS_XPATH}   //select[@id='fromAccountId']/option
${TO_ACCOUNT_XPATH}             //select[@id='toAccountId']
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
