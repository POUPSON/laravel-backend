<?php

namespace Database\Seeders;

use App\Models\SousCategorie;
use Illuminate\Database\Seeder;

class SousCategorieSeeder extends Seeder
{
    public function run(): void
    {
        $sousCategories = [
            ['nom' => 'Amuses-bouches', 'type' => 'plat'],
            ['nom' => 'Entrées', 'type' => 'plat'],
            ['nom' => 'Plats principaux', 'type' => 'plat'],
            ['nom' => 'Desserts', 'type' => 'plat'],
            ['nom' => 'Jus naturels', 'type' => 'boisson'],
            ['nom' => 'Bières', 'type' => 'boisson'],
            ['nom' => 'Vins', 'type' => 'boisson'],
            ['nom' => 'Eaux', 'type' => 'boisson'],
        ];

        foreach ($sousCategories as $sc) {
            SousCategorie::create($sc);
        }
    }
}
