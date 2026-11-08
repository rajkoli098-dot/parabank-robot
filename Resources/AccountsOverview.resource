*** Settings ***
Documentation       Accounts Overview page: the table of the customer's accounts.

Resource            ../Resources/Common.resource


*** Variables ***
${ACCOUNTS_OVERVIEW_XPATH}      //div[@id='showOverview']//h1[contains(@class,'title')]
${ACCOUNT_LIST_XPATH}           //table[@id='accountTable']//tbody//tr//a


*** Keywords ***
Accounts Overview Should List Accounts
    [Documentation]    Fails unless the table lists exactly ${expected_count} accounts.
    [Arguments]    ${expected_count}
    Wait Until Element Is Visible    ${ACCOUNTS_OVERVIEW_XPATH}
    Wait Until Element Is Visible    ${ACCOUNT_LIST_XPATH}
    Page Should Contain Element    ${ACCOUNT_LIST_XPATH}    limit=${expected_count}
