<?php

namespace App;

use Illuminate\Database\Eloquent\Model;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class Etapa extends Model
{
    public static function notIsConfirmed($idCirurgia) {
        
        $acesso = Acesso::join('user_acesso as ua', 'acessos.id', '=', 'ua.acesso_id')->where('ua.user_id', Auth::id())->first();

        if ($acesso->tipo == 'FAR') {
            
            $etapaContagem = Etapa::join('cirurgia_etapa as ce', 'etapas.id', '=', 'ce.etapa_id')
                ->where('ce.cirurgia_id', $idCirurgia)
                ->where('ce.etapa_id', 1)
                ->count();

            return $etapaContagem == 0;

        }

        if ($acesso->tipo == 'SAL') {

            $etapaContagem = Etapa::join('cirurgia_etapa as ce', 'etapas.id', '=', 'ce.etapa_id')
                ->where('ce.cirurgia_id', $idCirurgia)
                ->where('ce.etapa_id', 2)
                ->count();

            return $etapaContagem == 0;

        }

        return false;
    }

    public static function etapaFinal($idCirurgia) {
        
        $numEtapas = Etapa::count(); // A ideia é que seja igual a 2

        $etapasCirurgia = DB::table('cirurgia_etapa')->where('cirurgia_id', $idCirurgia)->count();

        return $numEtapas == $etapasCirurgia;

    }
}
