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
