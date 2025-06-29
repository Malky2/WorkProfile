# --- שלב ראשון: בנייה ---
FROM python:3.9-bullseye AS builder

RUN apt-get update && apt-get install -y \
    gcc \
    default-libmysqlclient-dev \
    build-essential \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

COPY static/ static/
COPY templates/ templates/
COPY app.py dbcontext.py person.py ./

# --- שלב שני: הפצה רזה ---
FROM python:3.9-alpine

RUN apk add --no-cache mariadb-connector-c libstdc++

WORKDIR /app

COPY --from=builder /install /usr/local
COPY --from=builder /app /app

EXPOSE 8080
CMD ["python", "app.py"]
