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
            <button id="marcar-cirurgia" type="button" class="btn btn-primary btn-lg btn-block" data-toggle="modal" data-target="#marcarModal">Marcar cirurgia</button><br>
            <div class="card card-outline card-primary" style="height: 60vh; overflow-y: scroll;">
                <div class="card-header">
                    <h3 class="card-title"><strong>Para os próximos 7 dias</strong></h3>
                </div>
                <!-- /.card-header -->
                <div class="card-body">
                    <div class="card">
                        <div class="card-body">
                            The body of the card
                        </div>
                    </div>
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
                ...
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                <button type="button" class="btn btn-primary">Save changes</button>
            </div>
        </div>
    </div>
</div>
@stop

@section('css')
<link rel="stylesheet" href="/css/admin_custom.css">
@stop

@section('js')
<script>
    document.addEventListener('DOMContentLoaded', function() {
        var calendarEl = document.getElementById('calendario');

        var calendar = new FullCalendar.Calendar(calendarEl, {
            plugins: ['dayGrid'],
            locale: 'pt-br'
        });

        calendar.render();


        // $('#marcar-cirurgia').click((e) => {

        // });
    });
</script>
@stop