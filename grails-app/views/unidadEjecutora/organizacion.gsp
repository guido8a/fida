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


<div class="btn-group">
    <a href="${createLink(controller: 'unidadEjecutora', action: 'organizacion')}" id="btnNuevaOrganizacion"
       class="btn btn-sm btn-success" title="Consultar artículo">
        <i class="fas fa-plus"></i> Nueva Organización
    </a>
    <a href="#" id="btnGuardar" class="btn btn-sm btn-success" title="Guardar información">
        <i class="fa fa-save"></i> Guardar
    </a>
    <g:if test="${unidad?.id}">
        <a href="#" id="btnEliminarOrganizacion" class="btn btn-sm btn-danger" title="Guardar información">
            <i class="fa fa-trash"></i> Eliminar
        </a>
    </g:if>
</div>
<a href="#" id="btnBuscarConvenio"
   class="btn btn-sm btn-info" title="Buscar unidad">
    <i class="fas fa-list-alt"></i> Lista de organizaciones
</a>



<h3 style="text-align: center">Organizaciones</h3>

<div class="panel panel-primary col-md-12">
    <g:if test="${unidad?.id}">
    <div class="panel-heading" style="padding: 3px; margin-top: 2px; text-align: ${unidad?.id ? 'center' : 'left'}">
            <a href="#" id="btnDocumentos" class="btn btn-sm btn-info" title="Consultar documentos">
                <i class="fas fa-book-reader"></i> Biblioteca
            </a>
            <a href="#" id="btnRepresentante" class="btn btn-sm btn-info" title="Consultar documentos">
                <i class="fas fa-user"></i> Representante
            </a>
            <a href="#" id="btnBeneficiario" class="btn btn-sm btn-info" title="Consultar documentos">
                <i class="fas fa-user-friends"></i> Beneficiarios
            </a>
            <a href="#" id="btnDatos" class="btn btn-sm btn-info" title="Datos de la organización">
                <i class="fa fa-scroll"></i> Datos Organización
            </a>
            <a href="#" id="btnEtnias" class="btn btn-sm btn-info" title="Etnias">
                <i class="fa fa-user"></i> Composición Étnica
            </a>
            <a href="#" id="btnCategoria" class="btn btn-sm btn-info" title="Categorias">
                <i class="fas fa-paperclip"></i> Categorías
            </a>
            <a href="#" id="btnNecesidad" class="btn btn-sm btn-info" title="Necesidades">
                <i class="fas fa-cart-plus"></i> Necesidades
            </a>
            <a href="#" id="btnTalleres" class="btn btn-sm btn-warning" title="Talleres">
                <i class="fas fa-users-cog"></i> Talleres
            </a>
            <a href="#" id="btnPlanes" class="btn btn-sm btn-warning" title="Planes">
                <i class="fas fa-briefcase"></i> Planes de negocio
            </a>
    </div>
        </g:if>

    <g:form class="form-horizontal" name="frmSaveUnidad" controller="unidadEjecutora" action="saveUnidad_ajax">
        <g:hiddenField name="id" value="${unidad?.id}"/>
        <div class="form-group ${hasErrors(bean: unidad, field: 'provincia', 'error')}" style="margin-top: 10px">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Provincia
                </label>
                <div class="col-md-2">
                    <g:hiddenField name="provincia" value="${unidad?.parroquia?.canton?.provincia?.id}"/>
                    <input name="provinciaName" id="provinciaTexto" type='text' class="form-control" readonly="" value="${unidad?.parroquia?.canton?.provincia?.nombre}"/>
                </div>
            </span>
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Cantón
                </label>
                <div class="col-md-2">
                    <input name="canton" id="cantonTexto" type='text' class="form-control" readonly="" value="${unidad?.parroquia?.canton?.nombre}"/>
                </div>
            </span>
            <span class="grupo">
                <label class="col-md-1 control-label text-info">
                    Parroquia
                </label>
                <div class="col-md-3">
                    <g:hiddenField name="parroquia" value="${unidad?.parroquia?.id}"/>
                    <input name="parroquiaName" id="parroquiaTexto" type='text' class="form-control" required="" readonly="" value="${unidad?.parroquia?.nombre}"/>
                </div>
            </span>
            <a href="#" class="btn btn-sm btn-info buscarParroquia" title="Buscar ubicación geográfica">
                <i class="fa fa-search"></i> Buscar
            </a>
        </div>
        <div class="form-group ${hasErrors(bean: unidad, field: 'nombre', 'error')} ${hasErrors(bean: unidad, field: 'sigla', 'error')}">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>

                <div class="col-md-7">
                    <g:textField name="nombre" maxlength="255" class="form-control required valid input-sm"
                                 value="${unidad?.nombre}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <label for="sigla" class="col-md-1 control-label text-info">
                    Sigla
                </label>

                <div class="col-md-1">
                    <g:textField name="sigla" maxlength="7" class="form-control input-sm" value="${unidad?.sigla}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
        <div class="form-group ${hasErrors(bean: unidad, field: 'codigo', 'error')}  ${hasErrors(bean: unidad, field: 'fechaInicio', 'error')}">
            <span class="grupo">
                <label class="col-md-2 control-label text-info">
                    Fecha Inicio
                </label>

                <div class="col-md-2">
                    <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control"
                           value="${unidad?.fechaInicio?.format("dd-MM-yyyy")}"/>

                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <label for="ruc" class="col-md-2 control-label text-info">
                    Ruc
                </label>

                <div class="col-md-2">
                    <g:textField name="ruc" maxlength="13" class="form-control valid input-sm" value="${unidad?.ruc}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <label for="rup" class="col-md-1 control-label text-info">
                    Rup
                </label>

                <div class="col-md-2">
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
                    <g:textArea name="direccion" maxlength="127" class="form-control input-sm" style="resize: none"
                                value="${unidad?.direccion}"/>
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
                    <g:textField name="referencia" maxlength="255" class="form-control input-sm"
                                 value="${unidad?.referencia}"/>
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
                    <g:textField name="objetivo" maxlength="63" class="form-control input-sm"
                                 value="${unidad?.objetivo}"/>
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
                    <g:textField name="telefono" maxlength="63" class="form-control digits input-sm"
                                 value="${unidad?.telefono}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="grupo">
                <label for="mail" class="col-md-2 control-label text-info">
                    Mail
                </label>

                <div class="col-md-4">
                    <g:textField name="mail" maxlength="63" class="form-control email input-sm"
                                 value="${unidad?.mail}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: unidad, field: 'zona', 'error')} ${hasErrors(bean: unidad, field: 'orden', 'error')}">
            <span class="grupo">
                <label for="numero" class="col-md-2 control-label text-info">
                    Zona
                </label>

                <div class="col-md-1">
                    <g:textField name="numero" maxlength="10" class="form-control digits input-sm"
                                 value="${unidad?.zona ?: ''}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
            <span class="col-md-1"></span>
