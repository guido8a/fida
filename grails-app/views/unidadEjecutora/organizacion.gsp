<html>
<head>
    <meta name="layout" content="main">
    <title>Organizaciones</title>

    <style type="text/css">
    .mediano {
        margin-top: 5px;
        padding-top: 9px;
        height: 30px;
        font-size: inherit;
        /*font-size: medium;*/
        text-align: right;
    }

    .sobrepuesto {
        position: absolute;
        top: 3px;
        font-size: 14px;
    }

    .negrita {
        font-weight: bold;
    }

    .izquierda {
        margin-left: 4px;
    }
    </style>

</head>

<body>
<h3 style="text-align: center">Organizaciones</h3>

<div class="panel panel-primary col-md-12">
    <div class="panel-heading" style="padding: 3px; margin-top: 2px; text-align: ${unidad?.id ? 'center' : 'left'}">
        <a href="#" id="btnBuscarConvenio"
           class="btn btn-sm btn-info" title="Buscar unidad">
            <i class="fas fa-list-alt"></i> Lista de organizaciones
        </a>
        <g:if test="${unidad?.id}">
            <a href="${createLink(controller: 'documento', action: 'listConvenio')}" id="btnNuevoConvenio"
               class="btn btn-sm btn-info" title="Consultar artículo">
                <i class="fas fa-book-reader"></i> Datos Adicionales
            </a>
            <a href="#" id="btnAdministradorCon" class="btn btn-sm btn-info" title="Administrador del unidad">
                <i class="fa fa-user"></i> Composición Étnica
            </a>
            <a href="#" id="btnPlanNegocio" class="btn btn-sm btn-warning" title="Plan de negocio Solidario">
                <i class="fa fa-hands-helping"></i> Plan de negocio Solidario
            </a>
%{--
            <a href="#" id="btnDatos" class="btn btn-sm btn-info" title="Datos de la organización">
                <i class="fa fa-scroll"></i> Datos Organización
            </a>
--}%
        </g:if>
        <a href="${createLink(controller: 'unidad', action: 'unidad')}" id="btnNuevoConvenio"
           class="btn btn-sm btn-success" title="Consultar artículo">
            <i class="fas fa-plus"></i> Nuevo unidad
        </a>
        <a href="#" id="btnGuardar" class="btn btn-sm btn-success" title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
        <g:if test="${unidad?.id}">
            <a href="#" id="btnEliminar" class="btn btn-sm btn-danger" title="Guardar información">
                <i class="fa fa-trash"></i> Eliminar
            </a>
        </g:if>
    </div>

%{--</div>--}%

<g:form class="form-horizontal" name="frmSaveUnidad" controller="unidadEjecutora" action="saveUnidad_ajax">
    <g:hiddenField name="id" value="${unidad?.id}"/>

%{--
    <div class="form-group ${hasErrors(bean: unidad, field: 'padre', 'error')}  ">
        <span class="grupo">
            <label for="padre" class="col-md-2 control-label text-info">
                Unidad Padre
            </label>
            <div class="col-md-6">
                <g:if test="${unidad?.id}">
                    <g:select from="${seguridad.UnidadEjecutora.findAllByFechaFinIsNull().sort{it.nombre} - unidad}" name="padre" class="form-control input-sm"
                              value="${unidad?.padre?.id}" noSelection="[null:'- Ninguna -']" optionKey="id" optionValue="nombre"/>
                </g:if>
                <g:else>
                    <g:select from="${seguridad.UnidadEjecutora.findAllByFechaFinIsNull().sort{it.nombre}}" name="padre" class="form-control input-sm"
                              value="${unidad?.padre?.id}" noSelection="[null:'- Ninguna -']" optionKey="id" optionValue="nombre"/>
                </g:else>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
--}%

    <div class="form-group ${hasErrors(bean: unidad, field: 'tipoInstitucion', 'error')} ${hasErrors(bean: unidad, field: 'codigo', 'error')}">
