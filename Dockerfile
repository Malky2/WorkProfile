FROM python:3.10-slim

RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libpq-dev \
    default-libmysqlclient-dev \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

# הוספת שורת הדפסה לבדיקת הקובץ
RUN echo "------ CONTENTS OF requirements.txt ------" && cat requirements.txt

# מתקין כל שורה בנפרד כדי לגלות את הבעיה
RUN pip install blinker==1.7.0 \
    && pip install click==8.1.7 \
    && pip install colorama==0.4.6 \
    && pip install Flask==3.0.0 \
    && pip install itsdangerous==2.1.2 \
    && pip install Jinja2==3.1.2 \
    && pip install MarkupSafe==2.1.3 \
    && pip install mysql-connector-python==8.2.0 \
    && pip install mysqlclient==2.2.1 \
    && pip install packaging==23.2 \
    && pip install protobuf==4.21.12 \
    && pip install Werkzeug==3.0.1 \
    && pip install gunicorn==21.2.0 \
    && pip install psycopg2-binary==2.9.10


COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
