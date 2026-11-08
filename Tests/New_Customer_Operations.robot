*** Settings ***
Resource    ../Resources/Common.resource
Resource    ../Resources/HomeAndLogin.resource
Resource    ../Resources/Register.resource
Resource    ../Resources/AccountsOverview.resource
Library    Collections
Library    ../Libraries/excel_utils.py
Suite Setup    Open ParaBank
Test Setup    Start From Logged Out Home Page
Suite Teardown    Close All Browsers

*** Variables ***
${MESSAGE}    Your account was created successfully. You are now logged in.
${PASSWORD_ERROR_MESSAGE}    Passwords did not match.
${USERNAME_ERROR_MESSAGE}    This username already exists.


*** Test Cases ***
Register A New Customer With Successful User Name
    [Tags]    RegisterCustomer    E2E
    &{customer}=    Get Row As Dictionary    ${CUSTOMER_FILE}    ${SHEET}    ${ROW_ID}
    Resgister A New Customer
    Fill Registration Form    ${customer}
    Clicking On Register Button
    Account Creation Successfull Message    ${customer}[Username]    ${MESSAGE}
    Log Out is Visible For New Registered Customer

Log Out and Login Again using New Customer Credentials
    [Tags]    LogOutLogIN    E2E
    Log Out From New Customer Creation Page
    Log In using New Customer Credentials
    Accounts Overview of New Account Creation Count
    Log Out From New Customer Creation Page

Error Scenario: Register with Password and Confirm Password that don't match
    [Tags]    PasswordMismatch    E2E
    &{customer}=    Get Row As Dictionary    ${CUSTOMER_FILE}    ${SHEET}    ${ROW_ID}
    Set To Dictionary    ${customer}    Confirm=Wrong_Pass
    Resgister A New Customer
    Fill Registration Form    ${customer}
    Clicking On Register Button
    Register Page Should Show Confirm Error    ${PASSWORD_ERROR_MESSAGE}

Error Scenario: Register a username that already exists
    [Tags]    SameUsername    E2E
    Resgister A New Customer
    Filling Customer Related All Details
    Clicking On Register Button
    Register Page Should Show Username Error    ${USERNAME_ERROR_MESSAGE}