%{--
        <span class="grupo">
            <label for="tipoInstitucion" class="col-md-2 control-label text-info">
                Tipo Institución
            </label>
            <div class="col-md-4">
                <g:select from="${seguridad.TipoInstitucion.list().sort{it.descripcion}}" name="tipoInstitucion" class="form-control input-sm"
                          value="${unidad?.tipoInstitucion?.id}" optionKey="id" optionValue="descripcion"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
--}%
%{--
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>
            <div class="col-md-3">
                <g:textField name="codigo" maxlength="4" class="form-control input-sm" value="${unidad?.codigo}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
--}%

    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'provincia', 'error')}">
        <span class="grupo">
            <label for="provincia" class="col-md-2 control-label text-info">
                Provincia
            </label>
            <div class="col-md-4">
                <g:select from="${geografia.Provincia.list().sort{it.nombre}}" name="provincia" class="form-control input-sm"
                          value="${unidad?.provincia?.id}" optionKey="id" optionValue="nombre"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Cantón
            </label>
            <div class="col-md-3" id="divCanton">

            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'codigo', 'error')}  ${hasErrors(bean: unidad, field: 'fechaInicio', 'error')}">
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Parroquia
            </label>
            <div class="col-md-4" id="divParroquia">

            </div>
        </span>
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Fecha Inicio
            </label>
            <div class="col-md-3">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control" value="${unidad?.fechaInicio?.format("dd-MM-yyyy")}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'nombre', 'error')} ${hasErrors(bean: unidad, field: 'sigla', 'error')}">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <div class="col-md-6">
                <g:textField name="nombre" maxlength="255" class="form-control required valid input-sm" value="${unidad?.nombre}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="sigla" class="col-md-1 control-label text-info">
                Sigla
            </label>
            <div class="col-md-2">
                <g:textField name="sigla" maxlength="7" class="form-control input-sm" value="${unidad?.sigla}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'ruc', 'error')} ${hasErrors(bean: unidad, field: 'rup', 'error')}">
        <span class="grupo">
            <label for="ruc" class="col-md-2 control-label text-info">
                Ruc
            </label>
            <div class="col-md-4">
                <g:textField name="ruc" maxlength="13" class="form-control valid input-sm" value="${unidad?.ruc}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="rup" class="col-md-1 control-label text-info">
                Rup
            </label>
            <div class="col-md-4">
                <g:textField name="rup" maxlength="13" class="form-control input-sm" value="${unidad?.rup}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'direccion', 'error')} ">
        <span class="grupo">
            <label for="direccion" class="col-md-2 control-label text-info">
                Dirección
            </label>
            <div class="col-md-9">
                <g:textArea name="direccion"  maxlength="127" class="form-control input-sm" style="resize: none" value="${unidad?.direccion}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'sector', 'error')} ">
        <span class="grupo">
            <label for="sector" class="col-md-2 control-label text-info">
                Sector
            </label>
            <div class="col-md-9">
                <g:textField name="sector" value="${unidad?.sector}" class="form-control" maxlength="127"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'referencia', 'error')} ">
        <span class="grupo">
            <label for="referencia" class="col-md-2 control-label text-info">
                Referencia
            </label>
            <div class="col-md-9">
                <g:textField name="referencia"  maxlength="255" class="form-control input-sm" value="${unidad?.referencia}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'objetivo', 'error')} ">
        <span class="grupo">
            <label for="objetivo" class="col-md-2 control-label text-info">
                Objetivo
            </label>
            <div class="col-md-9">
                <g:textField name="objetivo"  maxlength="63" class="form-control input-sm" value="${unidad?.objetivo}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'telefono', 'error')} ${hasErrors(bean: unidad, field: 'mail', 'error')}">
        <span class="grupo">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <div class="col-md-3">
                <g:textField name="telefono" maxlength="63" class="form-control digits input-sm" value="${unidad?.telefono}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="mail" class="col-md-2 control-label text-info">
                Mail
            </label>
            <div class="col-md-4">
                <g:textField name="mail" maxlength="63" class="form-control email input-sm" value="${unidad?.mail}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'zona', 'error')} ${hasErrors(bean: unidad, field: 'orden', 'error')}">
        <span class="grupo">
            <label for="numero" class="col-md-2 control-label text-info">
                Zona
            </label>
            <div class="col-md-2">
                <g:textField name="numero" maxlength="10" class="form-control digits input-sm" value="${unidad?.zona ?: ''}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="col-md-1"></span>
        <span class="grupo">
            <label for="orden" class="col-md-2 control-label text-info">
                Orden
            </label>
            <div class="col-md-2">
                <g:textField name="orden" maxlength="3" class="form-control digits input-sm" value="${unidad?.orden ?: ''}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'observaciones', 'error')} ">
        <span class="grupo">
            <label for="observaciones" class="col-md-2 control-label text-info">
                Observaciones
            </label>
            <div class="col-md-9">
                <g:textArea name="observaciones"  maxlength="127" class="form-control input-sm" style="resize: none" value="${unidad?.observaciones}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'legal', 'error')}${hasErrors(bean: unidad, field: 'anio', 'error')} ">
        <span class="grupo">
            <label for="anio" class="col-md-2 control-label text-info">
                Número de Años
            </label>
            <div class="col-md-2">
                <g:textField name="anio" maxlength="2" class="form-control digits input-sm" value="${unidad?.anio ?: ''}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="legal" class="col-md-3 control-label text-info">
                Legalmente conformada
            </label>
            <div class="col-md-2">
                <g:select name="legal" from="${[1:'SI',0:'NO']}" class="form-control" optionKey="key" optionValue="value" value="${unidad?.legal}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

