<?php

namespace App\Http\Controllers;

use App\Cirurgia;
use App\Etapa;
use App\Paciente;
use Illuminate\Http\Request;
use Illuminate\Support\Facades\Auth;
use Illuminate\Support\Facades\DB;

class CalendarioController extends Controller
{
    /**
     * Display a listing of the resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function index()
    {

        $horarioMaisSeteDias = date('Y-m-d H:i:s', strtotime('+7 days'));
        $agora = date('Y-m-d H:i:s');

        $cirurgias = Cirurgia::whereBetween('horario', [$agora, $horarioMaisSeteDias])
            ->join('pacientes', 'pacientes.id', '=', 'cirurgias.paciente_id')
            ->orderBy('horario', 'asc')
            ->get(['cirurgias.*', 'pacientes.cpf', 'pacientes.nome', 'pacientes.nascimento']);

        for ($i=0; $i < count($cirurgias); $i++) { 
            $cirurgias[$i]['notIsConfirmed'] = Etapa::notIsConfirmed($cirurgias[$i]['id']);
            $cirurgias[$i]['etapaFinal'] = Etapa::etapaFinal($cirurgias[$i]['id']);
        }

        return view('home', ['cirurgias' => $cirurgias]);
    }

    /**
     * Show the form for creating a new resource.
     *
     * @return \Illuminate\Http\Response
     */
    public function create()
    {
        //
    }

    /**
     * Store a newly created resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @return \Illuminate\Http\Response
     */
    public function store(Request $request)
    {
        $paciente = Paciente::firstOrNew(['cpf' => $request->cpf]);

        if (!$paciente->nome) {

            $paciente->nome = $request->nome;
            $paciente->cpf = $request->cpf;
            $paciente->nascimento = date('Y-m-d', strtotime($request->nascimento));

            $paciente->save();
        }
        
        $cirurgia = new Cirurgia;

        $cirurgia->paciente_id = $paciente->id;
        $cirurgia->horario = date('Y-m-d H:i:s', strtotime($request->horario));
        $cirurgia->sala = $request->sala;
        $cirurgia->equipamento = $request->equipamento;

        $cirurgia->save();

        return redirect('/home');

    }

    /**
     * Display the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function show($id)
    {
        //
    }

    /**
     * Show the form for editing the specified resource.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function edit($id)
    {
        //
    }

    /**
     * Update the specified resource in storage.
     *
     * @param  \Illuminate\Http\Request  $request
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function update(Request $request, $id)
    {
        //
    }

    /**
     * Remove the specified resource from storage.
     *
     * @param  int  $id
     * @return \Illuminate\Http\Response
     */
    public function destroy($id)
    {
        //
    }

    public function getCirurgiasAjax(Request $request)
    {
        $cirurgias = Cirurgia::join('pacientes', 'pacientes.id', '=', 'cirurgias.paciente_id')->get(['cirurgias.*', 'pacientes.nome']);

        $retorno = [];

        foreach ($cirurgias as $item) {
            $objeto = [];

            $objeto['title'] = explode(' ', $item->nome)[0] . ' - ' . $item->sala;
            $objeto['start'] = $item->horario;
            $objeto['allDay'] = false;
            
            $etapasPassadas = DB::table('cirurgia_etapa')->where('cirurgia_id', $item->id)->count();

            if ($etapasPassadas == Etapa::count()) {
                $objeto['color'] = 'green';
            }

            $retorno[] = $objeto;
        }

        return response()->json($retorno, 200);
    }

    public function confirmarEtapa($id) {
        
        $user = Auth::user();

        if ($user::isFarmacia()) {
            DB::table('cirurgia_etapa')->insert([
                'etapa_id' => 1,
                'cirurgia_id' => $id
            ]);
        } 
        if ($user::isSala()) {
            DB::table('cirurgia_etapa')->insert([
                'etapa_id' => 2,
                'cirurgia_id' => $id
            ]);
        }

        if ($user::isAdmin()) {
            $cirurgia = Cirurgia::where('id', $id)->first();

            $cirurgia->confirmado = date('Y-m-d H:i:s');

            $cirurgia->save();

        }
        return response('Confirmado.', 200); 
    }
}
