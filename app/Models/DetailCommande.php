<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class DetailCommande extends Model
{
protected $fillable = ['commande_id', 'article_id', 'quantite', 'prix_unitaire'];
    public function commande()
{
    return $this->belongsTo(Commande::class);
}

public function article()
{
    return $this->belongsTo(Article::class);
}
}
