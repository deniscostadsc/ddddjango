FROM python:3

ENV PYTHONUNBUFFERED 1

RUN mkdir /code
WORKDIR /code

COPY requirements/ci.txt /code/
COPY requirements/production.txt /code/
RUN pip install -r ci.txt
