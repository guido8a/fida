<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 13/07/20
  Time: 10:30
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Planes de Negocio</title>

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
<h3 style="text-align: center">Plan de Negocio Solidario</h3>
<div class="panel panel-primary col-md-12">
    <div class="panel-heading" style="padding: 3px; margin-top: 2px; text-align: ${plns?.id ? 'center' : 'left'}">
        <a href="#" id="btnBuscarConvenio"
           class="btn btn-sm btn-info" title="Buscar plns">
            <i class="fas fa-list-alt"></i> Retornar a Organización
        </a>
        <a href="#" id="btnBuscarConvenio"
           class="btn btn-sm btn-info" title="Buscar plns">
            <i class="fas fa-list-alt"></i> Lista de Planes
        </a>
        <g:if test="${plns?.id}">
            <a href="#" id="btnDocumentos" class="btn btn-sm btn-info" title="Consultar documentos">
                <i class="fas fa-book-reader"></i> Biblioteca
            </a>
            <a href="#" id="btnPlanNegocio" class="btn btn-sm btn-warning" title="Plan de negocio Solidario">
                <i class="fa fa-hands-helping"></i> Plan de negocio Solidario
            </a>
        </g:if>
        <a href="${createLink(controller: 'plns', action: 'plns')}" id="btnNuevoConvenio"
           class="btn btn-sm btn-success" title="Consultar artículo">
            <i class="fas fa-plus"></i> Nuevo plns
        </a>
        <a href="#" id="btnGuardar" class="btn btn-sm btn-success" title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
        <g:if test="${plns?.id}">
            <a href="#" id="btnEliminar" class="btn btn-sm btn-danger" title="Guardar información">
                <i class="fa fa-trash"></i> Eliminar
            </a>
        </g:if>
    </div>

    <div class="tab-content">
        <div id="home" class="tab-pane fade in active">
            <g:form class="form-horizontal" name="frmPlan" controller="planesNegocio" action="save_ajax" method="POST">
                <g:hiddenField name="id" value="${plns?.id}"/>
                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Organización</span>
                        <div class="col-md-10">
                            <span class="grupo">
                                <g:select id="unidadEjecutora" name="unidadEjecutora.id"
                                          from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2))}"
                                          optionKey="id" value="${plns?.unidadEjecutora?.id}"
                                          class="many-to-one form-control input-sm"/>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="row izquierda">
                     <div class="col-md-12 input-group">
                         <span class="grupo">
                              <span class="col-md-2 label label-primary text-info mediano">Provincia</span>
                              <div class="col-md-2">
                                  <g:hiddenField name="provincia" value="${plns?.unidadEjecutora?.parroquia?.canton?.provincia?.id}"/>
                            <input name="provinciaName" id="provinciaTexto" type='text' class="form-control"
                                   readonly="" value="${plns?.unidadEjecutora?.parroquia?.canton?.provincia?.nombre}"/>
                        </div>
                    </span>
                    <span class="grupo">
                        <label class="col-md-1 control-label text-info">
                            Cantón
                        </label>
                        <div class="col-md-2">
                            <input name="canton" id="cantonTexto" type='text' class="form-control" readonly=""
                                   value="${plns?.unidadEjecutora?.parroquia?.canton?.nombre}"/>
                        </div>
                    </span>
                    <span class="grupo">
                        <label class="col-md-1 control-label text-info">
                            Parroquia
                        </label>
                        <div class="col-md-4">
                            <g:hiddenField name="parroquia" value="${unidad?.parroquia?.id}"/>
                            <input name="parroquiaName" id="parroquiaTexto" type='text' class="form-control"
                                   required="" readonly="" value="${plns?.unidadEjecutora?.parroquia?.nombre}"/>
                        </div>
                    </span>

                </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Nombre</span>
                        <div>
                            <div class="col-md-10">
                                <span class="grupo">
                                    <g:textField name="nombre" maxlength="63" class="form-control input-sm required"
                                                 value="${plns?.nombre}"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Objeto</span>

                        <div class="col-md-10">
                            <span class="grupo">
                                <g:textArea name="objeto" rows="2" maxlength="1024" class="form-control input-sm required"
                                            value="${plns?.objeto}" style="resize: none"/>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Nudo Crítico</span>

                        <div class="col-md-10">
                            <span class="grupo">
                                <g:textArea name="nudoCritico" rows="2" maxlength="1024" class="form-control input-sm required"
                                            value="${plns?.nudoCritico}" style="resize: none"/>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Fecha de Presentación</span>
                        <span class="grupo">
                            <div class="col-md-2 ">
                                <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"
                                       value="${plns?.fechaPresentacion?.format("dd-MM-yyyy")}"/>

                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
