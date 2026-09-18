<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Article extends Model
{
    protected $fillable = ['nom', 'description', 'prix', 'sous_categorie_id', 'disponible'];

    public function sousCategorie()
    {
        return $this->belongsTo(SousCategorie::class);
    }

    public function detailCommandes()
    {
        return $this->hasMany(DetailCommande::class);
    }
}
