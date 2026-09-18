<?php

namespace App\Http\Controllers;

use App\Models\SousCategorie;
use Illuminate\Http\Request;

class SousCategorieController extends Controller
{
    public function index()
    {
        return SousCategorie::all();
    }

    public function store(Request $request)
    {
        $this->autoriserAdmin($request);

        $validated = $request->validate([
            'nom' => 'required|string|max:255',
            'type' => 'required|in:plat,boisson',
        ]);

        $sousCategorie = SousCategorie::create($validated);

        return response()->json($sousCategorie, 201);
    }

    public function show(string $id)
    {
        return SousCategorie::findOrFail($id);
    }

    public function update(Request $request, string $id)
    {
        $this->autoriserAdmin($request);

        $sousCategorie = SousCategorie::findOrFail($id);

        $validated = $request->validate([
            'nom' => 'sometimes|required|string|max:255',
            'type' => 'sometimes|required|in:plat,boisson',
        ]);

        $sousCategorie->update($validated);

        return response()->json($sousCategorie);
    }

    public function destroy(Request $request, string $id)
    {
        $this->autoriserAdmin($request);

        SousCategorie::findOrFail($id)->delete();

        return response()->json(['message' => 'Sous-catégorie supprimée.']);
    }

    private function autoriserAdmin(Request $request)
    {
        if ($request->user()->role !== 'admin') {
            abort(403, 'Accès réservé à l\'administrateur.');
        }
    }
}
