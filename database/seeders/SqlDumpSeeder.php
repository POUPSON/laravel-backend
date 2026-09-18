<?php

namespace Database\Seeders;

use Illuminate\Database\Console\Seeds\WithoutModelEvents;
use Illuminate\Database\Seeder;

use Illuminate\Support\Facades\DB;
use Illuminate\Support\Facades\File;

class SqlDumpSeeder extends Seeder
{
    public function run(): void
    {
        // base_path() pointe vers la racine du projet où se trouve ton fichier .sql
        $path = base_path('restaurant_backup.sql');
        
        if (File::exists($path)) {
            $sql = File::get($path);
            DB::unprepared($sql);
            $this->command->info('Base de données restaurée avec succès depuis le fichier SQL à la racine !');
        } else {
            $this->command->error('Fichier restaurant_backup.sql introuvable à la racine.');
        }
    }
}
