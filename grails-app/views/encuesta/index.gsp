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
                    %{--                    <span class="col-md-3 panel panel-info" style="height: 35px; text-align: end">Seleccione su Organización</span>--}%
                    <span class="col-md-3">
                        <a href="#" id="btnBuscarOrganizacion"
                           class="btn btn-sm btn-info" style="color: #fff" title="Buscar organización">
                            <i class="fas fa-list-alt"></i> Seleccione su Organización
                        </a>
                    </span>
                    <div class="col-md-9">
                        <span class="grupo">
                            <g:hiddenField id="unidadEjecutora" name="unidadEjecutora.id" />
                            %{--                            <g:select id="unidadEjecutora" name="unidadEjecutora.id"--}%
                            %{--                                      from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2), [sort: 'nombre'])}"--}%
                            %{--                                      optionKey="id" value="${convenio?.planesNegocio?.unidadEjecutora?.id}"--}%
                            %{--                                      class="many-to-one form-control input-sm"/>--}%
                            <g:textField id="unidadEjecutoraName" name="unidadEjecutora.nombre" class="form-control" readonly="true"/>

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

        if(unej){
            location.href="${createLink(controller: 'encuesta', action: 'iniciaEncu')}" + "?unej=" + unej
        }else{
            var d = bootbox.dialog({
                id: "dlgError",
                title: "Alerta",
                class: "modal-sm",
                closeButton: false,
                message: "<i class='fa fa-exclamation-triangle fa-2x pull-left text-danger text-shadow'></i> <h3> Seleccione una organización </h3>",
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



