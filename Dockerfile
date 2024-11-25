# Image PHP avec support FPM
FROM php:8.1-fpm

# Installer les dépendances système et extensions PHP
RUN apt-get update && apt-get install -y \
    git \
    zip \
    unzip \
    libpq-dev \
    && docker-php-ext-install -j$(nproc) pdo pdo_pgsql \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Installer Composer
COPY --from=composer:2 /usr/bin/composer /usr/bin/composer

# Configuration PHP pour la production
RUN mv "$PHP_INI_DIR/php.ini-production" "$PHP_INI_DIR/php.ini"

# Définir le dossier de travail
WORKDIR /var/www/gestion_note_backend

# Copier composer.json et composer.lock
COPY composer.json composer.lock ./

# Installer les dépendances
RUN composer install --no-scripts --no-autoloader

# Copier le reste du code
COPY . .

# Créer le dossier var et définir les permissions
RUN mkdir -p var/cache var/log \
    && chown -R www-data:www-data var/cache var/log \
    && chmod -R 777 var/cache var/log

# Finaliser Composer
RUN composer dump-autoload --optimize

EXPOSE 8000

# Commande par défaut pour démarrer Symfony (en mode dev)
CMD ["php", "-S", "0.0.0.0:8000", "-t", "public"]