</div>

<script type="text/javascript">

$("#btnDatos").click(function () {
    location.href = "${createLink(controller: 'datosOrganizacion', action: 'datos')}/" + '${unidad?.id}'
});

$("#btnPlanNegocio").click(function () {
    location.href = "${createLink(controller: 'plan', action: 'planesConvenio')}/" + '${unidad?.id}'
});

$("#btnAdministradorCon").click(function () {
    var dialog = cargarLoader("Cargando...");
    $.ajax({
        type: 'POST',
        url: '${createLink(controller: 'administradorConvenio', action: 'administrador_ajax')}',
        data: {
            id: '${unidad?.id}'
        },
        success: function (msg) {
            dialog.modal('hide');
            var ad = bootbox.dialog({
                id: "dlgBuscarAdministradorCon",
                title: "Asignar administrador",
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

$("#btnEliminar").click(function () {
    bootbox.dialog({
        title: "Alerta",
        message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
            "¿Está seguro que desea eliminar el unidad? Esta acción no se puede deshacer.</p>",
        buttons: {
            cancelar: {
                label: "Cancelar",
                className: "btn-primary",
                callback: function () {
                }
            },
            eliminar: {
                label: "<i class='fa fa-trash-o'></i> Eliminar",
                className: "btn-danger",
                callback: function () {
                    var dialog = cargarLoader("Borrando...");
                    $.ajax({
                        type: "POST",
                        url: '${createLink(controller:'unidad', action:'delete_ajax')}',
                        data: {
                            id: '${unidad?.id}'
                        },
                        success: function (msg) {
                            dialog.modal('hide');
                            var parts = msg.split("*");
                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                            if (parts[0] == "SUCCESS") {
                                setTimeout(function () {
                                    location.href = "${createLink(controller: 'unidad', action: 'unidad')}"
                                }, 1000);
                            } else {
                                closeLoader();
                            }
                        }
                    });
                }
            }
        }
    });
});

$("#btnGuardar").click(function () {
    submitFormConvenio();
});

function submitFormConvenio() {
    var $form = $("#frmConvenio");
    if ($form.valid()) {
        var formData = new FormData($form[0]);
        var dialog = cargarLoader("Guardando...");
        $.ajax({
            url: $form.attr("action"),
            type: 'POST',
            data: formData,
            async: false,
            cache: false,
            contentType: false,
            processData: false,
            success: function (msg) {
                dialog.modal('hide');
                var parts = msg.split("*");
                if (parts[0] == "SUCCESS") {
                    log(parts[1], "success");
                    setTimeout(function () {
                        location.href = "${createLink(controller: 'unidad', action: 'unidad')}/" + parts[2]
                    }, 800);
                } else {
                    if (parts[0] == 'er') {
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> " + parts[1])
                    } else {
                        log(parts[1], "error");
                        return false;
                    }
                }
            },
            error: function () {
            }
        });
    } else {
        return false;
    } //else
    return false;
}

$("#btnBuscarConvenio").click(function () {
    var dialog = cargarLoader("Cargando...");
    $.ajax({
        type: 'POST',
        url: '${createLink(controller: 'unidadEjecutora', action: 'buscarOrga_ajax')}',
        data: {},
        success: function (msg) {
            dialog.modal('hide');
            var b = bootbox.dialog({
                id: "dlgBuscarConvenio",
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

var bp

$(".buscarParroquia").click(function () {
    var dialog = cargarLoader("Cargando...");
    $(this).attr('disabled', 'disabled');
    $.ajax({
        type: 'POST',
        url: '${createLink(controller: 'parroquia', action: 'buscarParroquia_ajax')}',
        data: {
            tipo: 2
        },
        success: function (msg) {
            dialog.modal('hide');
            bp = bootbox.dialog({
                id: "dlgBuscarComunidad",
                title: "Buscar Parroquia",
                class: "modal-lg",
                closeButton: false,
                message: msg,
                buttons: {
                    cancelar: {
                        label: "Cancelar",
                        className: "btn-primary",
                        callback: function () {
                            $(".buscarParroquia").removeAttr('disabled');
                        }
                    }
                }
            }); //dialog
        }
    });
});

function cerrarDialogoParroquia() {
    bp.dialog().dialog('open');
    bp.modal("hide");
}

$('#fechaInicio').datetimepicker({
    locale: 'es',
    format: 'DD-MM-YYYY',
    daysOfWeekDisabled: [0, 6],
    sideBySide: true,
    showClose: true,
});

$('#fechaFin').datetimepicker({
    locale: 'es',
    format: 'DD-MM-YYYY',
    daysOfWeekDisabled: [0, 6],
    sideBySide: true,
    showClose: true,
});

</script>
</body>
</html>