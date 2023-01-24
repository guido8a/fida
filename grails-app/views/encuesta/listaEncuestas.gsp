
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Encuestas</title>
</head>
<body>

<div class="col-md-12" style="margin-bottom: 10px">

    <div class="btn-group col-md-1">
        <g:link controller="inicio" action="index" class="btn btn-default">
            <i class="fa fa-arrow-left"></i> Regresar
        </g:link>
    </div>

    <div class="col-md-1">
        <label>Organización:</label>
    </div>
    <div class="col-md-6">
        <g:select name="buscarU" from="${seguridad.UnidadEjecutora.list().sort{it.nombre}}" class="form-control" optionValue="nombre" optionKey="id"/>
    </div>

    <div class="col-md-2 btn-group">
        <a href="#" class="btn btn-success" id="btnBuscarEncuesta">
            <i class="fa fa-search"></i> Buscar
        </a>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped table-hover" style="width:100%;margin-top: 20px !important;">
    <thead style="width: 100%">
    <tr>
        <th style="width: 35%">Observaciones</th>
        <th style="width: 25%">Fecha</th>
        <th style="width: 10%">Estado</th>
        <th style="width: 20%">Informante</th>
        <th style="width: 10%"><i class="fa fa-user"></i> </th>
    </tr>
    </thead>
</table>

<div id="divTablaEncuestas">

</div>

<script type="text/javascript">

    $("#btnBuscarEncuesta").click(function (){
        var organizacion = $("#buscarU option:selected").val();
        cargarTablaEncuesta(organizacion);
    });

    function cargarTablaEncuesta(org){
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'encuesta', action: 'tablaEncuestas_ajax')}',
            data:{
                organizacion: org
            },
            success: function (msg) {
                dialog.modal('hide');
                $("#divTablaEncuestas").html(msg)
            }
        });
    }

</script>

</body>
</html>
