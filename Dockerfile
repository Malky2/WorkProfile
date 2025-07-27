FROM python:3.10

RUN apt-get update && apt-get install -y \
    default-libmysqlclient-dev \
    libpq-dev

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