%{--
            <span class="grupo">
                <label for="orden" class="col-md-3 control-label text-info">
                    Orden
                </label>

                <div class="col-md-1">
                    <g:textField name="orden" maxlength="3" class="form-control digits input-sm"
                                 value="${unidad?.orden ?: ''}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
--}%
            <span class="grupo">
                <label for="legal" class="col-md-3 control-label text-info">
                    Legalmente conformada
                </label>

                <div class="col-md-1">
                    <g:select name="legal" from="${[1: 'SI', 0: 'NO']}" class="form-control" optionKey="key"
                              optionValue="value" value="${unidad?.legal}"/>
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
                    <g:textArea name="observaciones" maxlength="127" class="form-control input-sm" style="resize: none"
                                value="${unidad?.observaciones}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>

        <div class="form-group ${hasErrors(bean: unidad, field: 'legal', 'error')}${hasErrors(bean: unidad, field: 'anio', 'error')} ">
            <span class="grupo">
                <label for="anio" class="col-md-2 control-label text-info">
                    Número de Años
                </label>

                <div class="col-md-1">
%{--                    <g:textField name="anio" maxlength="2" class="form-control digits input-sm" value="${unidad?.anio ?: ''}"/>--}%
                     <g:textField name="anio" maxlength="2" class="form-control digits input-sm" readonly=""
                         value="${anios}"/>
                    <p class="help-block ui-helper-hidden"></p>
                </div>
            </span>
        </div>
    </g:form>

</div>

