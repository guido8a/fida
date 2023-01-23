<%@ page contentType="text/html;charset=UTF-8" %>

<html lang="es">
<head>
    <meta name="layout" content="main" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <title>Indicadores del ML</title>
    <style>
    .caja {
        text-align: center;
        padding: 30px;
        margin-top: 40px;
        /*margin-left: 440px;*/
        border-style:solid;
        border-width: thin;
        /*float: right;*/
    }
    /*.cajaProf {*/
    /*    color: #116;*/
    /*}*/
    /*.cajaEstd {*/
    /*    color: #055;*/
    /*}*/
    /*.cajaErr {*/
    /*    color: #611;*/
    /*}*/

    </style>
</head>
<body>
<div class="panel panel-primary col-md-12">
    <div class="ui-widget-content ui-corner-all caja" >
        <div class=" filaEntera ui-corner-all " style="font-size: 14px" >
            <div style="float: left">
                <asset:image src="apli/evaluacion.png" title="Ajustes al Plan Operativo Anual" width="80%" height="80%"
                             style="margin-left: 0;"/>
            </div>

            <strong>
                <h3>Usted está a punto de inicar la Evaluación</h3><br>

                * Por favor lea  y entienda bien las preguntas y señale la opción de respuesta que más se aplique.<br>
            </strong>

            <div class="row izquierda" style="margin-top: 70px; margin-bottom: 15px">
                <div class="col-md-12 input-group">
                    <span class="col-md-3">
                        <a href="#" id="btnBuscarOrganizacion"
                           class="btn btn-sm btn-info" style="color: #fff" title="Buscar organización">
                            <i class="fas fa-list-alt"></i> Seleccione su Organización
                        </a>
                    </span>
                    <div class="col-md-9">
                        <span class="grupo">
                            <g:hiddenField id="unidadEjecutora" name="unidadEjecutora.id" />

                            <g:textField id="unidadEjecutoraName" name="unidadEjecutora.nombre" class="form-control" readonly="true"/>

                        </span>
                    </div>
                </div>
            </div>

            <div class="row izquierda" style="margin-top: 10px; margin-bottom: 15px">
                <div class="col-md-12 input-group">
                    <span class="col-md-3">
                        <a href="#" id="btnBuscarInformante"
                           class="btn btn-sm btn-warning" style="color: #fff" title="Buscar informante">
                            <i class="fas fa-user"></i> Seleccione su informante
                        </a>
                    </span>
                    <div class="col-md-9">
                        <span class="grupo">
                            <g:hiddenField id="personaOrganizacion" name="personaOrganizacion.id" />
                            <g:textField id="personaOrganizacionName" name="personaOrganizacion.nombre" class="form-control" readonly="true"/>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div style="align-items: center">
            <div class="btn-group">
                <a href="#" class="btn btn-sm btn-warning" id="btnFin" style="color: #fee">
                    <i class="fa fa-arrow-left"></i> Abandonar la Encuesta
                </a>
            </div>

            <div class="btn-group">
                <a href="#" class="btn btn-sm btn-primary" id="btnEncuesta" style="color: #fff">
                    <i class="fa fa-plus"></i> Empezar o Reanudar la Encuesta
                </a>
            </div>
        </div>


    </div>
</div>
<script type="text/javascript">
    var bm;

    $("#btnBuscarInformante").click(function () {
        if($("#unidadEjecutora").val() !== ''){
            var dialog = cargarLoader("Cargando...");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'encuesta', action: 'buscarInformante_ajax')}',
                data: {
                    unidad: $("#unidadEjecutora").val()
                },
                success: function (msg) {
                    dialog.modal('hide');
                    bm = bootbox.dialog({
                        id: "dlgBuscarInformante",
                        title: "Buscar Informante",
                        class: "modal-lg",
                        closeButton: false,
                        message: msg,
                        buttons: {
                            cancelar: {
                                label: "Cancelar",
                                className: "btn-primary",
                                callback: function () {
                                }
                            }
                        }
                    }); //dialog
                }
            });
        }else{
            var d = bootbox.dialog({
                id: "dlgError",
                title: "Alerta",
                class: "modal-sm",
                closeButton: false,
                message: "<i class='fa fa-exclamation-triangle fa-2x pull-left text-danger text-shadow'></i> <h4> Seleccione una organización </h4>",
                buttons: {
                    cancelar: {
                        label: "Cancelar",
                        className: "btn-primary",
                        callback: function () {
                        }
                    }
                }
            }); //dialog
        }
    });

    $("#btnBuscarOrganizacion").click(function () {
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'encuesta', action: 'buscarOrganizacion_ajax')}',
            data: {},
            success: function (msg) {
                dialog.modal('hide');
                bm = bootbox.dialog({
                    id: "dlgBuscarOrganizacion",
                    title: "Buscar Organizaciones",
                    class: "modal-lg",
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                }); //dialog
            }
        });
    });

    $("#btnFin").click(function () {
        location.href="${createLink(controller: 'inicio', action: 'index')}"
    });

    $("#btnEncuesta").click(function () {
        var unej = $("#unidadEjecutora").val();
        var informante = $("#personaOrganizacion").val();

        if(unej){
            if(informante){
                location.href="${createLink(controller: 'encuesta', action: 'iniciaEncu')}" + "?unej=" + unej + "&info=" + informante
            }else{
                var a = bootbox.dialog({
                    id: "dlgError",
                    title: "Alerta",
                    class: "modal-sm",
                    closeButton: false,
                    message: "<i class='fa fa-exclamation-triangle fa-2x pull-left text-danger text-shadow'></i> <h4> Seleccione un informante </h4>",
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                }); //dialog
            }
        }else{
            var d = bootbox.dialog({
                id: "dlgError",
                title: "Alerta",
                class: "modal-sm",
                closeButton: false,
                message: "<i class='fa fa-exclamation-triangle fa-2x pull-left text-danger text-shadow'></i> <h4> Seleccione una organización </h4>",
                buttons: {
                    cancelar: {
                        label: "Cancelar",
                        className: "btn-primary",
                        callback: function () {
                        }
                    }
                }
            }); //dialog
        }

    });

    function cerrarDialogoBuscarOrganizacion () {
        bm.modal("hide")
    }

</script>
</body>
</html>



