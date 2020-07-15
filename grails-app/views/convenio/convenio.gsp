<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 13/07/20
  Time: 10:30
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Convenio</title>

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

    .izquierda{
        margin-left: 4px;
    }
    </style>

</head>

<body>
<h3 style="text-align: center">Convenios de Economía Popular y Solidaria</h3>
<div class="panel panel-primary col-md-12">
    <div class="panel-heading" style="padding: 3px; margin-top: 2px; text-align: ${convenio?.id ? 'center' : 'left'}">
        <a href="#" id="btnBuscarConvenio"
           class="btn btn-sm btn-info" title="Buscar convenio">
            <i class="fas fa-list-alt"></i> Lista de convenios
        </a>
        <a href="${createLink(controller: 'convenio', action: 'convenio')}" id="btnNuevoConvenio"
           class="btn btn-sm btn-success" title="Consultar artículo">
            <i class="fas fa-plus"></i> Nuevo convenio
        </a>
        <g:if test="${convenio?.id}">
            <a href="#" id="btnAdministradorCon" class="btn btn-sm btn-info" title="Administrador del convenio">
                <i class="fa fa-user"></i> Administrador
            </a>
            <a href="#" id="btnEstado" class="btn btn-sm btn-info" title="Indicadores">
                <i class="fa fa-scroll"></i> Indicadores
            </a>
            <a href="${createLink(controller: 'documento', action: 'listConvenio')}" id="btnNuevoConvenio"
               class="btn btn-sm btn-info" title="Consultar artículo">
                <i class="fas fa-book-reader"></i> Biblioteca
            </a>
            <a href="#" id="editMrlg" class="btn btn-sm btn-info" title="Ver registro">
                <i class="fa fa-clipboard"></i> Plan de negocio solidario
            </a>
        </g:if>
        <a href="#" id="btnGuardar" class="btn btn-sm btn-success" title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
        <g:if test="${convenio?.id}">
            <a href="#" id="btnEliminar" class="btn btn-sm btn-danger" title="Guardar información">
                <i class="fa fa-trash"></i> Eliminar
            </a>
        </g:if>
    </div>

    <div class="tab-content">
        <div id="home" class="tab-pane fade in active">
            <g:form class="form-horizontal" name="frmConvenio" controller="convenio" action="save_ajax" method="POST">
                <g:hiddenField name="id" value="${convenio?.id}"/>
                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Parroquia</span>
                        <div class="col-md-4">
                            <g:hiddenField name="parroquia" id="parroquia" value="${convenio?.parroquia?.id}"/>
                            <span class="grupo">
                                <div class="input-group input-group-sm" >
                                    <input type="text" class="form-control buscarParroquia" name="parroquiaName"
                                           id="parroquiaTexto" value="${convenio?.id ? convenio?.parroquia?.nombre + " (" + convenio?.parroquia?.canton?.provincia?.nombre + ")" : ''}">
                                    <span class="input-group-btn">
                                        <a href="#" class="btn btn-info buscarParroquia" title="Buscar Parroquia">
                                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                        </a>
                                    </span>
                                </div>
                            </span>
                        </div>
                        <span class="col-md-2 label label-primary text-info mediano">Organización</span>
                        <div class="col-md-4">
                            <span class="grupo">
                                <g:select id="unidadEjecutora" name="unidadEjecutora.id"
                                          from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2))}"
                                          optionKey="id" value="${convenio?.unidadEjecutora?.id}"
                                          class="many-to-one form-control input-sm"/>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Código</span>

                        <div>
                            <div class="col-md-4">
                                <span class="grupo">
                                    <g:textField name="codigo" class="form-control input-sm required allCaps"
                                                 value="${convenio?.codigo}"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Nombre</span>
                        <div>
                            <div class="col-md-10">
                                <span class="grupo">
                                    <g:textField name="nombre" maxlength="63" class="form-control input-sm required"
                                                 value="${convenio?.nombre}"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Objetivo</span>

                        <div class="col-md-10">
                            <span class="grupo">
                                <g:textArea name="objetivo" rows="5" maxlength="1024" class="form-control input-sm required"
                                            value="${convenio?.objetivo}" style="resize: none"/>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Inicio</span>
                        <span class="grupo">
                            <div class="col-md-2 ">
                                <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"
                                       value="${convenio?.fechaInicio?.format("dd-MM-yyyy")}"/>

                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
                        <span class="col-md-2 mediano"></span>
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Fin</span>
                        <span class="grupo">
                            <div class="col-md-2">
                                <input name="fechaFin" id='fechaFin' type='text' class="form-control"
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
                            <g:textField name="monto" class="form-control input-sm required"
                                         value="${convenio?.monto}"/>
                        </div>
                    </div>
                </div>

                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Plazo</span>

                        <div class="col-md-2">
                            <g:textField name="plazo" class="form-control input-sm required"
                                         value="${convenio?.plazo}"/>
                        </div>
                        <span class="col-md-2 mediano"></span>
                        <span class="col-md-2 label label-primary text-info mediano">Informar cada:</span>

                        <div class="col-md-2">
                            <g:textField name="periodo" class="form-control input-sm required"
                                         value="${convenio?.periodo}"/>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>

<script type="text/javascript">

    $("#btnAdministradorCon").click(function () {
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'administradorConvenio', action: 'administrador_ajax')}',
            data:{
                id: '${convenio?.id}'
            },
            success:function (msg) {
                dialog.modal('hide');
                var ad = bootbox.dialog({
                    id    : "dlgBuscarAdministradorCon",
                    title : "Asignar administrador",
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
    });

    $("#btnEliminar").click(function () {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea eliminar el convenio? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash-o'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        var dialog = cargarLoader("Borrando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'convenio', action:'delete_ajax')}',
                            data    : {
                                id : '${convenio?.id}'
                            },
                            success : function (msg) {
                                dialog.modal('hide');
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "SUCCESS") {
                                    setTimeout(function () {
                                        location.href="${createLink(controller: 'convenio', action: 'convenio')}"
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
                url         : $form.attr("action"),
                type        : 'POST',
                data        : formData,
                async       : false,
                cache       : false,
                contentType : false,
                processData : false,
                success     : function (msg) {
                    dialog.modal('hide');
                    var parts = msg.split("*");
                    if (parts[0] == "SUCCESS") {
                        log(parts[1],"success");
                        setTimeout(function () {
                            location.href="${createLink(controller: 'convenio', action: 'convenio')}/" + parts[2]
                        }, 800);
                    } else {
                        if(parts[0] == 'er'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> " + parts[1])
                        }else{
                            log(parts[1],"error");
                            return false;
                        }
                    }
                },
                error       : function () {
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
            url: '${createLink(controller: 'convenio', action: 'buscarConvenio_ajax')}',
            data:{
            },
            success:function (msg) {
                dialog.modal('hide');
                var b = bootbox.dialog({
                    id    : "dlgBuscarConvenio",
                    title : "Buscar Convenio",
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
    });

    $(".buscarParroquia").click(function () {
        var dialog = cargarLoader("Cargando...");
        $(this).attr('disabled','disabled');
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'parroquia', action: 'buscarParroquia_ajax')}',
            data:{
                tipo: 2
            },
            success:function (msg) {
                dialog.modal('hide');
                bp = bootbox.dialog({
                    id    : "dlgBuscarComunidad",
                    title : "Buscar Parroquia",
                    class : "modal-lg",
                    closeButton: false,
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                                $(".buscarParroquia").removeAttr('disabled');
                            }
                        }
                    }
                }); //dialog
            }
        });
    });

    function cerrarDialogoParroquia(){
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