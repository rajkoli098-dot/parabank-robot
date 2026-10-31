*** Settings ***
Resource    ../Resources/LoginPage.resource
Test Teardown    Close All Browsers

*** Variables ***
${URL}    https://parabank.parasoft.com/parabank/index.htm
${Browser}    chrome
${Title}    ParaBank | Welcome | Online Bankin


*** Test Cases ***
Bank Title Verification
    [Tags]    1stTC    BankRegression
    Open Login Page & Verify Title    ${URL}    ${Browser}   ${Title}

