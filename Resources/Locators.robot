*** Variables ***
${ACC_NO}    14787

# W1
${W1_USERNAME_XPATH}    //input[@name='username']
${W1_PASSWORD_XPATH}    //input[@name='password']
# W2
${W2_LOGIN_XPATH}    //input[@value='Log In']
# W3
${W3_RGISTER_FULL_TEXT_XPATH}    //a[text()='Register']
${W3_RGISTER_PART_TEXT_XPATH}    //a[contains(text(),'Regi')]
# W4
${W4_PARABANK_LOGO_XPATH}    //img[@title='ParaBank']
# W5
${W5_CONTACT_US_XPATH}    //a[text()='Contact Us']

# G1
${G1_DATE_XPATH}    //h4[text()='Latest News']/following-sibling::ul/li[@class='captionthree']
# G2
${G2_TRANSFER_FUNDS_XPATH}    //li[text()='Online Services']/following-sibling::li/a[text()='Transfer Funds']
# G3
${G3_ATM_SERVICES_LIST_XPATH}    //li[text()='ATM Services']/following-sibling::li/a
# G4
${G4_ZIP_CODE_INPUT_XPATH}    //b[text()='Zip Code:']/parent::td/following-sibling::td/input
# G5
${G5_ABOUT_XPATH}    //a[translate(text(), 'ABCDEFGHIJKLMNOPQRSTUVWXYZ', 'abcdefghijklmnopqrstuvwxyz')='about']

# B1
${B1_BALANCE_XPATH}    //a[text()='${ACC_NO}']/parent::td/following-sibling::td[1]
# B2
${B2_TOTAL_BALANCE_XPATH}    //b[text()='Total']/parent::td/following-sibling::td[1]
# B3
${B3_TRANSFER_FUNDS_XPATH}    //select[normalize-space(preceding-sibling::text()[1])='From account #']/option[text()='${ACC_NO}']
# B4
${B4_CELL_DEBIT_XPATH}    //th[normalize-space()='Debit (-)']/ancestor::table//tbody/tr/td[count(//th[normalize-space()='Debit (-)']/preceding-sibling::th)+1]
# B5
${B5_CUST_DROPDOWN_XPATH}    //select[@ng-model='custId']