%{--                        <span class="col-md-1 mediano"></span>--}%
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Comité</span>
                        <span class="grupo">
                            <div class="col-md-2">
                                <input name="fechaFin" id='fechaComite' type='text' class="form-control"
                                       value="${plns?.fechaComite?.format("dd-MM-yyyy")}"/>

                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Aprobación</span>
                        <span class="grupo">
                            <div class="col-md-2">
                                <input name="fechaFin" id='fechaAprobacion' type='text' class="form-control"
                                       value="${plns?.fechaAprobacion?.format("dd-MM-yyyy")}"/>

                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
                    </div>
                </div>

                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Monto del Plan</span>
                        <div class="col-md-2">
                            <g:textField name="monto" class="form-control input-sm required"
                                         value="${plns?.monto}"/>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Calificación</span>
                        <div class="col-md-1">
                            <input name="calificacion" type='text' class="form-control"
                                value="${plns?.calificacion}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                        <span class="col-md-1"></span>
                        <span class="col-md-2 label label-primary text-info mediano">Inversión por Socio</span>
                        <div class="col-md-2">
                            <input name="calificacion" type='text' class="form-control"
                                value="${plns?.numeroSocios}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                    </div>
                </div>

                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Ventas proyectadas</span>
                        <div class="col-md-2">
                            <g:textField name="venta" class="form-control input-sm required"
                                         value="${plns?.venta}"/>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Costos proyectados</span>
                        <div class="col-md-2">
                            <input name="costo" type='text' class="form-control"
                                value="${plns?.costo}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Excedente</span>
                        <div class="col-md-2">
                            <input name="excedente" type='text' class="form-control"
                                value="${plns?.excedente}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                    </div>
                </div>

                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Valos Actual Neto</span>
                        <div class="col-md-2">
                            <g:textField name="van" class="form-control input-sm required"
                                         value="${plns?.van}"/>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Tasa Interna de Retorno</span>
                        <div class="col-md-2">
                            <input name="tir" type='text' class="form-control"
                                value="${plns?.tir}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Tasa</span>
                        <div class="col-md-2">
                            <input name="tasa" type='text' class="form-control"
                                value="${plns?.tasa}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                    </div>
                </div>

                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Capital de Trabajo</span>
                        <div class="col-md-2">
                            <g:textField name="capitalTrabajo" class="form-control input-sm required"
                                         value="${plns?.capitalTrabajo}"/>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Inversiones preooperativas y legales</span>
                        <div class="col-md-2">
                            <input name="inversiones" type='text' class="form-control"
                                value="${plns?.inversiones}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Terrenos y Construcciones</span>
                        <div class="col-md-2">
                            <input name="terreno" type='text' class="form-control"
                                value="${plns?.terreno}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                    </div>
                </div>

                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Maquinaria y Equipo</span>
                        <div class="col-md-2">
                            <input name="maquinaria" type='text' class="form-control"
                                value="${plns?.maquinaria}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Muebles y equipos de oficina</span>
                        <div class="col-md-2">
                            <input name="muebles" type='text' class="form-control"
                                value="${plns?.muebles}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                    </div>
                </div>

            </g:form>
        </div>
    </div>
</div>

<script type="text/javascript">

    $("#btnDocumentos").click(function () {
        location.href="${createLink(controller: 'documento', action: 'listConvenio')}?id=" +
            '${plns?.unidadEjecutora?.id}' + "&plns=" + '${plns?.id}'
    });

    $("#btnPlanNegocio").click(function () {
       location.href="${createLink(controller: 'plan', action: 'planesConvenio')}/" + '${plns?.id}'
    });

    $("#btnAdministradorCon").click(function () {
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'administradorConvenio', action: 'administrador_ajax')}',
            data:{
                id: '${plns?.id}'
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
                "¿Está seguro que desea eliminar el plns? Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller:'plns', action:'delete_ajax')}',
                            data    : {
                                id : '${plns?.id}'
                            },
                            success : function (msg) {
                                dialog.modal('hide');
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "SUCCESS") {
                                    setTimeout(function () {
                                        location.href="${createLink(controller: 'plns', action: 'plns')}"
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
        submitFormPlanes();
    });

    function submitFormPlanes() {
        var $form = $("#frmPlan");
        // var data = $form.serialize();
        console.log('save....', $form.valid());
        if ($form.valid()) {
            console.log('save.... ok');
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
/*
                        setTimeout(function () {
                            location.href="${createLink(controller: 'planesNegocio', action: 'planes')}/" + parts[2]
                        }, 800);
*/
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
            return false;
        } else {
            return false;
        } //else
        return false;
    }

    $("#btnBuscarConvenio").click(function () {
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'plns', action: 'buscarConvenio_ajax')}',
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