# Image commune à l'API et au site (environnement de développement).

# On part d'une image qui contient déjà Node.js 24.
FROM node:24-alpine

# Dossier de travail dans le conteneur.
WORKDIR /app

# Copie le projet (sauf ce qui est listé dans .dockerignore).
COPY . .

# Installe les dépendances exactes du package-lock.json.
RUN npm ci
