*** Settings ***
Documentation       Shared settings for every suite: the browser library, the site and the test data file.
Library             SeleniumLibrary    timeout=10s
Library    ../Libraries/excel_utils.py
Library    String


*** Variables ***
${URL}              https://parabank.parasoft.com/parabank/index.htm
${BROWSER}          chrome
${CUSTOMER_FILE}    ${CURDIR}/../Test Data/customer_data.xlsx
${SHEET}            Sheet1