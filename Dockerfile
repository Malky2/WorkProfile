# שלב 1: בסיס יציב יותר עם כל מה שצריך
FROM python:3.9-bullseye

# שלב 2: התקנת חבילות מערכת
RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    build-essential \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# שלב 3: תיקיית עבודה
WORKDIR /app

# שלב 4: התקנת חבילות פייתון
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# שלב 5: קבצי אפליקציה
COPY static/ static/
COPY templates/ templates/
COPY app.py dbcontext.py person.py ./

# שלב 6: פורט ואפליקציה
EXPOSE 8080
CMD ["python", "app.py"]
