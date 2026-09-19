<?php

use Illuminate\Support\Facades\Route;
use Illuminate\Support\Facades\Artisan;

Route::get('/', function () {
    return view('welcome');
});

// Route temporaire pour initialiser la base de données et créer l'utilisateur sur Render
Route::get('/run-migrations', function () {
    Artisan::call('migrate', ['--force' => true]);
    Artisan::call('db:seed', ['--force' => true]);
    return "Base de données initialisée et utilisateur créé avec succès !";
});
