FROM python:3.11-alpine

RUN apk update

COPY ./app_folder /home/app-folder

RUN pip install flask

WORKDIR /home/app-folder

ENV APP_COLOR=red
ENV VERSION=v3

EXPOSE 8080

CMD ["python", "app.py"]
