*** Settings ***
Documentation       Registration tests: new customer, log in again, and two error cases.

Resource            ../Resources/Common.resource
Resource            ../Resources/HomeAndLogin.resource
Resource            ../Resources/Register.resource
Resource            ../Resources/AccountsOverview.resource

Suite Setup         Open ParaBank
Test Setup          Start From Logged Out Home Page
Suite Teardown      Close All Browsers

*** Variables ***
${MESSAGE}    Your account was created successfully. You are now logged in.
${PASSWORD_ERROR_MESSAGE}    Passwords did not match.
${USERNAME_ERROR_MESSAGE}    This username already exists.


*** Test Cases ***
Register A New Customer With Successful User Name
    [Tags]    RegisterCustomer    E2E
    Resgister A New Customer
    Filling Customer Related All Details
    Clicking On Register Button
    Account Creation Successfull Message    ${MESSAGE}
    Log Out is Visible For New Registered Customer

Log Out and Login Again using New Customer Credentials
    [Tags]    LogOutLogIN    E2E
    Log Out From New Customer Creation Page
    Log In using New Customer Credentials
    Accounts Overview of New Account Creation Count
    Log Out From New Customer Creation Page

Error Scenario: Register with Password and Confirm Password that don't match
    [Tags]    PasswordMismatch    E2E
    Resgister A New Customer
    Provide Confirm Password as Mismatch Value    Wrong_Pass
    Clicking On Register Button
    Error should be appear on register page    ${PASSWORD_ERROR_MESSAGE}

Error Scenario: Register a username that already exists
    [Tags]    SameUsername    E2E
    Resgister A New Customer
    Filling Customer Related All Details
    Clicking On Register Button
    Error should be appear on register page    ${USERNAME_ERROR_MESSAGE}


