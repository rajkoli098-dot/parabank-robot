*** Settings ***
Resource    ../Resources/Common.resource

*** Variables ***
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
${CONFIRM_ERROR_XPATH}    //span[@id='repeatedPassword.errors']
${USERNAME_ERROR_XPATH}    //span[@id='customer.username.errors']



*** Keywords ***
Resgister A New Customer
    Wait Until Element Is Visible    ${RGISTER_XPATH}
    Click Element    ${RGISTER_XPATH}
    Wait Until Element Is Visible    ${REGISTER_TITLE_XPATH}
    ${Register_Message}=    Get Text    ${REGISTER_TITLE_XPATH}
    Should Be Equal    Signing up is easy!    ${Register_Message}

Filling Customer Related All Details
    &{Customer_Details}=    Get Row As Dictionary    ${CUSTOMER_FILE}    ${SHEET}    ${ROW_ID}
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
    [Arguments]    ${username}    ${MSG}
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
    &{Customer_Details}=    Get Row As Dictionary    ${CUSTOMER_FILE}    ${SHEET}    ${ROW_ID}
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


Register Page Should Show Confirm Error
    [Documentation]    Fails unless the Confirm field shows exactly the expected error text.
    [Arguments]    ${expected}
    Wait Until Element Is Visible    ${CONFIRM_ERROR_XPATH}
    Element Text Should Be    ${CONFIRM_ERROR_XPATH}    ${expected}

Register Page Should Show Username Error
    [Documentation]    Fails unless the Username field shows exactly the expected error text.
    [Arguments]    ${expected}
    Wait Until Element Is Visible    ${USERNAME_ERROR_XPATH}
    Element Text Should Be    ${USERNAME_ERROR_XPATH}    ${expected}

Fill Registration Form
    [Documentation]    Types the whole sign-up form from one customer dictionary. Does not submit.
    #Keys used: First Name, Last Name, Address, City, State, Zip Code, Phone #, SSN,
    #Username, Password, Confirm.
    [Arguments]    ${customer}
    Fill Personal Details    ${customer}
    Fill Login Details    ${customer}

Fill Personal Details
    [Documentation]    Types name, address, phone and SSN from the customer dictionary.
    [Arguments]    ${customer}
    Wait Until Element Is Visible    ${FIRST_NAME_XPATH}
    Input Text    ${FIRST_NAME_XPATH}    ${customer}[First Name]
    Input Text    ${LAST_NAME_XPATH}    ${customer}[Last Name]
    Input Text    ${ADDRESS_XPATH}    ${customer}[Address]
    Input Text    ${CITY_XPATH}    ${customer}[City]
    Input Text    ${STATE_XPATH}    ${customer}[State]
    Input Text    ${ZIP_CODE_XPATH}    ${customer}[Zip Code]
    Input Text    ${PHONE_XPATH}    ${customer}[Phone #]
    Input Text    ${SSN_XPATH}    ${customer}[SSN]

Fill Login Details
    [Documentation]    Types username, password and confirm password from the customer dictionary.
    [Arguments]    ${customer}
    Input Text    ${USERNAME_XPATH}    ${customer}[Username]
    Input Password    ${PASSWORD_XPATH}    ${customer}[Password]
    Input Password    ${CONFIRM_PASSWORD_XPATH}    ${customer}[Confirm]
