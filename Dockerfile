FROM python:3.10-slim

# התקנת ספריות מערכת
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libpq-dev \
    default-libmysqlclient-dev \
    python3-dev \
    curl \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
