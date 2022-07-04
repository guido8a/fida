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
                    <g:textField name="nombreC" maxlength="63" class="form-control input-sm" disabled="" value="${convenio?.nombre}" title="${convenio?.nombre}"/>
                </span>
            </div>

            <span class="col-md-2 label label-primary text-info mediano">Código</span>
            <div class="col-md-2">
                <span class="grupo">
                    <g:textField name="codigoC" class="form-control input-sm" disabled=""  value="${convenio?.codigo}"/>
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
                <g:textField name="montoC" class="form-control input-sm" disabled=""  value="${convenio?.monto}"/>
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

    <g:form class="form-horizontal" name="frmGarantia" controller="garantia" action="saveGarantia_ajax" method="POST">
        <g:hiddenField name="convenio" value="${convenio?.id}"/>
        <g:hiddenField name="tipo" value="${'add'}"/>
        <g:hiddenField name="id" value="${''}"/>
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
                <span class="col-md-1 label label-primary text-info mediano">Estado de garantía</span>
                <div class="col-md-2">
                    <span class="grupo">
                        <g:select name="estadoGarantia" from="${convenio.EstadoGarantia.list().sort{it.descripcion}}" value="${1}" disabled="" class="form-control" optionKey="id" optionValue="descripcion"/>
                    </span>
                </div>
                <span class="col-md-1 label label-primary text-info mediano">Garantía original</span>
                <div class="col-md-2">
                    <span class="grupo">
                        <g:textField name="padre" class="form-control" disabled=""/>
                    </span>
                </div>
            </div>
        </div>
        <div class="row izquierda">
            <div class="col-md-12 input-group">
                <span class="col-md-2 label label-primary text-info mediano">Número de garantía</span>
                <div class="col-md-4">
                    <span class="grupo">
                        <g:textField name="codigo" class="form-control required allCaps" maxlength="31"/>
                    </span>
                </div>
                <span class="col-md-1 label label-primary text-info mediano">Monto</span>
                <div class="col-md-2">
                    <span class="grupo">
                        <g:textField name="monto" class="form-control required number"/>
                    </span>
                </div>
            </div>
        </div>
        <div class="row izquierda" style="margin-bottom: 10px">
            <div class="col-md-12 input-group">
                <span class="col-md-2 label label-primary text-info mediano">Emisión</span>
                <div class="col-md-2">
                    <span class="grupo">
                        <input name="fechaEmision" id='fechaEmision' type='text' class="form-control required" onfocusout="calcularDias()"/>
                    </span>
                </div>
                <span class="col-md-1 label label-primary text-info mediano">Vencimiento</span>
                <div class="col-md-2">
                    <span class="grupo">
                        <input name="fechaFinalizacion" id='fechaFinalizacion' type='text' class="form-control required" onfocusout="calcularDias()" />
                    </span>
                </div>
                <span class="col-md-1 label label-primary text-info mediano">Días</span>
                <div class="col-md-2">
                    <span class="grupo">
                        <g:hiddenField name="diasGarantizados" value=""/>
                        <g:textField name="diasGarantizados_name" id="dg" class="form-control required" readonly=""/>
                    </span>
                </div>
                <a href="#" class="btn btn-success btnAgregarGarantia" ><i class="fa fa-plus"></i> Agregar</a>
                <a href="#" class="btn btn-info btnEditarGarantia hidden"><i class="fa fa-save"></i> Guardar</a>
                <a href="#" class="btn btn-warning btnRenovarGarantia hidden"><i class="fa fa-save"></i> Renovar</a>
                <a href="#" class="btn btn-danger btnCancelarGarantia"><i class="fa fa-times"></i> Cancelar</a>
            </div>
        </div>
    </g:form>
</div>

<div style="margin-top: 10px; min-height: 250px" class="vertical-container">
    <p class="css-vertical-text">Garantías Vigentes</p>
    <div class="linea"></div>
    <div id="divTablaGarantias"></div>
</div>

<script type="text/javascript">

    $(".btnCancelarGarantia").click(function () {
        limpiarCampos();
    });

    function limpiarCampos(){
        $(".btnRenovarGarantia").addClass('hidden');
        $(".btnEditarGarantia").addClass('hidden');
        $(".btnAgregarGarantia").removeClass('hidden');
        $("#tipo").val("add");
        $("#diasGarantizados").val('');
        $("#dg").val('');
        $("#fechaFinalizacion").val('');
        $("#fechaEmision").val('');
        $("#monto").val('');
        $("#codigo").val('');
        $("#padre").val('');
        $("#aseguradora").val(1);
        $("#tipoDocumentoGarantia").val(7);
        $("#tipoGarantia").val(2);
        $("#id").val('');
    }

    function calcularDias(){
        var e = $("#fechaEmision").val();
        var f = $("#fechaFinalizacion").val();

        if(e && f){
            // if(e > f){
            //     bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> La fecha de emisión es mayor a la fecha de finalización ");
            //     $("#dg").val('');
            // }else{
            $.ajax({
                type:'POST',
                url:'${createLink(controller: 'garantia', action: 'calcularDias_ajax')}',
                data:{
                    inicio: e,
                    fin: f
                },
                success:function (msg) {
                    if(msg =='er'){
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> La fecha de emisión es mayor a la fecha de finalización ");
                        $("#dg").val('');
                    }else{
                        $("#dg").val(msg);
                        $("#diasGarantizados").val(msg);
                    }
                }
            });
            // }
        }
    }

    cargarTablaGarantias();

    $(".btnAgregarGarantia, .btnEditarGarantia").click(function () {
        guardarGarantia();
    });

    $(".btnRenovarGarantia").click(function () {
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> ¿Está seguro de querer renovar esta garantía?", function (res) {
            if(res){
                guardarGarantia();
            }
        });
    });

    function guardarGarantia(){
        var e = $("#fechaEmision").val();
        var f = $("#fechaFinalizacion").val();

        var $form = $("#frmGarantia");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            var data = $form.serialize();
            $btn.replaceWith(spinner);
            var dialog = cargarLoader("Guardando...");
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : data,
                success : function (msg) {
                    dialog.modal('hide');
                    if(msg == 'ok'){
                        log("Garantía guardada correctamente", "success");
                        cargarTablaGarantias();
                        limpiarCampos();
                    }else{
                        log("Error al agregar la garantía", "success");
                    }
                }
            });
        } else {
            return false;
        } //else
        return false;
    }

    function cargarTablaGarantias () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'garantia', action: 'tablaGarantias_ajax')}',
            data:{
                id: '${convenio?.id}'
            },
            success: function (msg) {
                $("#divTablaGarantias").html(msg)
            }
        })
    }

    $('#fechaEmision').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true,
    });

    $('#fechaFinalizacion').datetimepicker({
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