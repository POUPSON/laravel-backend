<?php

namespace App\Http\Controllers;

use App\Models\User;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Hash;

class UserController extends Controller
{
    public function index(Request $request)
    {
        $this->autoriserAdmin($request);

        return User::select('id', 'name', 'email', 'role', 'created_at')->get();
    }

    public function store(Request $request)
    {
        $this->autoriserAdmin($request);

        $validated = $request->validate([
            'name' => 'required|string|max:255',
            'email' => 'required|email|unique:users,email',
            'password' => 'required|string|min:6',
            'role' => 'required|in:admin,serveur',
        ]);

        $validated['password'] = Hash::make($validated['password']);

        $user = User::create($validated);

        return response()->json($user, 201);
    }

    public function update(Request $request, string $id)
    {
        $this->autoriserAdmin($request);

        $user = User::findOrFail($id);

        $validated = $request->validate([
            'name' => 'sometimes|required|string|max:255',
            'email' => 'sometimes|required|email|unique:users,email,' . $id,
            'password' => 'nullable|string|min:6',
            'role' => 'sometimes|required|in:admin,serveur',
        ]);

        if (!empty($validated['password'])) {
            $validated['password'] = Hash::make($validated['password']);
        } else {
            unset($validated['password']);
        }

        $user->update($validated);

        return response()->json($user);
    }

    public function destroy(Request $request, string $id)
    {
        $this->autoriserAdmin($request);

        if ((int) $id === $request->user()->id) {
            abort(403, 'Vous ne pouvez pas supprimer votre propre compte.');
        }

        User::findOrFail($id)->delete();

        return response()->json(['message' => 'Utilisateur supprimé.']);
    }

    private function autoriserAdmin(Request $request)
    {
        if ($request->user()->role !== 'admin') {
            abort(403, 'Accès réservé à l\'administrateur.');
        }
    }
}
