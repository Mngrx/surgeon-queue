<?php

use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\Route;

/*
|--------------------------------------------------------------------------
| Web Routes
|--------------------------------------------------------------------------
|
| Here is where you can register web routes for your application. These
| routes are loaded by the RouteServiceProvider within a group which
| contains the "web" middleware group. Now create something great!
|
*/

Route::get('/', function () {
    return redirect('login');
});

Auth::routes();

Route::get('/home', 'CalendarioController@index')->middleware('auth');
Route::get('/evento', 'CalendarioController@getCirurgiasAjax')->middleware('auth');
Route::get('/confirmar/{id}', 'CalendarioController@confirmarEtapa')->middleware('auth');
Route::post('/criar', 'CalendarioController@store')->middleware('auth');
