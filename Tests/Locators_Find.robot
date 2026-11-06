*** Settings ***
Resource          ../Resources/Locators.robot
Resource          ../Resources/LoginPage.resource
Suite Setup       Open Browser    https://parabank.parasoft.com/parabank/index.htm    chrome
Suite Teardown    Close All Browsers

*** Test Cases ***
White Belt
    [Tags]    LocateElementsWhite    LocateElementsAll
    Go To    https://parabank.parasoft.com/parabank/index.htm
    Page Should Contain Element    ${W1_USERNAME_XPATH}             limit=1
    Page Should Contain Element    ${W2_LOGIN_XPATH}               limit=1
    Page Should Contain Element    ${W3_RGISTER_FULL_TEXT_XPATH}                limit=1
    Page Should Contain Element    ${W3_RGISTER_PART_TEXT_XPATH}    limit=1
    Page Should Contain Element    ${W4_PARABANK_LOGO_XPATH}   limit=1
    Page Should Contain Element    ${W4_PARABANK_LOGO_XPATH}        limit=1
    Page Should Contain Element    ${W5_CONTACT_US_XPATH}    limit=1

Green Belt
    [Tags]    LocateElementsGreen    LocateElementsAll
    Go To    https://parabank.parasoft.com/parabank/index.htm
    Page Should Contain Element    ${G1_DATE_XPATH}    limit=1
    Page Should Contain Element    ${G2_TRANSFER_FUNDS_XPATH}               limit=1
    Page Should Contain Element    ${G3_ATM_SERVICES_LIST_XPATH}                limit=4
    Wait Until Element Is Visible    ${W3_RGISTER_FULL_TEXT_XPATH}
    Click Element    ${W3_RGISTER_FULL_TEXT_XPATH}
    Page Should Contain Element    ${G4_ZIP_CODE_INPUT_XPATH}    limit=1
    Page Should Contain Element    ${G5_ABOUT_XPATH}   limit=1


Black Belt
    [Tags]    LocateElementsBlack    LocateElementsAll
    Go To    https://parabank.parasoft.com/parabank/index.htm
    Input Text    ${W1_USERNAME_XPATH}    124@HJI.COM
    Input Password    ${W1_PASSWORD_XPATH}    124@HJI.COM
    Click Element    ${W2_LOGIN_XPATH}
    Wait Until Element Is Visible    //a[text()='Accounts Overview']
    Click Element    //a[text()='Accounts Overview']
    Wait Until Element Is Visible    //a[text()='${ACC_NO}']
    Page Should Contain Element    ${B1_BALANCE_XPATH}    limit=1
    Page Should Contain Element    ${B2_TOTAL_BALANCE_XPATH}   limit=1
    Wait Until Element Is Visible    //a[text()='Transfer Funds']
    Click Element    //a[text()='Transfer Funds']
    Wait Until Element Is Visible    //select[normalize-space(preceding-sibling::text()[1])='From account #']
    Click Element    //select[normalize-space(preceding-sibling::text()[1])='From account #']
    Wait Until Element Is Visible    ${B3_TRANSFER_FUNDS_XPATH}
    Page Should Contain Element    ${B3_TRANSFER_FUNDS_XPATH}    limit=1
    Wait Until Element Is Visible    //a[text()='Accounts Overview']
    Click Element    //a[text()='Accounts Overview']
    Wait Until Element Is Visible    //a[text()='${ACC_NO}']
    Click Element    //a[text()='${ACC_NO}']
    Wait Until Element Is Visible    ${B4_CELL_DEBIT_XPATH}
    Page Should Contain Element    ${B4_CELL_DEBIT_XPATH}    limit=2
    Go To    https://www.globalsqa.com/angularJs-protractor/BankingProject/#/customer
    Wait Until Element Is Visible    ${B5_CUST_DROPDOWN_XPATH}
    Page Should Contain Element    ${B5_CUST_DROPDOWN_XPATH}    limit=1
