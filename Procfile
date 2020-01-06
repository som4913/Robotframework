release: python manage.py makemigrations
release: python manage.py migrate
web: gunicorn myshop.wsgi:application --log-file -
