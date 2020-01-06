# security-scorecard-online-store

> Django project

Part 1: UI App Coding
Write a small UI online shop application where:

    a. Min 3 products offered
    b. A user can add a product to a cart
    c. A user can modify the cart 
        - add / remove products
    d. A user can submit a purchase
    app displays:
        - a msg about successful purchase
        - an “id” of the order
    e. A user can query the order using id
        - app displays ordered products
    f. A user can delete the order
        - app displays confirmation of the deletion

**Notes**:
- app saves orders persistently
- out of scope:
    - user authentication / user account
    - payment(Visa, MasterCard..) and shipment

**Part 2: UI App Testing**

Prepare automated tests on UI level:

    Test 1: Order Product
    Step 1: add product A and B to a cart
    Step 2: Remove A & add C
    Step 3: Submit order for products A and C
    
Test 2: Delete order

    Step 1: Query product on id
    Step 2: Delete order
    Part 3: Delivery
    
**Part 3: Delivery**

Delivery pipeline shall meet following requirements:

    source code in GitHub
    there is an automated mechanism triggered by a code change that:
    builds an app package
    deploys app on local or in cloud (eg AWS)
    runs automated tests and offer a run report

Part 4: Doc
	
Prepare:

    a short guide / readme with instructions how to build app, deploy and run tests.
    a short description of the solution

Notes: if not written otherwise use any coding language, tools, etc.
   

## Build Setup
Tested on ubuntu 18.04, Python 3.6.7

### initial setup

``` bash
$ sudo apt install redis-server
$ pip install requirements.txt
$  python manage.py makemigrations
$  python manage.py migrate
$  python manage.py createsuperuser   #follow the prompt and create super user with credential admin/admin
$  python manage.py runserver
#login at localhost:8000/admin with credentials admin/admin

## Setting up automated test with robot framework
  $ apt-get update && apt-get install --quiet --assume-yes python-dev python-pip unzip wget
  $ echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list
  $ wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add -
  $ apt update
  $ apt install -y google-chrome-stable
  $ CHROMEDRIVER_VERSION=`wget --no-verbose --output-document - https://chromedriver.storage.googleapis.com/LATEST_RELEASE`
  $ wget --no-verbose --output-document /tmp/chromedriver_linux64.zip http://chromedriver.storage.googleapis.com/$CHROMEDRIVER_VERSION/chromedriver_linux64.zip
  $ unzip -qq /tmp/chromedriver_linux64.zip -d /opt/chromedriver
  $ chmod +x /opt/chromedriver/chromedriver
  $ ln -fs /opt/chromedriver/chromedriver /usr/local/bin/chromedriver
  $ robot -v BROWSER:HeadlessChrome -v APP_ENV:test -d rf_test/reports rf_test/test
``` 
**Note**: this test will run in headless mode if you need browser test comment out line 18 in the keyword file

**Other information**
- Deployment and test execution are on gitlab ci
- latest test artifacts can be accessed on:
    - https://sejuba1.gitlab.io/security-scorecard-online-store/log.html
    - https://sejuba1.gitlab.io/security-scorecard-online-store/report.html
    - https://sejuba1.gitlab.io/security-scorecard-online-store/output.xml
- older artifacts can be downloaded directly from the gitlab pipeline history ( this can also be emailed or sent to slackor uploaded somewhere in future)
- application is deployed to horeku  https://security-scorecard-online-stor.herokuapp.com/

**Known issues**:
- product image not resized :D
- errors in logs deploying to horecku "/app/.heroku/python/lib/python3.6/site-packages/django_heroku/core.py", line 99, in settings config['MIDDLEWARE'] = tuple(['whitenoise.middleware.WhiteNoiseMiddleware'] + list(config['MIDDLEWARE']))

