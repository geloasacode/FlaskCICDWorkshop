FROM python:3.11-alpine

RUN apk update

COPY ./app_folder /home/app-folder

RUN pip install flask

WORKDIR /home/app-folder

EXPOSE 8080

CMD ["python", "app.py"]
