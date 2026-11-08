*** Settings ***
Documentation       Registration tests: new customer, log in again, and two error cases.
...                 Every test creates the customer it needs, so any test can run alone.

Resource            ../Resources/Common.resource
Resource            ../Resources/HomeAndLogin.resource
Resource            ../Resources/Register.resource
Resource            ../Resources/AccountsOverview.resource
Resource            ../Resources/Flows.resource

Suite Setup         Open ParaBank
Test Setup          Start From Logged Out Home Page
Suite Teardown      Close All Browsers

Test Tags           e2e


*** Variables ***
${ROW_ID}                       3
${PASSWORD_ERROR_MESSAGE}       Passwords did not match.
${USERNAME_ERROR_MESSAGE}       This username already exists.


*** Test Cases ***
Register A New Customer
    [Documentation]    A brand-new customer can register and is logged in straight away.
    [Tags]    register
    Register New Customer From Excel    ${ROW_ID}
    Log Out Should Be Visible

Log Out And Log In Again As The New Customer
    [Documentation]    A new customer can log out, log back in, and sees exactly one account.
    [Tags]    login
    ${username}    ${password}=    Register New Customer From Excel    ${ROW_ID}
    Log Out
    Log In As    ${username}    ${password}
    Accounts Overview Should List Accounts    1

Register With Passwords That Do Not Match
    [Documentation]    A Confirm value that differs from Password shows the error under Confirm.
    [Tags]    negative
    &{customer}=    Get Customer Data    ${ROW_ID}    confirm=Wrong_Pass
    Open Register Page
    Fill Registration Form    ${customer}
    Submit Registration
    Register Page Should Show Confirm Error    ${PASSWORD_ERROR_MESSAGE}

Register A Username That Already Exists
    [Documentation]    Registering a username that is already taken shows the error under Username.
    [Tags]    negative
    ${username}    ${_}=    Register New Customer From Excel    ${ROW_ID}
    Log Out
    &{customer}=    Get Customer Data    ${ROW_ID}    username=${username}
    Open Register Page
    Fill Registration Form    ${customer}
    Submit Registration
    Register Page Should Show Username Error    ${USERNAME_ERROR_MESSAGE}
