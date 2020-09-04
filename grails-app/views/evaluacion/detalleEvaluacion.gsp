<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 04/09/20
  Time: 12:19
--%>
<html>
<head>
    <meta name="layout" content="main">
    <title>Detalle de Evaluaciones</title>
</head>
<body>
<div class="panel panel-primary col-md-12" >
    <div class="btn-group" style="margin-top: 10px">
        <g:link controller="planesNegocio" action="evaluaciones" id="${plan?.id}" class="btn btn-sm btn-default">
            <i class="fa fa-arrow-left"></i> Regresar a evaluaciones
        </g:link>
    </div>

    <h3>Detalle de Evaluaciones</h3>
    <div class="panel-info" style="padding: 3px; margin-top: 2px">
        <table class="table table-condensed table-hover table-striped table-bordered">
            <thead>
            <tr style="width: 100%">
                <th style="width: 25%">Evaluación</th>
                <th style="width: 25%">Tipo de Evaluación</th>
                <th style="width: 25%">Indicador</th>
                <th style="width: 15%">Valor</th>
                <th style="width: 10%">Acciones</th>
            </tr>
            </thead>
        </table>
        <div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
            <table class="table-bordered table-condensed table-hover" style="width: 100%">
                <tbody>
                <g:each in="${evaluaciones}" var="evaluacion">
                    <tr data-id="${evaluacion.id}" style="width: 100%">
                        <td style="width: 20%"><elm:textoBusqueda busca="${params.search}">${evaluacion?.tipoEvaluacion?.descripcion}</elm:textoBusqueda></td>
                        <td style="width: 39%"><elm:textoBusqueda busca="${params.search}">${evaluacion?.descripcion}</elm:textoBusqueda></td>
                        <td style="width: 20%">${evaluacion?.fechaInicio?.format("dd-MM-yyyy")}</td>
                        <td style="width: 20%; text-align: center">${evaluacion?.fechaFin?.format("dd-MM-yyyy")}</td>
                        <g:if test="${evaluaciones?.size() < 7}">
                            <td style="width: 1%"></td>
                        </g:if>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</div>
</body>
</html>


