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
    <title>Planificación de Actividades</title>
</head>

<body>

<div class="panel-primary " style="text-align: center; font-size: 14px; margin-bottom: 10px">
    <strong style="color: #5596ff; ">Planificación de Actividades</strong>
</div>


<table class="table table-condensed table-bordered table-hover table-striped" id="tblCrono">
    <thead>
    <tr>
        <th>Año</th>
        <th colspan="16">
            <g:select from="${combo}" optionKey="key" optionValue="value" class="form-control input-sm"
                      style="width: 150px; display: inline" name="plazo" id="plazo"/>
        </th>
    </tr>

    <tr id="trMeses">
        <th colspan="2" style="width:150px;">Componentes/Actividades</th>
        <th colspan="2" style="width:300px;">Costo</th>
        <g:each in="${lista}" var="periodo">
            <th style="width:100px;">
                ${periodo}.
            </th>
        </g:each>
%{--        <th>Total<br/>Año</th>--}%
%{--        <th>Sin<br/>asignar</th>--}%
        <th>Total<br/>Asignado</th>
    </tr>
    </thead>
</table>

<div id="divTabla"></div>

<script type="text/javascript">

    $("#plazo").change(function (){
       var p = $(this).val()
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