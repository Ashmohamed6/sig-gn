# Dockerfile pour le backend Django SIG GN
FROM python:3.12-slim

# Ne pas générer de .pyc et log flush direct
ENV PYTHONDONTWRITEBYTECODE=1
ENV PYTHONUNBUFFERED=1

# Dossier de travail dans le conteneur
WORKDIR /app

# Dépendances système (psycopg2 + postgresql-client pour wait-for-db)
RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        build-essential \
        libpq-dev \
        postgresql-client && \
    rm -rf /var/lib/apt/lists/*

# Installer les dépendances Python
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier le code du projet
COPY . .

# Rendre le script wait-for-db exécutable
RUN chmod +x wait-for-db.sh

# Port exposé par Django
EXPOSE 8000

# Commande par défaut : serveur de dev
CMD ["python", "manage.py", "runserver", "0.0.0.0:8000"]