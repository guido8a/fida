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
    <div class="btn-group col-md-12">
        %{--<g:link controller="plan" action="planesConvenio" id="${planNs?.id}" class="btn btn-sm btn-default">--}%
            %{--<i class="fa fa-arrow-left"></i> Planificación--}%
        %{--</g:link>--}%
        <a href="#" id="btnPlanNegocio" class="btn btn-sm btn-default" title="Ir al Plan de Negocio">
            <i class="fa fa-arrow-left"></i> Planificación
        </a>

        <div class="panel-primary col-md-9" style="text-align: center; font-size: 14px; margin-bottom: 10px">
            <span class="col-md-3"></span>
            <span class="col-md-3 panel-primary">Seleccione el Año</span>
            <span class="col-md-2">
                <g:select from="${combo}" optionKey="key" optionValue="value" class="form-control input-sm"
                          name="plazo" id="plazo"/>
            </span>
        </div>
    </div>
</div>

<div class="panel-primary " style="text-align: center; font-size: 14px; margin-bottom: 10px">
    <strong style="color: #5596ff; ">Programación de las Actividades del PNS: ${planNs?.nombre}</strong>
</div>

<div id="divCabecera"></div>

<div id="divTabla"></div>

<script type="text/javascript">

    $("#plazo").change(function (){
       var p = $(this).val();
        cargarCabecera(${planNs?.id}, p);
        cargarTablaComponentes(${planNs?.id}, p);
    });

    cargarCabecera(${planNs?.id}, $("#plazo option:selected").val());

    cargarTablaComponentes(${planNs?.id}, $("#plazo option:selected").val());

    function cargarCabecera(planNs, periodo){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'plan', action: 'cabecera_ajax')}',
            data:{
                id: planNs,
                periodo: periodo
            },
            success: function (msg) {
                $("#divCabecera").html(msg)
            }
        })

    }

    function cargarTablaComponentes(planNs, periodo){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'plan', action: 'tablaPlan_ajax')}',
            data:{
                id: planNs,
                periodo: periodo,
                convenio: '${convenio?.id}'
            },
            success: function (msg) {
                $("#divTabla").html(msg)
            }
        })

    }

    $("#btnPlanNegocio").click(function () {
        location.href="${createLink(controller: 'plan', action: 'planesConvenio')}/?plan=" + '${planNs?.id}'
    });

</script>

</body>
</html>