FROM python:3

ENV PYTHONUNBUFFERED 1

RUN mkdir /code
WORKDIR /code

COPY requirements/production.txt /code/
RUN pip install -r production.txt

COPY src/ /code/

CMD python manage.py runserver 0.0.0.0:8000
