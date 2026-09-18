<?php

namespace App\Http\Controllers;

use App\Models\Article;
use Illuminate\Http\Request;

class ArticleController extends Controller
{
    public function index()
    {
        return Article::with('sousCategorie')->paginate(15);
    }

    public function store(Request $request)
    {
        $this->autoriserAdmin($request);

        $validated = $request->validate([
            'nom' => 'required|string|max:255',
            'description' => 'nullable|string',
            'prix' => 'required|numeric|min:0',
            'sous_categorie_id' => 'required|exists:sous_categories,id',
            'disponible' => 'boolean',
        ]);

        $article = Article::create($validated);

        return response()->json($article->load('sousCategorie'), 201);
    }

    public function show(string $id)
    {
        return Article::with('sousCategorie')->findOrFail($id);
    }

    public function update(Request $request, string $id)
    {
        $this->autoriserAdmin($request);

        $article = Article::findOrFail($id);

        $validated = $request->validate([
            'nom' => 'sometimes|required|string|max:255',
            'description' => 'nullable|string',
            'prix' => 'sometimes|required|numeric|min:0',
            'sous_categorie_id' => 'sometimes|required|exists:sous_categories,id',
            'disponible' => 'boolean',
        ]);

        $article->update($validated);

        return response()->json($article->load('sousCategorie'));
    }

    public function destroy(Request $request, string $id)
    {
        $this->autoriserAdmin($request);

        Article::findOrFail($id)->delete();

        return response()->json(['message' => 'Article supprimé.']);
    }

    private function autoriserAdmin(Request $request)
    {
        if ($request->user()->role !== 'admin') {
            abort(403, 'Accès réservé à l\'administrateur.');
        }
    }
}