<script type="text/javascript">

    $("#btnRepresentante").click(function () {
            var dialog = cargarLoader("Cargando...");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'unidadEjecutora', action: 'representante_ajax')}',
                data:{
                    id: '${unidad?.id}'
                },
                success:function (msg) {
                    dialog.modal('hide');
                    var ad = bootbox.dialog({
                        id    : "dlgBuscarRepresentante",
                        title : "Representante Legal de: ${unidad.nombre}",
                        class : "modal-lg",
                        closeButton: false,
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            }
                        }
                    }); //dialog
                }
            });
    })

    $("#btnTalleres").click(function () {
        location.href="${createLink(controller: 'taller', action: 'listTaller')}?id=" + '${unidad?.id}'
    });

    $("#btnPlanes").click(function () {
        location.href="${createLink(controller: 'planesNegocio', action: 'planes')}/" + '${unidad?.id}'
    });

    $("#btnBeneficiario").click(function (){
        location.href="${createLink(controller: 'unidadEjecutora', action: 'beneficiarios')}/" + '${unidad?.id}'
    });

    $('#datetimepicker1').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        // inline: true,
        sideBySide: true,
        // showClose: true,
        icons: {
            // close: 'closeText'
        }
    });

    $("#btnEliminarOrganizacion").click(function () {
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> ¿Está seguro de querer eliminar esta organización?", function (res) {
            if(res){
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'unidadEjecutora', action: 'borrarUnidad_ajax')}',
                    data:{
                        id: '${unidad?.id}'
                    },
                    success: function (msg) {
                        var parts = msg.split("_");
                        if(parts[0] == 'ok'){
                            log("Unidad borrada correctamente","success");
                            setTimeout(function () {
                                location.href="${createLink(controller: 'unidadEjecutora', action: 'organizacion')}"
                            }, 1000);
                        }else{
                            if(parts[0] == 'res'){
                                bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i>" + parts[1])
                            }else{
                                log("Error al borrar la unidad","error")
                            }
                        }
                    }
                });
            }
        });
    });

    $("#btnDocumentos").click(function () {
        location.href="${createLink(controller: 'documento', action: 'listConvenio')}?id=" + '${unidad?.id}'
    });

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

    %{--$("#btnEliminar").click(function () {--}%
    %{--    bootbox.dialog({--}%
    %{--        title: "Alerta",--}%
    %{--        message: "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +--}%
    %{--            "¿Está seguro que desea eliminar el unidad? Esta acción no se puede deshacer.</p>",--}%
    %{--        buttons: {--}%
    %{--            cancelar: {--}%
    %{--                label: "Cancelar",--}%
    %{--                className: "btn-primary",--}%
    %{--                callback: function () {--}%
    %{--                }--}%
    %{--            },--}%
    %{--            eliminar: {--}%
    %{--                label: "<i class='fa fa-trash-o'></i> Eliminar",--}%
    %{--                className: "btn-danger",--}%
    %{--                callback: function () {--}%
    %{--                    var dialog = cargarLoader("Borrando...");--}%
    %{--                    $.ajax({--}%
    %{--                        type: "POST",--}%
    %{--                        url: '${createLink(controller:'unidad', action:'delete_ajax')}',--}%
    %{--                        data: {--}%
    %{--                            id: '${unidad?.id}'--}%
    %{--                        },--}%
    %{--                        success: function (msg) {--}%
    %{--                            dialog.modal('hide');--}%
    %{--                            var parts = msg.split("*");--}%
    %{--                            log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)--}%
    %{--                            if (parts[0] == "SUCCESS") {--}%
    %{--                                setTimeout(function () {--}%
    %{--                                    location.href = "${createLink(controller: 'unidad', action: 'unidad')}"--}%
    %{--                                }, 1000);--}%
    %{--                            } else {--}%
    %{--                                closeLoader();--}%
    %{--                            }--}%
    %{--                        }--}%
    %{--                    });--}%
    %{--                }--}%
    %{--            }--}%
    %{--        }--}%
    %{--    });--}%
    %{--});--}%

    $("#btnGuardar").click(function () {
        submitFormUnidad();
    });

    function submitFormUnidad() {
        var $form = $("#frmSaveUnidad");
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
                    var parts = msg.split("_");
                    if(parts[0] == 'ok'){
                        log(parts[1], "success");
                        setTimeout(function () {
                            location.href="${createLink(controller: 'unidadEjecutora', action: 'organizacion')}/" + parts[2]
                        }, 1000);
                    }else{
                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + parts[1] + '</strong>');
                        return false;
                    }
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

    var bp;

    $(".buscarParroquia").click(function () {
        var dialog = cargarLoader("Cargando...");
        $(this).attr('disabled', 'disabled');
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'parroquia', action: 'buscarParroquia_ajax')}',
            data: {
                tipo: 3
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

    $("#btnEtnias").click(function () {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'etniaOrganizacion',action:'formEtnias_ajax')}",
            data: {
                unidad: '${unidad?.id}'
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgEtnias",
                    title: "Etnias de la organización",
                    // class : "modal-lg",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Salir",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    });

    $("#btnCategoria").click(function () {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'categoria',action:'formCategoria_ajax')}",
            data: {
                unidad: '${unidad?.id}'
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgCategorias",
                    title: "Categorías de la organización",
                    // class : "modal-lg",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Salir",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    });

    $("#btnNecesidad").click(function () {
        $.ajax({
            type: "POST",
            url: "${createLink(controller: 'necesidad',action:'formNecesidad_ajax')}",
            data: {
                unidad: '${unidad?.id}'
            },
            success: function (msg) {
                var b = bootbox.dialog({
                    id: "dlgNecesidades",
                    title: "Tipos de necesidades de la organización",
                    // class : "modal-lg",
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Salir",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    });

</script>
</body>
</html>