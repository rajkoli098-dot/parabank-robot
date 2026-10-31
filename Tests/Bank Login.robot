*** Settings ***
Resource    ../Resources/LoginPage.resource
Suite Setup    Open Browser    ${URL}    ${Browser}
Suite Teardown    Close All Browsers

*** Variables ***
${URL}    https://parabank.parasoft.com/parabank/index.htm
${Browser}    chrome
${Title}    ParaBank | Welcome | Online Banking

*** Test Cases ***
Log in with empty username and password
    [Tags]    negative
    Customer Login with Credentials    ${EMPTY}    ${EMPTY}

Log in with a username that does not exist
    [Tags]    negative
    Customer Login with Credentials    tery    ${EMPTY}


Forgot login info Link Clicking and Checking Title
    [Tags]    smoke
    Clicking On Link and Page Title Finding    Forgot login info?    ParaBank | Customer Lookup

Register Link Clicking and Checking Title
    [Tags]    smoke
    Clicking On Link and Page Title Finding    Register    ParaBank | Register for Free Online Account Access