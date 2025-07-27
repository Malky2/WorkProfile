FROM python:3.10-slim

# שלב 1: התקנת ספריות מערכת שחסרות להרצת mysqlclient, psycopg2 ו־gunicorn
RUN apt-get update && apt-get install -y \
    build-essential \
    gcc \
    libpq-dev \
    default-libmysqlclient-dev \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# שלב 2: יצירת תיקייה לאפליקציה
WORKDIR /app

# שלב 3: העתקת דרישות
COPY requirements.txt .

# שלב 4: התקנת הספריות
RUN pip install --upgrade pip
RUN pip install --no-cache-dir -r requirements.txt

# שלב 5: העתקת שאר הקבצים
COPY . .

# שלב 6: פתיחת פורט
EXPOSE 5000

# שלב 7: הרצת האפליקציה
CMD ["python", "app.py"]
