*** Settings ***
Documentation        Contains Bill Payment Page all the Operations/Keywords

Resource             ../Resources/Common.resource
Resource             ../Resources/Flows.resource


*** Variables ***
${BILL_PAY_LINK_XPATH}                //a[text()='Bill Pay']
${BILL_PAY_TITLE_XPATH}               //h1[text()='Bill Payment Service']
${INPUT_NAME_XPATH}                   //input[@name='payee.name']
${INPUT_STREET_XPATH}                 //input[@name='payee.address.street']
${INPUT_CITY_XPATH}                   //input[@name='payee.address.city']
${INPUT_STATE_XPATH}                   //input[@name='payee.address.state']
${INPUT_ZIPCODE_XPATH}                //input[@name='payee.address.zipCode']
${INPUT_PHONENUMBER_XPATH}            //input[@name='payee.phoneNumber']
${INPUT_ACCOUNT_NUMBER_XPATH}         //input[@name='payee.accountNumber']
${INPUT_VERIFY_ACCOUNT_XPATH}         //input[@name='verifyAccount']
${INPUT_AMOUNT_XPATH}                 //input[@name='amount']
${BILL_FROM_ACCOUNT_XPATH}            //select[@name='fromAccountId']
${BILL_FROM_ACCOUNT_OPTIONS_XPATH}    //select[@name='fromAccountId']/option
${SEND_PAYMENT_BUTTON_XPATH}          //input[@class='button' and @value='Send Payment']
${BILL_PAYMENT_TITLE_XPATH}           //h1[text()='Bill Payment Complete']
${AMOUNT_TEXT_XPATH}                  //span[@id='amount']
${ACCOUNT_TEXT_XPATH}                 //span[@id='fromAccountId']
${VALIDATION_ERROR_XPATH}             //span[contains(@id,'validationModel') and not(@style='display:none')]
${EMPTY_FIELD_XPATH}                  //span[contains(@id,'validationModel') and not(@style='display:none')]/ancestor
...                                   ::tr/td/b

*** Keywords ***
Click On Bill Pay Link
    [Documentation]    Clicks On Bill Pay Link
    Wait Until Element Is Visible    ${BILL_PAY_LINK_XPATH}
    Click Element    ${BILL_PAY_LINK_XPATH}
    Wait Until Element Is Visible    ${BILL_PAY_TITLE_XPATH}

Enter Payee Information
    [Documentation]    Fills the Dummy Payee Information
    &{customer}=    Add Fake Payee Details
    Fill Payee Details    ${customer}

Enter Payee Account, Payee Amount And From Account
    [Documentation]    Fills the Payee Account, Amount and Select the Account from which Bill will be pay.
    [Arguments]    ${Payee_Account}    ${Confirm_Payee_Account}    ${Payee_Amount}    ${Primary_Account}
    Input Text    ${INPUT_ACCOUNT_NUMBER_XPATH}    ${Payee_Account}
    Input Text    ${INPUT_VERIFY_ACCOUNT_XPATH}    ${Confirm_Payee_Account}
    Input Text    ${INPUT_AMOUNT_XPATH}     ${Payee_Amount}
    Wait Until Element Is Visible    ${BILL_FROM_ACCOUNT_OPTIONS_XPATH}
    Select From List By Label    ${BILL_FROM_ACCOUNT_XPATH}    ${Primary_Account}

Send Payment
    [Documentation]    Clicks on Send Payment Button
    Wait Until Element Is Visible    ${SEND_PAYMENT_BUTTON_XPATH}
    Click Element    ${SEND_PAYMENT_BUTTON_XPATH}

Bill Payment Completion
    [Documentation]    Bill Payment Completed confirmation Message and Amount & Account used will be visible.
    [Arguments]    ${Payee_Amount}    ${Primary_Account}
    Wait Until Element Is Visible    ${BILL_PAYMENT_TITLE_XPATH}
    ${Message_Amount}=    Get Text    ${AMOUNT_TEXT_XPATH}
    ${Message_Account}=    Get Text    ${ACCOUNT_TEXT_XPATH}
    ${Message_Amount_Number}=    Remove String And Convert To The Number    ${Message_Amount}    $    ,
    ${Message_Account_Number}=    Convert To Number    ${Message_Account}
    Should Be Equal As Numbers    ${Message_Amount_Number}    ${Payee_Amount}
    Should Be Equal As Numbers    ${Message_Account_Number}    ${Primary_Account}


Add Fake Payee Details
    [Documentation]    Add Payee details with fake ones.
    ${payee}=    FakerLibrary.Name
    ${street}=    FakerLibrary.Street Address
    ${city}=    FakerLibrary.City
    ${state}=    FakerLibrary.State
    ${zipcode}=    FakerLibrary.Zipcode
    ${phone}=    FakerLibrary.Basic Phone Number
    ${customer}=    Create Dictionary
    Set To Dictionary    ${customer}
    ...    Payee Name=${payee}
    ...    Address=${street}
    ...    City=${city}
    ...    State=${state}
    ...    Zip Code=${zipcode}
    ...    Phone #=${phone}
    RETURN    ${customer}

Fill Payee Details
    [Documentation]    Fill the Payee All Details
    [Arguments]    ${customer}
    Input Text    ${INPUT_NAME_XPATH}    ${customer}[Payee Name]
    Input Text    ${INPUT_STREET_XPATH}    ${customer}[Address]
    Input Text    ${INPUT_CITY_XPATH}    ${customer}[City]
    Input Text    ${INPUT_STATE_XPATH}    ${customer}[State]
    Input Text    ${INPUT_ZIPCODE_XPATH}    ${customer}[Zip Code]
    Input Text    ${INPUT_PHONENUMBER_XPATH}    ${customer}[Phone #]

Fill Mismatch Account And Confirm Account
    [Documentation]    Fills the mismatch value in Account and Confirm Account Field
    [Arguments]    ${Payee_Account}    ${Confirm_Payee_Account}
    Input Text    ${INPUT_ACCOUNT_NUMBER_XPATH}    ${Payee_Account}
    Input Text    ${INPUT_VERIFY_ACCOUNT_XPATH}    ${Confirm_Payee_Account}


Error Recieved For Each Field
    [Documentation]    Maps field names with their validation error messages.
    &{All_Errors}=    Create Dictionary
    @{Errors}=    Get WebElements    ${VALIDATION_ERROR_XPATH}
    @{Fields}=    Get WebElements    ${EMPTY_FIELD_XPATH}
    ${Field_Count}=    Get Length    ${Fields}
    ${Error_Count}=    Get Length    ${Errors}
    Should Be Equal As Integers    ${Field_Count}    ${Error_Count}
    FOR    ${Field}    ${Error}    IN ZIP    ${Fields}    ${Errors}
        ${Field_Name}=    Get Text    ${Field}
        ${Error_Message}=    Get Text    ${Error}
        Set To Dictionary    ${All_Errors}    ${Field_Name}    ${Error_Message}
    END
    Log    ${All_Errors}
