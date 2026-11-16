*** Settings ***
Documentation       Steps that cross pages. Here: prepare customer data and register a brand-new customer.

Resource            ../Resources/Common.resource
Resource            ../Resources/Register.resource


*** Keywords ***
Register New Customer From Excel
    [Documentation]    Registers the customer in the given Excel row under a fresh username,
    ...    saves the username and password back into the Excel row, and returns both.
    [Arguments]    ${row_id}
    &{customer}=    Get Customer Data    ${row_id}
    Add Fake Personal Details    ${customer}
    Open Register Page
    Fill Registration Form    ${customer}
    Submit Registration
    Register Page Should Show Welcome For    ${customer}[Username]
    Save Credentials    ${CUSTOMER_FILE}    ${SHEET}    ${row_id}    ${customer}[Username]    ${customer}[Password]
    RETURN    ${customer}[Username]    ${customer}[Password]

Get Customer Data
    [Documentation]    Reads one Excel row as a dictionary ready for the Register form.
    ...    Username: the one given, otherwise a fresh unique one.
    ...    Confirm: the one given, otherwise the same as Password.
    [Arguments]    ${row_id}    ${username}=${EMPTY}    ${confirm}=${EMPTY}
    &{customer}=    Get Row As Dictionary    ${CUSTOMER_FILE}    ${SHEET}    ${row_id}
    IF    not $username
        ${username}=    Make Unique Username
    END
    IF    not $confirm
        ${confirm}=    Get From Dictionary    ${customer}    Password
    END
    Set To Dictionary    ${customer}    Username=${username}    Confirm=${confirm}
    RETURN    ${customer}

Make Unique Username
    [Documentation]    Returns a username nobody has used before, e.g. raj1731050000482:
    ...    "raj", the seconds since 1970, and 3 random digits.
    ${seconds}=    Get Time    epoch
    ${digits}=    Generate Random String    3    [NUMBERS]
    RETURN    raj${seconds}${digits}

Add Fake Personal Details
    [Documentation]    Replaces the fixed Excel personal details with fresh fake ones.
    [Arguments]    ${customer}=None
    ${first}=    FakerLibrary.First Name
    ${last}=    FakerLibrary.Last Name
    ${street}=    FakerLibrary.Street Address
    ${city}=    FakerLibrary.City
    ${state}=    FakerLibrary.State
    ${zipcode}=    FakerLibrary.Zipcode
    ${phone}=    FakerLibrary.Basic Phone Number
    ${ssn}=    FakerLibrary.Ssn
    # your 6 lines: one per field
    Set To Dictionary    ${customer}
    ...    First Name=${first}
    ...    Last Name=${last}
    ...    Address=${street}
    ...    City=${city}
    ...    State=${state}
    ...    Zip Code=${zipcode}
    ...    Phone #=${phone}
    ...    SSN=${ssn}
    # your 6 lines: one pair per field

Get Account Numbers
    [Documentation]    Gives you Account Numbers
    [Arguments]    ${Before_Transfer}
    @{Numbers1}=    Get Dictionary Keys    ${Before_Transfer}
    ${Primary_Account}=    Set Variable    ${Before_Transfer}[${Numbers1}[0]][Account_Number]
    ${Secondary_Account}=    Set Variable    ${Before_Transfer}[${Numbers1}[1]][Account_Number]
    RETURN    ${Primary_Account}    ${Secondary_Account}

Remove String And Convert To The Number
    [Documentation]    Removing the Currency Sign and Converted Into Numbers
    ...    ${OBJ}=String To Be Used For Modify
    ...    ${String_To_Be_Removed1}=From ${OBJ} which string to Removed
    ...    Example: $145.05 will be Return as 145.05
    [Arguments]    ${OBJ}    ${String_To_Be_Removed1}    ${String_To_Be_Removed2}=None
    ${String}=    Remove String    ${OBJ}    ${String_To_Be_Removed1}    ${String_To_Be_Removed2}
    ${Number}=    Convert To Number    ${String}
    RETURN    ${Number}

Compare Before And After Bill Payment Amounts
    [Documentation]    Compares the balance of before and after a Bill Payment, ensuring correct amounts were debited.
    [Arguments]    ${Before_Transfer}    ${After_Transfer}    ${Amount}    ${From_Account}
    ${Before_From_Balance}=    Set Variable    ${Before_Transfer}[${From_Account}][Balance]
    ${After_From_Balance}=     Set Variable    ${After_Transfer}[${From_Account}][Balance]
    ${Before_From_Balance_Number}=    Remove String And Convert To The Number    ${Before_From_Balance}    $    ,
    ${After_From_Balance_Number}=    Remove String And Convert To The Number    ${After_From_Balance}    $    ,
    ${Expected_After_From_Balance}=    Evaluate    ${Before_From_Balance_Number} - ${Amount}
    Should Be Equal As Numbers    ${After_From_Balance_Number}    ${Expected_After_From_Balance}
