*** Settings ***
Documentation       Registration tests: new customer, log in again, and two error cases.

Resource            ../Resources/Common.resource
Resource            ../Resources/HomeAndLogin.resource
Resource            ../Resources/Register.resource
Resource            ../Resources/AccountsOverview.resource
Library             Collections

Suite Setup         Open ParaBank
Test Setup          Start From Logged Out Home Page
Suite Teardown      Close All Browsers


*** Variables ***
${ROW_ID}                       3
${PASSWORD_ERROR_MESSAGE}       Passwords did not match.
${USERNAME_ERROR_MESSAGE}       This username already exists.


*** Test Cases ***
Register A New Customer With Successful User Name
    [Tags]    RegisterCustomer    E2E
    &{customer}=    Get Row As Dictionary    ${CUSTOMER_FILE}    ${SHEET}    ${ROW_ID}
    Open Register Page
    Fill Registration Form    ${customer}
    Submit Registration
    Register Page Should Show Welcome For    ${customer}[Username]
    Log Out Should Be Visible

Log Out and Login Again using New Customer Credentials
    [Tags]    LogOutLogIN    E2E
    Log Out
    Log In As    ${Username}    ${Password}
    Accounts Overview Should List Accounts    1
    Log Out

Error Scenario: Register with Password and Confirm Password that don't match
    [Tags]    PasswordMismatch    E2E
    &{customer}=    Get Row As Dictionary    ${CUSTOMER_FILE}    ${SHEET}    ${ROW_ID}
    Set To Dictionary    ${customer}    Confirm=Wrong_Pass
    Open Register Page
    Fill Registration Form    ${customer}
    Submit Registration
    Register Page Should Show Confirm Error    ${PASSWORD_ERROR_MESSAGE}

Error Scenario: Register a username that already exists
    [Tags]    SameUsername    E2E
    &{customer}=    Get Row As Dictionary    ${CUSTOMER_FILE}    ${SHEET}    ${ROW_ID}
    Open Register Page
    Fill Registration Form    ${customer}
    Submit Registration
    Register Page Should Show Username Error    ${USERNAME_ERROR_MESSAGE}
