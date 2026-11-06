*** Settings ***
Resource    ../Resources/LoginPage.resource
Suite Setup       Open Login Page & Verify Title    ${URL}    ${Browser}    ${Title}
Test Setup        Go To    ${URL}
Suite Teardown    Close All Browsers

*** Variables ***
${Title}    ParaBank | Welcome | Online Banking


*** Test Cases ***
Log in with empty username and password
    [Tags]    negative
    Customer Login with Credentials    ${EMPTY}    ${EMPTY}
    Login Should Fail With    Please enter a username and password.

Log in with a username that does not exist
    [Tags]    negative
    Customer Login with Credentials    tery    wrong_apss
    Login Should Fail With    The username and password could not be verified.


Forgot login info Link Clicking and Checking Title
    [Tags]    smoke
    Clicking On Link and Page Title Finding    Forgot login info?    ParaBank | Customer Lookup

Register Link Clicking and Checking Title
    [Tags]    smoke
    Clicking On Link and Page Title Finding    Register    ParaBank | Register for Free Online Account Access