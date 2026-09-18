<?php

namespace App\Models;

use Illuminate\Database\Eloquent\Model;

class SousCategorie extends Model
{
    protected $fillable = ['nom', 'type'];

    public function articles()
    {
        return $this->hasMany(Article::class);
    }
}
