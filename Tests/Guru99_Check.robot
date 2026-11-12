*** Settings ***
Documentation    Temporary check that Robot can read the Windows Variables
Resource    ../Resources/Guru99.resource

*** Test Cases ***
Guru99 Variables Are Set
    [Documentation]    Passes when windows have the both the variables. Password stays hidden.
    Should Not Be Empty    ${GURU99_USER}
    Log    User is ${GURU99_USER}, Password is ${GURU99_PASSWORD}
    Log To Console    User is ${GURU99_USER}, Password is ${GURU99_PASSWORD}