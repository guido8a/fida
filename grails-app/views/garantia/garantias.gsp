<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 10/09/20
  Time: 12:53
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Garantías</title>

    <style type="text/css">
    .mediano {
        margin-top: 5px;
        padding-top: 9px;
        height: 30px;
        font-size: inherit;
        text-align: right;
    }
    </style>

</head>

<body>
<div class="btn-group">
    <g:if test="${convenio?.id}">
        <a href="#" class="btn btn-sm btn-default" id="btnRegresarConvenio" >
            <i class="fa fa-arrow-left"></i> Regresar a convenio
        </a>
    </g:if>
</div>



<div style="margin-top: 10px; min-height: 150px" class="vertical-container">
    <p class="css-vertical-text">Convenio</p>

    <div class="linea"></div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <span class="col-md-2 label label-primary text-info mediano">Nombre</span>
            <div class="col-md-6">
                <span class="grupo">
                    <g:textField name="nombre" maxlength="63" class="form-control input-sm" disabled="" value="${convenio?.nombre}" title="${convenio?.nombre}"/>
                </span>
            </div>

            <span class="col-md-2 label label-primary text-info mediano">Código</span>
            <div class="col-md-2">
                <span class="grupo">
                    <g:textField name="codigo" class="form-control input-sm" disabled=""  value="${convenio?.codigo}"/>
                </span>
            </div>

        </div>
    </div>
    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <span class="col-md-2 label label-primary text-info mediano">Fecha Inicio</span>
            <span class="grupo">
                <div class="col-md-2">
                    <input name="fechaInicio_Con"  type='text' class="form-control" disabled=""
                           value="${convenio?.fechaInicio?.format("dd-MM-yyyy")}"/>

                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="col-md-4 mediano"></span>
            <span class="col-md-2 label label-primary text-info mediano">Fecha Fin</span>
            <span class="grupo">
                <div class="col-md-2">
                    <input name="fechaFin" id='fechaFin' type='text' class="form-control" disabled=""
                           value="${convenio?.fechaFin?.format("dd-MM-yyyy")}"/>

                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
    </div>


    <div class="row izquierda" style="margin-bottom: 20px">
        <div class="col-md-12 input-group">
            <span class="col-md-2 label label-primary text-info mediano">Monto del convenio</span>
            <div class="col-md-2">
                <g:textField name="monto" class="form-control input-sm" disabled=""  value="${convenio?.monto}"/>
            </div>
            <span class="col-md-2 label label-primary text-info mediano">Plazo</span>
            <div class="col-md-2">
                <g:textField name="plazo" class="form-control input-sm" disabled="" value="${convenio?.plazo}"/>
            </div>
            <span class="col-md-2 label label-primary text-info mediano">Informar cada:</span>
            <div class="col-md-2">
                <g:textField name="periodo" class="form-control input-sm" disabled=""  value="${convenio?.periodo}"/>
            </div>
        </div>
    </div>

</div>

<div style="margin-top: 10px; margin-bottom: 10px; min-height: 180px" class="vertical-container">
    <p class="css-vertical-text">Garantías</p>
    <div class="linea"></div>

    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <span class="col-md-2 label label-primary text-info mediano">Tipo de garantía</span>
            <div class="col-md-4">
                <span class="grupo">
                    <g:select name="tipoGarantia" from="${convenio.TipoGarantia.list().sort{it.descripcion}}" class="form-control" optionKey="id" optionValue="descripcion"/>
                </span>
            </div>

            <span class="col-md-2 label label-primary text-info mediano">Tipo documento de garantía</span>
            <div class="col-md-4">
                <span class="grupo">
                    <g:select name="tipoDocumentoGarantia" from="${convenio.TipoDocumentoGarantia.list().sort{it.descripcion}}" class="form-control" optionKey="id" optionValue="descripcion"/>
                </span>
            </div>

        </div>
    </div>
    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <span class="col-md-2 label label-primary text-info mediano">Aseguradora</span>
            <div class="col-md-4">
                <span class="grupo">
                    <g:select name="aseguradora" from="${convenio.Aseguradora.list().sort{it.nombre}}" class="form-control" optionKey="id" optionValue="nombre"/>
                </span>
            </div>
            <span class="col-md-2 label label-primary text-info mediano">Estado de garantía</span>
            <div class="col-md-4">
                <span class="grupo">
                    <g:select name="estadoGarantia" from="${convenio.EstadoGarantia.list().sort{it.descripcion}}" class="form-control" optionKey="id" optionValue="descripcion"/>
                </span>
            </div>
        </div>
    </div>
    <div class="row izquierda">
        <div class="col-md-12 input-group">
            <span class="col-md-2 label label-primary text-info mediano">Número de garantía</span>
            <div class="col-md-4">
                <span class="grupo">
                    <g:textField name="codigo" class="form-control"/>
                </span>
            </div>
            <span class="col-md-2 label label-primary text-info mediano">Garantía original</span>
            <div class="col-md-4">
                <span class="grupo">
                    <g:textField name="padre" class="form-control"/>
                </span>
            </div>
        </div>
    </div>
    <div class="row izquierda" style="margin-bottom: 10px">
        <div class="col-md-12 input-group">
            <span class="col-md-2 label label-primary text-info mediano">Emisión</span>
            <div class="col-md-2">
                <span class="grupo">
                    <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"
                           />
                </span>
            </div>
            <span class="col-md-1 label label-primary text-info mediano">Vencimiento</span>
            <div class="col-md-2">
                <span class="grupo">
                    <input name="fechaFinalizacion" id='fechaFinalizacion' type='text' class="form-control"
                    />
                </span>
            </div>
            <span class="col-md-1 label label-primary text-info mediano">Días</span>
            <div class="col-md-2">
                <span class="grupo">
                    <g:textField name="diasGarantizados" class="form-control"/>
                </span>
            </div>
        </div>
    </div>
</div>

<div style="margin-top: 10px; min-height: 150px" class="vertical-container">
    <p class="css-vertical-text">Garantías Vigentes</p>

    <div class="linea"></div>

</div>


<script type="text/javascript">

    $('#fechaInicio').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true,
    });

    $('#fechaFinalización').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true,
    });

    $("#btnRegresarConvenio").click(function () {
        location.href="${createLink(controller: 'convenio', action: 'convenio')}/" + '${convenio?.id}'
    });


</script>

</body>
</html>