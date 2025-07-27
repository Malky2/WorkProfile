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

# השורה הקריטית עם הדפסת שגיאות מלאה
RUN pip install --no-cache-dir -r requirements.txt || (echo "❌ pip install failed" && exit 1)

COPY . .

EXPOSE 5000

CMD ["python", "app.py"]
