<?php

namespace App\Http\Controllers;

use App\Models\Commande;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;
class StatistiqueController extends Controller
{
    public function index(Request $request)
    {
        if ($request->user()->role !== 'admin') {
            abort(403, 'Accès réservé à l\'administrateur.');
        }

        $periode = $request->query('periode', 'jour');

        $debut = match ($periode) {
            'semaine' => Carbon::now()->startOfWeek(),
            'mois' => Carbon::now()->startOfMonth(),
            default => Carbon::now()->startOfDay(),
        };

        $total = Commande::where('statut', 'payee')
            ->where('created_at', '>=', $debut)
            ->sum('total');

        $nombreCommandes = Commande::where('statut', 'payee')
            ->where('created_at', '>=', $debut)
            ->count();

        return response()->json([
            'periode' => $periode,
            'depuis' => $debut->toDateTimeString(),
            'total_ventes' => $total,
            'nombre_commandes' => $nombreCommandes,
        ]);
    }
 public function evolution(Request $request)
{
    if ($request->user()->role !== 'admin') {
        abort(403, 'Accès réservé à l\'administrateur.');
    }

    $periode = $request->query('periode', 'semaine');
    $decalage = (int) $request->query('decalage', 0); // 0 = actuel, -1 = précédent, +1 = suivant

    if ($periode === 'annee') {
        $annee = Carbon::now()->year + $decalage;

        $ventesParMois = Commande::selectRaw('MONTH(created_at) as mois, SUM(total) as total')
            ->where('statut', 'payee')
            ->whereYear('created_at', $annee)
            ->groupBy('mois')
            ->pluck('total', 'mois');

        $noms = ['Jan', 'Fév', 'Mar', 'Avr', 'Mai', 'Jun', 'Jul', 'Aoû', 'Sep', 'Oct', 'Nov', 'Déc'];

        $donnees = [];
        for ($m = 1; $m <= 12; $m++) {
            $donnees[] = [
                'label' => $noms[$m - 1],
                'total' => (float) ($ventesParMois[$m] ?? 0),
            ];
        }

        return response()->json([
            'annee' => $annee,
            'donnees' => $donnees,
        ]);
    }

    // Semaine, décalée du nombre de semaines demandé
    $debutSemaine = Carbon::now()->addWeeks($decalage)->startOfWeek();
    $finSemaine = $debutSemaine->copy()->endOfWeek();

    $ventesParJour = Commande::selectRaw('DATE(created_at) as jour, SUM(total) as total')
        ->where('statut', 'payee')
        ->whereBetween('created_at', [$debutSemaine, $finSemaine])
        ->groupBy('jour')
        ->pluck('total', 'jour');

    $joursNoms = ['Lun', 'Mar', 'Mer', 'Jeu', 'Ven', 'Sam', 'Dim'];
    $donnees = [];

    for ($i = 0; $i < 7; $i++) {
        $date = $debutSemaine->copy()->addDays($i);
        $cleDate = $date->format('Y-m-d');

        $donnees[] = [
            'label' => $joursNoms[$i],
            'total' => (float) ($ventesParJour[$cleDate] ?? 0),
        ];
    }

    return response()->json([
        'debut' => $debutSemaine->format('d/m'),
        'fin' => $finSemaine->format('d/m/Y'),
        'donnees' => $donnees,
    ]);
}
}
