<?php

namespace App\Http\Controllers;

use App\Models\Commande;
use Illuminate\Http\Request;
use Illuminate\Support\Carbon;

class StatistiqueController extends Controller
{
    /**
     * Récupère les IDs des serveurs sélectionnés.
     *
     * Exemple :
     * ?serveurs[]=2&serveurs[]=5
     */
    private function getServeurs(Request $request)
    {
        $serveurs = $request->query('serveurs', []);

        if (!is_array($serveurs)) {
            $serveurs = [$serveurs];
        }

        return collect($serveurs)
            ->filter(fn($id) => is_numeric($id))
            ->map(fn($id) => (int) $id)
            ->unique()
            ->take(2)
            ->values();
    }

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

        $serveurs = $this->getServeurs($request);

        $query = Commande::where('statut', 'payee')
            ->where('created_at', '>=', $debut);

        // Filtre serveur
        if ($serveurs->isNotEmpty()) {
            $query->whereIn('user_id', $serveurs);
        }

        $total = (clone $query)->sum('total');

        $nombreCommandes = (clone $query)->count();

        return response()->json([
            'periode' => $periode,
            'depuis' => $debut->toDateTimeString(),
            'total_ventes' => $total,
            'nombre_commandes' => $nombreCommandes,
            'serveurs' => $serveurs,
        ]);
    }


    public function evolution(Request $request)
    {
        if ($request->user()->role !== 'admin') {
            abort(403, 'Accès réservé à l\'administrateur.');
        }

        $periode = $request->query('periode', 'semaine');
        $decalage = (int) $request->query('decalage', 0);

        $serveurs = $this->getServeurs($request);

        /*
        |--------------------------------------------------------------------------
        | ANNÉE
        |--------------------------------------------------------------------------
        */

        if ($periode === 'annee') {

            $annee = Carbon::now()->year + $decalage;

            $noms = [
                'Jan',
                'Fév',
                'Mar',
                'Avr',
                'Mai',
                'Jun',
                'Jul',
                'Aoû',
                'Sep',
                'Oct',
                'Nov',
                'Déc'
            ];

            /*
             * CAS 1 : Tous les serveurs
             */
            if ($serveurs->isEmpty()) {

                $ventesParMois = Commande::selectRaw(
                    'MONTH(created_at) as mois, SUM(total) as total'
                )
                    ->where('statut', 'payee')
                    ->whereYear('created_at', $annee)
                    ->groupBy('mois')
                    ->pluck('total', 'mois');

                $donnees = [];

                for ($m = 1; $m <= 12; $m++) {
                    $donnees[] = [
                        'label' => $noms[$m - 1],
                        'total' => (float) ($ventesParMois[$m] ?? 0),
                    ];
                }

                return response()->json([
                    'annee' => $annee,
                    'mode' => 'global',
                    'donnees' => $donnees,
                ]);
            }

            /*
             * CAS 2 : Un ou deux serveurs
             */

            $donnees = [];

            for ($m = 1; $m <= 12; $m++) {

                $ligne = [
                    'label' => $noms[$m - 1],
                    'serveurs' => [],
                ];

                foreach ($serveurs as $serveurId) {

                    $total = Commande::where('statut', 'payee')
                        ->where('user_id', $serveurId)
                        ->whereYear('created_at', $annee)
                        ->whereMonth('created_at', $m)
                        ->sum('total');

                    $ligne['serveurs'][] = [
                        'id' => $serveurId,
                        'total' => (float) $total,
                    ];
                }

                $donnees[] = $ligne;
            }

            return response()->json([
                'annee' => $annee,
                'mode' => 'serveurs',
                'serveurs' => $serveurs,
                'donnees' => $donnees,
            ]);
        }


        /*
        |--------------------------------------------------------------------------
        | SEMAINE
        |--------------------------------------------------------------------------
        */

        $debutSemaine = Carbon::now()
            ->addWeeks($decalage)
            ->startOfWeek();

        $finSemaine = $debutSemaine->copy()->endOfWeek();

        $joursNoms = [
            'Lun',
            'Mar',
            'Mer',
            'Jeu',
            'Ven',
            'Sam',
            'Dim'
        ];


        /*
         * CAS 1 : Tous les serveurs
         */

        if ($serveurs->isEmpty()) {

            $ventesParJour = Commande::selectRaw(
                'DATE(created_at) as jour, SUM(total) as total'
            )
                ->where('statut', 'payee')
                ->whereBetween('created_at', [
                    $debutSemaine,
                    $finSemaine
                ])
                ->groupBy('jour')
                ->pluck('total', 'jour');

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
                'mode' => 'global',
                'donnees' => $donnees,
            ]);
        }


        /*
         * CAS 2 : Un ou deux serveurs
         */

        $donnees = [];

        for ($i = 0; $i < 7; $i++) {

            $date = $debutSemaine->copy()->addDays($i);

            $ligne = [
                'label' => $joursNoms[$i],
                'serveurs' => [],
            ];

            foreach ($serveurs as $serveurId) {

                $total = Commande::where('statut', 'payee')
                    ->where('user_id', $serveurId)
                    ->whereDate('created_at', $date)
                    ->sum('total');

                $ligne['serveurs'][] = [
                    'id' => $serveurId,
                    'total' => (float) $total,
                ];
            }

            $donnees[] = $ligne;
        }

        return response()->json([
            'debut' => $debutSemaine->format('d/m'),
            'fin' => $finSemaine->format('d/m/Y'),
            'mode' => 'serveurs',
            'serveurs' => $serveurs,
            'donnees' => $donnees,
        ]);
    }
}
