<?php

use App\Http\Controllers\ArticleController;
use App\Http\Controllers\AuthController;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Route;
use App\Http\Controllers\CommandeController;
use App\Http\Controllers\StatistiqueController;
use App\Http\Controllers\SousCategorieController;
use App\Http\Controllers\UserController;
// Routes publiques (authentification)
Route::post('/login', [AuthController::class, 'login']);

// Routes protégées (authentification requise)
Route::middleware('auth:sanctum')->group(function () {
    Route::get('/user', function (Request $request) {
        return $request->user();
    });

    Route::post('/logout', [AuthController::class, 'logout']);

   
    Route::apiResource('articles', ArticleController::class);
    
    Route::apiResource('commandes', CommandeController::class);
    Route::apiResource('sous-categories', SousCategorieController::class);
    
    Route::get('/statistiques', [StatistiqueController::class, 'index']);
    Route::apiResource('users', UserController::class)->except(['show']);
    Route::get('/statistiques/evolution', [StatistiqueController::class, 'evolution']);
});
