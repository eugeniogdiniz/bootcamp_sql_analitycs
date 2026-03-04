# syntax = docker/dockerfile:1
FROM python:3.12-slim

WORKDIR /usr/app/northwind

# Instalar Dependências

COPY requirements.txt requirements.txt
RUN pip3 install -r requirements.txt

EXPOSE 8081

CMD tail -f /dev/null