# Restau Manager — Back-end (API Laravel)

API REST du projet de gestion de restaurant, développée avec Laravel 13. Consommée par le front-end React : [laravel-frontend](https://github.com/POUPSON/laravel-frontend).

## Technologies

Laravel 13 (PHP 8.3), Laravel Sanctum, MySQL, Eloquent.

## Fonctionnalités

- Authentification par rôle (admin / serveur)
- CRUD menu (articles + sous-catégories)
- Gestion des commandes (création, lignes, statut de paiement)
- Statistiques de ventes (par période, par serveur)
- Gestion des utilisateurs

## Installation

\`\`\`bash
git clone git@github.com:POUPSON/laravel-backend.git
cd laravel-backend
composer install
cp .env.example .env
php artisan key:generate
\`\`\`

Configurer la base de données dans `.env`, puis :

\`\`\`bash
php artisan migrate
php artisan serve --port=8001
\`\`\`

⚠️ Le port **8001** est obligatoire, c'est celui attendu par le front-end.

## Auteur

NTAGNE FONKAM CHRISTIAN CAMILLE
