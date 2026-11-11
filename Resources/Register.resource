*** Settings ***
Documentation    Register page: open the sign-up form, fill it, submit it, and check the result.

Resource    ../Resources/Common.resource


*** Variables ***
${REGISTER_LINK_XPATH}    //a[text()='Register']
${REGISTER_TITLE_XPATH}             //h1[@class='title']
${FIRST_NAME_XPATH}                 //input[contains(@id,'firstName')]
${LAST_NAME_XPATH}                  //input[contains(@id,'lastName')]
${ADDRESS_XPATH}                    //input[contains(@id,'street')]
${CITY_XPATH}                       //input[contains(@id,'city')]
${STATE_XPATH}                      //input[contains(@id,'state')]
${ZIP_CODE_XPATH}                   //input[contains(@id,'zipCode')]
${PHONE_XPATH}                      //input[contains(@id,'phoneNumber')]
${SSN_XPATH}                        //input[contains(@id,'ssn')]
${USERNAME_XPATH}                   //input[contains(@id,'username')]
${PASSWORD_XPATH}                   //input[contains(@id,'password')]
${CONFIRM_PASSWORD_XPATH}           //input[contains(@id,'repeatedPassword')]
${REGISTER_BUTTON_XPATH}            //input[contains(@value,'Register')]
${WELCOME_USERNAME_XPATH}           //div[@id='rightPanel']/h1[@class='title']
${ACCOUNT_CREATED_MESSAGE_XPATH}    //div[@id='rightPanel']/p
${CONFIRM_ERROR_XPATH}              //span[@id='repeatedPassword.errors']
${USERNAME_ERROR_XPATH}             //span[@id='customer.username.errors']
${ACCOUNT_CREATED_TEXT}             Your account was created successfully. You are now logged in.


*** Keywords ***
Open Register Page
    [Documentation]    Clicks Register and waits for the sign-up form.
    Wait Until Element Is Visible    ${REGISTER_LINK_XPATH}
    Click Element    ${REGISTER_LINK_XPATH}
    Wait Until Element Is Visible    ${REGISTER_TITLE_XPATH}
    Element Text Should Be    ${REGISTER_TITLE_XPATH}    Signing up is easy!

Fill Registration Form
    [Documentation]    Types the whole sign-up form from one customer dictionary. Does not submit.
    ...    Keys used: First Name, Last Name, Address, City, State, Zip Code, Phone #, SSN,
    ...    Username, Password, Confirm.
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

Submit Registration
    [Documentation]    Clicks the Register button at the bottom of the form.
    Wait Until Element Is Visible    ${REGISTER_BUTTON_XPATH}
    Click Element    ${REGISTER_BUTTON_XPATH}

Register Page Should Show Welcome For
    [Documentation]    Fails unless the page welcomes ${username} and confirms the account was created.
    [Arguments]    ${username}
    Wait Until Element Is Visible    ${WELCOME_USERNAME_XPATH}
    ${welcome}=    Get Text    ${WELCOME_USERNAME_XPATH}
    Should End With    ${welcome}    ${username}
    Element Text Should Be    ${ACCOUNT_CREATED_MESSAGE_XPATH}    ${ACCOUNT_CREATED_TEXT}

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
