<?php

namespace App\Http\Controllers;

use App\Models\Article;
use App\Models\Commande;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\DB;

class CommandeController extends Controller
{
    /**
     * Display a listing of the resource.
     */
   public function index(Request $request)
{
    $user = $request->user();

    $query = Commande::with(['user', 'detailCommandes.article']);

    if ($user->role !== 'admin') {
        $query->where('user_id', $user->id);
    }

    return $query->paginate(15);
}

    /**
     * Store a newly created resource in storage.
     */
    public function store(Request $request)
    {
        $validated = $request->validate([
            'numero_table' => 'required|string|max:50',
            'lignes' => 'required|array|min:1',
            'lignes.*.article_id' => 'required|exists:articles,id',
            'lignes.*.quantite' => 'required|integer|min:1',
        ]);

        $commande = DB::transaction(function () use ($validated, $request) {
            $commande = Commande::create([
                'user_id' => $request->user()->id,
                'numero_table' => $validated['numero_table'],
                'statut' => 'non_payee',
                'total' => 0,
            ]);

            $total = 0;

            foreach ($validated['lignes'] as $ligne) {
                $article = Article::findOrFail($ligne['article_id']);

                $commande->detailCommandes()->create([
                    'article_id' => $article->id,
                    'quantite' => $ligne['quantite'],
                    'prix_unitaire' => $article->prix,
                ]);

                $total += $article->prix * $ligne['quantite'];
            }

            $commande->update(['total' => $total]);

            return $commande;
        });

        return response()->json($commande->load('detailCommandes.article'), 201);
    }

    /**
     * Display the specified resource.
     */
    public function show(Request $request, string $id)
    {
        $commande = Commande::with('detailCommandes.article')->findOrFail($id);

        $this->autoriserAccesCommande($request, $commande);

        return $commande;
    }

    /**
     * Update the specified resource in storage.
     */
    public function update(Request $request, string $id)
{
    $commande = Commande::findOrFail($id);
    $user = $request->user();

    // L'admin peut tout modifier ; le serveur ne peut que changer le statut de SA commande
    if ($user->role !== 'admin') {
        if ($commande->user_id !== $user->id) {
            abort(403, 'Vous ne pouvez modifier que vos propres commandes.');
        }

        $validated = $request->validate([
            'statut' => 'required|in:payee,non_payee',
        ]);

        $commande->update($validated);

        return response()->json($commande);
    }

    // Admin : modification complète autorisée
    $validated = $request->validate([
        'numero_table' => 'sometimes|required|string|max:50',
        'statut' => 'sometimes|required|in:payee,non_payee',
    ]);

    $commande->update($validated);

    return response()->json($commande);
}
    /**
     * Remove the specified resource from storage.
     */
    public function destroy(Request $request, string $id)
    {
        $this->autoriserAdmin($request);

        Commande::findOrFail($id)->delete();

        return response()->json(['message' => 'Commande supprimée.']);
    }

    private function autoriserAdmin(Request $request)
    {
        if ($request->user()->role !== 'admin') {
            abort(403, 'Accès réservé à l\'administrateur.');
        }
    }

    private function autoriserAccesCommande(Request $request, Commande $commande)
    {
        $user = $request->user();

        if ($user->role !== 'admin' && $commande->user_id !== $user->id) {
            abort(403, 'Vous ne pouvez consulter que vos propres commandes.');
        }
    }
}
