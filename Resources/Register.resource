*** Settings ***
Library    SeleniumLibrary    timeout=10s
Library    ../Libraries/excel_utils.py

*** Variables ***
${FILE}    Test Data/customer_data.xlsx
${SHEET_NAME}    Sheet1
${ROW_ID}    3
${RGISTER_XPATH}    //a[text()='Register']
${REGISTER_TITLE_XPATH}    //h1[@class='title']
${FIRST_NAME_XPATH}    //input[contains(@id,'firstName')]
${LAST_NAME_XPATH}    //input[contains(@id,'lastName')]
${ADDRESS_XPATH}    //input[contains(@id,'street')]
${CITY_XPATH}    //input[contains(@id,'city')]
${STATE_XPATH}    //input[contains(@id,'state')]
${ZIP_CODE_XPATH}    //input[contains(@id,'zipCode')]
${PHONE_XPATH}    //input[contains(@id,'phoneNumber')]
${SSN_XPATH}    //input[contains(@id,'ssn')]
${USERNAME_XPATH}    //input[contains(@id,'username')]
${PASSWORD_XPATH}    //input[contains(@id,'password')]
${CONFIRM_PASSWORD_XPATH}    //input[contains(@id,'repeatedPassword')]
${REGISTER_BUTTON_XPATH}    //input[contains(@value,'Register')]
${WELCOME_USERNAME_XPATH}    //div[@id='rightPanel']/h1[@class='title']
${ACOOUNT_CREATED_MESSAGE_XPATH}    //div[@id='rightPanel']/P
${Username}
${Password}
${LOGOUT_XPATH}    //a[text()='Log Out']
${REGISTER_ERROR_XPATH}    //td//span[contains(@id,'errors')]



*** Keywords ***
Resgister A New Customer
    Wait Until Element Is Visible    ${RGISTER_XPATH}
    Click Element    ${RGISTER_XPATH}
    Wait Until Element Is Visible    ${REGISTER_TITLE_XPATH}
    ${Register_Message}=    Get Text    ${REGISTER_TITLE_XPATH}
    Should Be Equal    Signing up is easy!    ${Register_Message}

Filling Customer Related All Details
    &{Customer_Details}=    Get Row As Dictionary    ${FILE}    ${SHEET_NAME}    ${ROW_ID}
    ${First_Name}=    Set Variable    ${Customer_Details}[First Name]
    ${Last_Name}=    Set Variable    ${Customer_Details}[Last Name]
    ${Address}=    Set Variable    ${Customer_Details}[Address]
    ${City}=    Set Variable    ${Customer_Details}[City]
    ${State}=    Set Variable    ${Customer_Details}[State]
    ${Zip Code}=    Set Variable    ${Customer_Details}[Zip Code]
    ${Phone}=    Set Variable    ${Customer_Details}[Phone #]
    ${SSN}=    Set Variable    ${Customer_Details}[SSN]
    Set Global Variable    ${Username}    ${Customer_Details}[Username]
    Set Global Variable    ${Password}    ${Customer_Details}[Password]
    ${Confirm}=    Set Variable    ${Customer_Details}[Confirm]
    Input Text    ${FIRST_NAME_XPATH}    ${First_Name}
    Input Text    ${LAST_NAME_XPATH}    ${Last_Name}
    Input Text    ${ADDRESS_XPATH}    ${Address}
    Input Text    ${CITY_XPATH}    ${City}
    Input Text    ${STATE_XPATH}    ${State}
    Input Text    ${ZIP_CODE_XPATH}    ${Zip Code}
    Input Text    ${PHONE_XPATH}     ${Phone}
    Input Text    ${SSN_XPATH}    ${SSN}
    Input Text    ${USERNAME_XPATH}    ${Username}
    Input Password    ${PASSWORD_XPATH}    ${Password}
    Input Password    ${CONFIRM_PASSWORD_XPATH}    ${Confirm}
    Capture Page Screenshot

Clicking On Register Button
    Wait Until Element Is Visible    ${REGISTER_BUTTON_XPATH}
    Click Element    ${REGISTER_BUTTON_XPATH}

Account Creation Successfull Message
    [Arguments]    ${MSG}
    Wait Until Element Is Visible    ${WELCOME_USERNAME_XPATH}
    ${Welcome_Username}=    Get Text    ${WELCOME_USERNAME_XPATH}
    Log    ${Welcome_Username}    INFO
    Should End With    ${Welcome_Username}    ${Username}
    Wait Until Element Is Visible    ${ACOOUNT_CREATED_MESSAGE_XPATH}
    ${Message}=    Get Text    ${ACOOUNT_CREATED_MESSAGE_XPATH}
    Log    ${Message}    INFO
    Should Be Equal    ${MSG}    ${Message}
    Capture Page Screenshot

Log Out is Visible For New Registered Customer
    Wait Until Element Is Visible    ${LOGOUT_XPATH}
    Log    Logout is Visible    INFO
    Capture Page Screenshot

Provide Confirm Password as Mismatch Value
    [Arguments]    ${Confirm_Mismatch}
    &{Customer_Details}=    Get Row As Dictionary    ${FILE}    ${SHEET_NAME}    ${ROW_ID}
    ${First_Name}=    Set Variable    ${Customer_Details}[First Name]
    ${Last_Name}=    Set Variable    ${Customer_Details}[Last Name]
    ${Address}=    Set Variable    ${Customer_Details}[Address]
    ${City}=    Set Variable    ${Customer_Details}[City]
    ${State}=    Set Variable    ${Customer_Details}[State]
    ${Zip Code}=    Set Variable    ${Customer_Details}[Zip Code]
    ${Phone}=    Set Variable    ${Customer_Details}[Phone #]
    ${SSN}=    Set Variable    ${Customer_Details}[SSN]
    Set Global Variable    ${Username}    ${Customer_Details}[Username]
    Set Global Variable    ${Password}    ${Customer_Details}[Password]
    #${Confirm}=    Set Variable    ${Customer_Details}[Confirm]
    Input Text    ${FIRST_NAME_XPATH}    ${First_Name}
    Input Text    ${LAST_NAME_XPATH}    ${Last_Name}
    Input Text    ${ADDRESS_XPATH}    ${Address}
    Input Text    ${CITY_XPATH}    ${City}
    Input Text    ${STATE_XPATH}    ${State}
    Input Text    ${ZIP_CODE_XPATH}    ${Zip Code}
    Input Text    ${PHONE_XPATH}     ${Phone}
    Input Text    ${SSN_XPATH}    ${SSN}
    Input Text    ${USERNAME_XPATH}    ${Username}
    Input Password    ${PASSWORD_XPATH}    ${Password}
    Input Password    ${CONFIRM_PASSWORD_XPATH}    ${Confirm_Mismatch}


Error should be appear on register page
    [Arguments]    ${ERROR_MESSAGE}
    Wait Until Element Is Visible    ${REGISTER_ERROR_XPATH}    10s
    ${Error}=    Get Text    ${REGISTER_ERROR_XPATH}
    Should Be Equal    ${ERROR_MESSAGE}    ${Error}
    Capture Page Screenshot
