<?php

use Illuminate\Database\Migrations\Migration;
use Illuminate\Database\Schema\Blueprint;
use Illuminate\Support\Facades\Schema;

class CreateEtapasTable extends Migration
{
    /**
     * Run the migrations.
     *
     * @return void
     */
    public function up()
    {
        Schema::create('etapas', function (Blueprint $table) {
            $table->id();
            $table->string('sigla', 10);
            $table->string('nome');
            $table->timestamps();
        });

        Schema::create('cirurgia_etapa', function (Blueprint $table) {
            $table->id();
            $table->unsignedBigInteger('cirurgia_id');
            $table->unsignedBigInteger('etapa_id');
            $table->timestamps();

            
        });

        Schema::table('cirurgia_etapa', function ($table) {
            $table->foreign('cirurgia_id')->references('id')->on('cirurgias');
            $table->foreign('etapa_id')->references('id')->on('etapas');
        });
    }

    /**
     * Reverse the migrations.
     *
     * @return void
     */
    public function down()
    {
        Schema::dropIfExists('etapas');
    }
}
