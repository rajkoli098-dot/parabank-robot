*** Settings ***
Documentation       Shared settings for every suite: the libraries, the site and the test data file.

Library             Collections
Library             String
Library             SeleniumLibrary    timeout=10s
Library             ../Libraries/excel_utils.py


*** Variables ***
${URL}              https://parabank.parasoft.com/parabank/index.htm
${BROWSER}          chrome
${CUSTOMER_FILE}    ${CURDIR}/../Test Data/customer_data.xlsx
${SHEET}            Sheet1


*** Keywords ***
Open ParaBank
    [Documentation]    Opens the browser on the ParaBank home page. Used once per suite.
    Open Browser    ${URL}    ${BROWSER}
    Maximize Browser Window

Start From Logged Out Home Page
    [Documentation]    Forgets any login and returns to the home page. Used before every test.
    Delete All Cookies
    Go To    ${URL}
