*** Settings ***
Documentation            Check on the parabank Home Page.

Resource            ../Resources/Common.resource
Resource            ../Resources/HomeAndLogin.resource

Suite Setup          Open ParaBank
Suite Teardown       Close All Browsers
Test Setup           Start From Logged Out Home Page
Test Tags            home

*** Test Cases ***
Latest News Shows Today's Date
    [Documentation]    The date under "Latest News" should be equal to today's date as per Site Format.
    Latest News Should Be Today
