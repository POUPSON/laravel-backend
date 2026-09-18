<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class Commande extends Model
{
protected $fillable = ['user_id', 'numero_table', 'statut', 'total'];
    public function user()
{
    return $this->belongsTo(User::class);
}

public function detailCommandes()
{
    return $this->hasMany(DetailCommande::class);
}
}
