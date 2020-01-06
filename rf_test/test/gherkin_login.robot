*** Settings ***
Documentation     Test suite as a demo task for Secure score card QA position
...               Prepare automated tests on UI level:
...               Test 1: Order Product
...                 Step 1: add product A and B to a cart
...                 Step 2: Remove A &amp; add C
...                 Step 3: Submit order for products A and C
...               Test 2: Delete order
...                 Step 1: Query product on id
...                 Step 2: Delete order

Resource          ../resource/keywords/web_app_keywords.robot

Suite Teardown    Close Browser

*** Test Cases ***
Order Product
    Given I Open Browser To main page
    And I add product "pilsner" to cart
    And click link    Continue shopping
    And I add product "Guiness" to cart
    And I remove "Guiness" from cart
    And click link    Continue shopping
    And I add product "Gambrinus" to cart
    When click link    Checkout
    And Wait Until Page Contains    1x pilsner
    And Wait Until Page Contains    1x Gambrinus
    And I place order

Delete
    Given user notes the order number
    And user navigates to admin page
    And I navigate to orders page
    When I search for order by id ${order id}
    And select and deleted filtered item
    And Wait Until Page Contains    Successfully deleted 1 order.


