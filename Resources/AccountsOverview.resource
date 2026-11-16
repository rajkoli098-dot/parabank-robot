*** Settings ***
Documentation       Accounts Overview page: the table of the customer's accounts.

Resource            ../Resources/Common.resource


*** Variables ***
${ACCOUNTS_OVERVIEW_LINK_XPATH}    //a[text()='Accounts Overview']
${ACCOUNTS_OVERVIEW_XPATH}         //div[@id='showOverview']//h1[contains(@class,'title')]
${ACCOUNT_LIST_XPATH}              //table[@id='accountTable']//tbody//tr//a
${ACCOUNT_OVERVIEW_ROW_XPATH}    //td/a[text()='<<>>']/ancestor::tr/td


*** Keywords ***
Accounts Overview Should List Accounts
    [Documentation]    Fails unless the table lists exactly ${expected_count} accounts. and Return the account numbers.
    [Arguments]    ${expected_count}
    Wait Until Element Is Visible    ${ACCOUNTS_OVERVIEW_LINK_XPATH}
    Click Element    ${ACCOUNTS_OVERVIEW_LINK_XPATH}
    Wait Until Element Is Visible    ${ACCOUNTS_OVERVIEW_XPATH}
    Wait Until Element Is Visible    ${ACCOUNT_LIST_XPATH}
    @{Account_Elements}=    Get WebElements    ${ACCOUNT_LIST_XPATH}
    ${Actual_Count}=    Get Length    ${Account_Elements}
    Should Be Equal As Integers    ${Actual_Count}    ${expected_count}
    @{Account_Numbers}=    Create List
    FOR    ${element}    IN    @{Account_Elements}
        ${Account_No}=    Get Text    ${element}
        Append To List    ${Account_Numbers}    ${Account_No}
    END
    RETURN    ${Account_Numbers}

Account Number Is Present In The Account List
    [Documentation]    Checks whether given Acccount Number is Present in Account Overview List.
    [Arguments]    ${New_Acccount_Number}    @{Account_Numbers}
    List Should Contain Value    ${Account_Numbers}    ${New_Acccount_Number}



