<?php

namespace App;

use Illuminate\Contracts\Auth\MustVerifyEmail;
use Illuminate\Foundation\Auth\User as Authenticatable;
use Illuminate\Notifications\Notifiable;
use Illuminate\Support\Facades\Auth;

class User extends Authenticatable
{
    use Notifiable;

    /**
     * The attributes that are mass assignable.
     *
     * @var array
     */
    protected $fillable = [
        'name', 'email', 'password',
    ];

    /**
     * The attributes that should be hidden for arrays.
     *
     * @var array
     */
    protected $hidden = [
        'password', 'remember_token',
    ];

    /**
     * The attributes that should be cast to native types.
     *
     * @var array
     */
    protected $casts = [
        'email_verified_at' => 'datetime',
    ];

    public static function isAdmin() {
        
        $userId = Auth::id();

        $acesso = Acesso::where('tipo', 'ADM')->join('user_acesso as ua', 'acessos.id', '=', 'ua.acesso_id')->where('ua.user_id', $userId)->count();

        return $acesso >= 1;

    }
    public static function isFarmacia() {
        
        $userId = Auth::id();

        $acesso = Acesso::where('tipo', 'FAR')->join('user_acesso as ua', 'acessos.id', '=', 'ua.acesso_id')->where('ua.user_id', $userId)->count();

        return $acesso >= 1;

    }
    public static function isSala() {
        
        $userId = Auth::id();

        $acesso = Acesso::where('tipo', 'SAL')->join('user_acesso as ua', 'acessos.id', '=', 'ua.acesso_id')->where('ua.user_id', $userId)->count();

        return $acesso >= 1;

    }
}
