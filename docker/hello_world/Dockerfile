FROM python:3.8

RUN groupadd -r python_app && useradd --no-log-init -r -g python_app python_app

WORKDIR /app
COPY ./hello_world .

RUN pip install -r requirements.txt
EXPOSE 8080

USER python_app
CMD ["python","app.py"]