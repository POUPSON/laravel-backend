FROM php:8.3-cli

# Installation des dépendances et de l'extension SQLite
RUN apt-get update && apt-get install -y \
    zip unzip git libsqlite3-dev \
    && docker-php-ext-install pdo pdo_sqlite

# Import de Composer
COPY --from=composer:latest /usr/bin/composer /usr/bin/composer

WORKDIR /var/www

COPY . .

# Installation des paquets Laravel
RUN composer install --no-dev --optimize-autoloader
RUN touch database/database.sqlite

EXPOSE 10000

# Exécution des migrations et lancement du serveur
CMD php artisan migrate --force && php artisan serve --host 0.0.0.0 --port ${PORT:-10000}
