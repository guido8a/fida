<%@ page import="seguridad.UnidadEjecutora; parametros.Anio; parametros.proyectos.TipoElemento" contentType="text/html;charset=UTF-8" %>
<html>

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Historial de avales</title>

    <style>

    .amarillo{
        background-color: #e1a628;
        color: #fdfbff;
    }

    .rojo{
        background-color: #c42623;
        color: #fdfbff;
    }

    .verde{
        background-color:#78b665;
        color: #fdfbff;
    }


    </style>
</head>

<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}"><elm:poneHtml textoHtml="${flash.message}"/></elm:message>

<div class="panel panel-primary col-md-12" role="tabpanel" style="margin-top: 50px;">

    <h3>Lista de avales</h3>

    <div class="form-group keeptogether alert alert-success">
        <form class="form-inline">
            <div class="form-group">
                <label for="anio">Año:</label>
                <g:select from="${Anio.list([sort: 'anio'])}" id="anio" name="anio"
                          optionKey="id" optionValue="anio" value="${actual.id}" class="form-control input-sm"/>
            </div>

            <div class="form-group">
                <label for="numero">Número:</label>
                ${actual.anio}-GP No.<input type="text" id="numero" class="form-control input-sm"/>
            </div>

%{--            <div class="form-group">--}%
%{--                <label for="descProceso">Requirente:</label>--}%
%{--                <g:select name="requirente" from="${unidades}" class="form-control input-sm" style="width: 200px;" optionKey="id" id="requirenteId"/>--}%
%{--            </div>--}%

            <div class="form-group">
                <label for="descProceso">Proceso:</label>
                <input type="text" id="descProceso" class="form-control input-sm" style="width: 200px;"/>
            </div>
            <a href="#" class="btn btn-info btn-sm" id="buscar">
                <i class="fa fa-search-plus"></i> Buscar
            </a>
        </form>
    </div>

    <div id="detalle" style="width: 100%; min-height: 100px;">

    </div>

</div>


<script type="text/javascript">
    function cargarHistorial(anio, numero, proceso, requirente) {

        $.ajax({
            type    : "POST", url : "${createLink(action:'historialAvales', controller: 'revisionAval')}",
            data    : {
                anio       : anio,
                numero     : numero,
                proceso    : proceso,
                requirente : requirente
            },
            success : function (msg) {
                $("#detalle").html(msg)
                closeLoader();
            }
        });

    }
    function cargarHistorialSort(anio, numero, proceso, requirente, sort, order) {
        $.ajax({
            type    : "POST", url : "${createLink(action:'historialAvales', controller: 'revisionAval')}",
            data    : {
                anio       : anio,
                numero     : numero,
                proceso    : proceso,
                sort       : sort,
                order      : order,
                requirente : requirente
            },
            success : function (msg) {
                $("#detalle").html(msg)
                closeLoader();

            }
        });

    }
    $("#buscar").button().click(function () {
        openLoader("Cargando avales..");
        // cargarHistorialSort($("#anio").val(), $("#numero").val(), $("#descProceso").val(), $("#requirenteId").val())
        cargarHistorialSort($("#anio").val(), $("#numero").val(), $("#descProceso").val())
    })
</script>
</body>
</html>