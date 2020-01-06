*** Settings ***

Documentation   Importing web and robotframework built-in keywords.
Library  SeleniumLibrary   timeout=10  #run_on_failure=CapturePageScreenShot
Library      XvfbRobot
Library    OperatingSystem
Library    FakerLibrary

*** Variables ***
#${STAGING_PAGE URL}         https://security-scorecard-online-stor.herokuapp.com
#${TEST_PAGE URL}         http://localhost:8000
${PAGE URL}         https://security-scorecard-online-stor.herokuapp.com

${BROWSER}        chrome
${DELAY}          0.5

*** Keywords ***
#########################################################

I Open Browser To main page
    Run Keyword If      '${BROWSER}' == 'HeadlessChrome'      Open Headless Chrome Browser to Page
    ...     ELSE IF     '${BROWSER}' == 'HeadlessFirefox'     Firefox true headless
    ...     ELSE     Open Browser to Page
    Set Selenium Speed    ${DELAY}

Open Headless Chrome Browser to Page
    ${chrome_options}=    Evaluate    sys.modules['selenium.webdriver'].ChromeOptions()    sys
    Call Method    ${chrome_options}    add_argument    test-type
    Call Method    ${chrome_options}    add_argument    --disable-extensions
    Call Method    ${chrome_options}    add_argument    --headless
    Call Method    ${chrome_options}    add_argument    --disable-gpu
    Call Method    ${chrome_options}    add_argument    --no-sandbox
    Create Webdriver    Chrome    chrome_options=${chrome_options}
    Set Window Size    1920    1080
#    Run Keyword If      "${APP_ENV}" == "test"      Set Global Variable        ${PAGE URL}    ${TEST_PAGE URL}
#    Run Keyword If      "${APP_ENV}" == "staging"      Set Global Variable        ${PAGE URL}    ${STAGING_PAGE URL}
    Go To    ${PAGE URL}
    Main Page Should Be Opened

Firefox true headless
    ${firefox options}=     Evaluate    sys.modules['selenium.webdriver'].firefox.webdriver.Options()    sys, selenium.webdriver
    Call Method    ${firefox options}   add_argument    -headless
    Create Webdriver    Firefox    firefox_options=${firefox options}
    Set Window Size    1920    1080
    Go To    ${PAGE URL}
    Page Should Be Open

Main Page Should Be Opened
    [Documentation]
    Title Should Be    Products

Open Browser to Page
    [Documentation]
    Open Browser    ${PAGE URL}    ${BROWSER}
    Maximize Browser Window
    Set Selenium Speed    ${DELAY}
    Main Page Should Be Opened

I add product "${link}" to cart
    [Documentation]
    click link    ${link}
    click button Add to cart

I remove "${expected}" from cart
    [Documentation]
    ${row count}=    Get Element Count    xpath=//*[@id="content"]/table/tbody/tr
    ${index}    Set Variable     1
    : FOR    ${index}    IN    ${row count}
    \    ${value}=    Get Table Cell     xpath=//*[@id="content"]/table    ${index}    2
    \    Run Keyword If    '${value}'== '${expected}'    click element     xpath=//*[@id="content"]/table/tbody/tr[2]/td[4]/a
    \    ${index}=    Evaluate    ${index}+1
    \    exit for loop if    ${index} == ${row count}

I place order
    [Documentation]
    ${name}=    FakerLibrary.Name
    ${email}=    FakerLibrary.Email
    ${city}=    FakerLibrary.City
    ${postcode}=    FakerLibrary.Postcode
    ${address}=    FakerLibrary.Address
    Wait Until Element Is Visible    css=#id_first_name
    click element     css=#id_first_name
    Input Text     css=#id_first_name     ${name}
    Input Text     css=#id_last_name    ${name}
    Input Text     css=#id_email    ${email}
    Input Text     css=#id_address    ${address}
    Input Text     css=#id_postal_code    ${postcode}
    Input Text     css=#id_city    ${city}
    click button Place order

user notes the order number
    [Documentation]
    wait until page contains    Your order has been successfully completed. Your order number is
    ${order id}=    Get Text    xpath=//*[@id="content"]/p/strong
    Set Suite Variable    ${order id}    ${order id}

user navigates to admin page
    [Documentation]
    Goto     ${PAGE URL}/admin
    Input Text     css=#id_username    admin
    Input Text     css=#id_password    admin
    click button Log in

I search for order by id ${order id}
    [Documentation]
    wait until page contains element    css=#searchbar
    Input Text     css=#searchbar    ${order id}
    click button Search

click button ${label}
    [Documentation]
    click element     xpath=//*[@value="${label}" and contains(@type, "submit")]

select and deleted filtered item
    click element     name=_selected_action
    #Delete selected item
    Click element    css=#changelist-form > div.actions > label > select
    click element    css=#changelist-form > div.actions > label > select > option:nth-child(2)

    # click Go click button
    click element    css=#changelist-form > div.actions > button
    click button Yes, I'm sure


I navigate to orders page
    Goto     ${PAGE URL}/admin/orders/order/

