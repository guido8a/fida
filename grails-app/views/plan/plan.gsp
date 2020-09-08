<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/08/20
  Time: 10:13
--%>

<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Programación de Actividades</title>
</head>

<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="plan" action="planesConvenio" id="${convenio?.id}" class="btn btn-sm btn-default">
            <i class="fa fa-arrow-left"></i> Planificación
        </g:link>
%{--        <a href="#" class="btn btn-success" id="btnAgregarPlan" >--}%
%{--            <i class="fa fa-plus"></i> Agregar Plan--}%
%{--        </a>--}%
    </div>
</div>

<div class="panel-primary " style="text-align: center; font-size: 14px; margin-bottom: 10px">
    <strong style="color: #5596ff; ">Programación de las Actividades del PNS: ${convenio?.planesNegocio?.nombre}</strong>
</div>


<table class="table table-condensed table-bordered table-hover table-striped" id="tblCrono" style="width: 100%">
    <thead>
    <tr>
        <th style="width:10%">Seleccione el Año</th>
        <th colspan="16">
            <g:select from="${combo}" optionKey="key" optionValue="value" class="form-control input-sm"
                      style="width: 90px; display: inline" name="plazo" id="plazo"/>
        </th>
    </tr>

    <tr id="trMeses">
        <th style="width: 15%">Componentes/Actividades</th>
        <th style="width: 6%">Costo</th>
        <g:each in="${lista}" var="periodo">
            <th style="width:6%">
                ${periodo}
            </th>
        </g:each>
        <th>Total Asignado</th>
    </tr>
    </thead>
</table>

<div id="divTabla"></div>

<script type="text/javascript">

    $("#plazo").change(function (){
       var p = $(this).val();
        cargarTablaComponentes(${convenio?.id}, p);
    });

    cargarTablaComponentes(${convenio?.id}, $("#plazo option:selected").val());

    function cargarTablaComponentes(convenio, periodo){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'plan', action: 'tablaPlan_ajax')}',
            data:{
                id: convenio,
                periodo: periodo
            },
            success: function (msg) {
                $("#divTabla").html(msg)
            }
        })

    }

</script>

</body>
</html>