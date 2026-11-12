*** Settings ***
Documentation       Shared settings for every suite: the libraries, the site and the test data file.

Library             Collections
Library             DateTime
Library             String
Variables            ../Config/settings.py
Library             SeleniumLibrary    ${TIMEOUT}
Library             ../Libraries/excel_utils.py
Library             FakerLibrary    locale=en_US



*** Variables ***
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
