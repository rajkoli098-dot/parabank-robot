*** Settings ***
Documentation            End to End Banking on Parabank with New Saving Account,Account Transfers, Balance Check.

Resource            ../Resources/Common.resource
Resource            ../Resources/HomeAndLogin.resource
Resource            ../Resources/Register.resource
Resource            ../Resources/AccountsOverview.resource
Resource            ../Resources/Flows.resource
Resource            ../Resources/OpenNewAccount.resource

Suite Setup         Open ParaBank
Test Setup          Start From Logged Out Home Page
Test Teardown       Log Out
Suite Teardown      Close All Browsers

Test Tags           e2eAccounts

*** Variables ***
${ROW_ID}                       3


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



