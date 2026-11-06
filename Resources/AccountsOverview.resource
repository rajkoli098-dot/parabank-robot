*** Settings ***
Library    SeleniumLibrary    timeout=10s
Resource    ../Resources/HomeAndLogin.resource
Resource    ../Resources/Register.resource

*** Variables ***
${ACCOUNTS_OVERVIEW_XPATH}    //div[@id='showOverview']//h1[contains(@class,'title')]
${ACCOUNT_LIST_XPATH}    //table[@id='accountTable']//tbody//tr//a


*** Keywords ***
Accounts Overview of New Account Creation Count
    Wait Until Element Is Visible    ${ACCOUNTS_OVERVIEW_XPATH}
    Wait Until Element Is Visible    ${ACCOUNT_LIST_XPATH}
    Capture Page Screenshot
    Page Should Contain Element    ${ACCOUNT_LIST_XPATH}    limit=1
