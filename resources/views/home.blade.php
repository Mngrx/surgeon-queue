@extends('adminlte::page')

@section('title', 'Gerenciar cirurgia')

@section('content_header')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3">
            <h1>Gerenciar cirurgia</h1>
        </div>
    </div>
</div>
<hr>
@stop

@section('content')
<div class="container-fluid">
    <div class="row">
        <div class="col-md-3">
            @if(Auth::user()->isAdmin())
            <button id="marcar-cirurgia" type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#marcarModal">Marcar cirurgia</button><br>
            @endif
            <div class="card card-outline card-primary" style="height: 60vh; overflow-y: scroll;">
                <div class="card-header">
                    <h3 class="card-title"><strong>Para os próximos 7 dias</strong></h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    @foreach($cirurgias as $item)
                    <div class="card">
                        <div class="card-body">
                            <h5>Paciente: {{ $item->nome }}</h5>
                            @if(Auth::user()->isAdmin() || Auth::user()->isSala())
                            <h5>Sala: {{ $item->sala }}</h5>
                            @endif
                            @if(Auth::user()->isAdmin() || Auth::user()->isFarmacia())
                            <h5>Itens:</h5>
                            <p>{{ $item->equipamento }}</p>
                            @endif

                            @if($item->notIsConfirmed && !$item->etapaFinal)
                            <span class="badge badge-warning">Aguardando confirmações</span>
                            @else
                                @if(!$item->confirmado)
                                <span class="badge badge-warning">Aguardando confirmação final</span>
                                @else
                                <span class="badge badge-success">Tudo OK!</span>
                                @endif
                            @endif
                            <br><br>
                            @if((Auth::user()->isSala() || Auth::user()->isFarmacia()) && $item->notIsConfirmed)
                            <button type="button" class="btn btn-success" onclick="confirmar({{ $item->id }})">Confirmar</button>
                            @endif
                            @if((Auth::user()->isAdmin()) && $item->etapaFinal && !$item->confirmado)
                            <button type="button" class="btn btn-success" onclick="confirmar({{ $item->id }})">Confirmação final</button>
                            @endif
                        </div>
                    </div>
                    @endforeach
                </div>
                <!-- /.card-body -->
            </div>
        </div>
        <div class="col-md-9">
            <div id="calendario">
            </div>
        </div>
    </div>
</div>
<!-- Modal -->
<div class="modal fade" id="marcarModal" tabindex="-1" role="dialog" aria-labelledby="marcarModalLabel" aria-hidden="true">
    <div class="modal-dialog modal-dialog-centered modal-xl">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="marcarModalLabel">Marcar cirurgia</h5>
                <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                    <span aria-hidden="true">&times;</span>
                </button>
            </div>
            <div class="modal-body">
                <form action="/criar" method="POST">
                    @csrf
                    <div class="form-group">
                        <label for="nome">Nome do paciente</label>
                        <input type="text" class="form-control" name="nome" id="nome">
                    </div>
                    <div class="form-group">
                        <label for="cpf">CPF do paciente</label>
                        <input type="text" class="form-control" name="cpf" id="cpf">
                    </div>
                    <div class="form-group">
                        <label for="nascimento">Data de nascimento do paciente</label>
                        <input type="date" class="form-control" name="nascimento" id="nascimento">
                    </div>
                    <hr>
                    <div class="form-group">
                        <label for="horario">Horário da cirurgia</label>
                        <input type="datetime-local" class="form-control" name="horario" id="horario">
                    </div>
                    <div class="form-group">
                        <label for="sala">Sala da cirurgia</label>
                        <input type="text" class="form-control" name="sala" id="sala">
                    </div>
                    <div class="form-group">
                        <label for="equipamento">Equipamentos da cirurgia</label>
                        <textarea class="form-control" name="equipamento" id="equipamento" cols="30" rows="3"></textarea>
                    </div>
            </div>
            <div class="modal-footer">
                <button type="submit" class="btn btn-primary">Salvar</button>
            </div>
            </form>
        </div>
    </div>
</div>
@stop

@section('css')
<link rel="stylesheet" href="/css/admin_custom.css">
@stop

@section('js')
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery.mask/1.14.16/jquery.mask.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendario');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            plugins: ['dayGrid']
            , locale: 'pt-br'
            , eventSources: [{
                url: '/evento'
                , method: 'GET'
                , failure: function() {
                    alert('Ocorreu um erro enquanto estava carregando os eventos!');
                }
                , color: 'yellow', // a non-ajax option
                textColor: 'black' // a non-ajax option
            }]
        });

        calendar.render();

        $('#cpf').mask('000.000.000-00', {
            reverse: true
        });
    });

    function confirmar(id) {
        $.get('/confirmar/' + id, function(data) {
            alert("Confirmação efetuada.");
            location.reload();
        });
    }

</script>
@stop
