*** Settings ***
Documentation            End to End Banking on Parabank with New Saving Account,Account Transfers, Balance Check.

Resource            ../Resources/AccountsOverview.resource
Resource            ../Resources/BillPay.resource
Resource            ../Resources/Common.resource
Resource            ../Resources/HomeAndLogin.resource
Resource            ../Resources/Register.resource
Resource            ../Resources/Flows.resource
Resource            ../Resources/OpenNewAccount.resource
Resource            ../Resources/TransferFunds.resource

Suite Setup         Open ParaBank
Test Setup          Start From Logged Out Home Page
Test Teardown       Log Out
Suite Teardown      Close All Browsers

Test Tags           e2eAccounts

*** Variables ***
${ROW_ID}                       3
${AMOUNT}                       50.05
${PAYEE_AMOUNT}                 14.29
${PAYEE_ACCOUNT}                46457
${CONFIRM_PAYEE_ACCOUNT}        46457


*** Test Cases ***
Open A New SAVINGS Account From Your First Account
    [Documentation]    Opening a new SAVINGS account funded from your first account.Capturing the new account number.
    [Tags]    NewSavings
    ${username}    ${password}=    Register New Customer From Excel    ${ROW_ID}
    Log Out
    Log In As    ${username}    ${password}
    ${New_Acccount_Number}=    New Savings Account Creation Using Primary Account
    @{Accounts}=    Accounts Overview Should List Accounts    2
    Account Number Is Present In The Account List    ${New_Acccount_Number}    @{Accounts}

Transfer An Amount Between Your Two Accounts
    [Documentation]    Transfer Amounts between your accounts and check the exact balance credited & debited.
    [Tags]    TransferAmount
    &{Before_Transfer}=    Before Transfer Amounts Accounts Balance And Total Balance    ${ROW_ID}
    ${Primary_Account}    ${Secondary_Account}=    Get Account Numbers    ${Before_Transfer}
    &{After_Transfer}=    After Transfer Amounts Accounts Balance And Total Balance    ${Amount}    ${Primary_Account}    ${Secondary_Account}
    Compare Before And After Transaction Amounts    ${Before_Transfer}    ${After_Transfer}    ${Amount}    ${Primary_Account}    ${Secondary_Account}

Pay A Any Bill And Check The Account Balance
    [Documentation]    Pay a bill and After Payment checks the Account Balance
    [Tags]    PayBill
    &{Before_Transfer}=    Before Transfer Amounts Accounts Balance And Total Balance    ${ROW_ID}
    ${Primary_Account}    ${Secondary_Account}=    Get Account Numbers    ${Before_Transfer}
    Click On Bill Pay Link
    Enter Payee Information
    Enter Payee Account, Payee Amount And From Account    ${Payee_Account}    ${Confirm_Payee_Account}
    ...    ${Payee_Amount}    ${Primary_Account}
    Send Payment
    Bill Payment Completion    ${Payee_Amount}    ${Primary_Account}
    &{After_Bill_Payment}=    Get Account Balance
    Compare Before And After Bill Payment Amounts    ${Before_Transfer}    ${After_Bill_Payment}
    ...    ${Payee_Amount}    ${Primary_Account}

Negative Scenario Bill Pay With Empty Field And Mismatch Accoun Number
    [Documentation]    Throws Error and Give Error List with Field Name.
    [Tags]    NegativePayBill
    ${username}    ${password}=    Register New Customer From Excel    ${ROW_ID}
    Log Out
    Log In As    ${username}    ${password}
    Click On Bill Pay Link
    Fill Mismatch Account And Confirm Account    ${PAYEE_ACCOUNT}    00000
    Send Payment
    Error Recieved For Each Field
