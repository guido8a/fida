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

<div class="btn-group">
    <a href="#" class="btn btn-sm btn-default btnRegresar">
        <i class="fa fa-arrow-left"></i> Regresar a organización
    </a>
</div>


<h3 style="text-align: center">Plan de Negocio Solidario</h3>
<div class="panel panel-primary col-md-12">
    <div class="panel-heading" style="padding: 3px; margin-top: 2px; text-align: ${plns?.id ? 'center' : 'left'}">
        <g:if test="${plns?.id}">
            <a href="#" id="btnDocumentos" class="btn btn-sm btn-info" title="Consultar documentos">
                <i class="fas fa-book-reader"></i> Biblioteca de la Organización
            </a>
            <a href="#" id="btnFinanciamiento" class="btn btn-sm btn-info" title="Evaluaciones del plan">
                <i class="far fa-money-bill-alt"></i> Financiamiento
            </a>
            <a href="#" id="btnPlanificacion" class="btn btn-sm btn-info" title="Evaluaciones del plan">
                <i class="fa fa-list-ol"></i> Planificación (cronograma)
            </a>
            <a href="#" id="btnIndicadores" class="btn btn-sm btn-info" title="Indicadores del plan">
                <i class="fa fa-italic"></i> Indicadores del PNS
            </a>
            <a href="#" id="btnEvaluaciones" class="btn btn-sm btn-info" title="Evaluaciones del plan">
                <i class="fa fa-pen-square"></i> Evaluaciones
            </a>
            <a href="#" id="btnConvenio" class="btn btn-sm btn-warning" title="Evaluaciones del plan">
                <i class="fa fa-handshake"></i> Convenio
            </a>
        </g:if>
        <g:if test="${plns?.estado == 'N'}">
            <g:if test="${plns?.id}">
                <a href="#" id="btnGuardar" class="btn btn-sm btn-success" title="Guardar información">
                    <i class="fa fa-save"></i> Guardar
                </a>
                <a href="#" id="btnEliminar" class="btn btn-sm btn-danger" title="Guardar información">
                    <i class="fa fa-trash"></i> Eliminar
                </a>
                <a href="#" id="btnRegistrarPlan" class="btn btn-sm btn-warning" title="Registrar el plan">
                    <i class="fa fa-check"></i> Registrar
                </a>
            </g:if>
        </g:if>
        <g:else>
            <a href="#" id="btnRegistrarPlan" class="btn btn-sm btn-warning" title="Quitar registro del plan">
                <i class="fa fa-times-circle"></i> Desregistrar
            </a>
        </g:else>
    </div>
    <div class="tab-content">
        <div id="home" class="tab-pane fade in active">
            <g:form class="form-horizontal" name="frmPlan" controller="planesNegocio" action="savePlan_ajax" method="POST">
                <g:hiddenField name="id" value="${plns?.id}"/>
                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Organización</span>
                        <div class="col-md-10">
                            <span class="grupo">
                                <g:hiddenField name="unidadEjecutora" value="${unidad?.id}"/>
                                <g:select id="unidadEjecutoraNombre" name="unidadEjecutora_name"
                                          from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2))}"
                                          optionKey="id" value="${plns?.unidadEjecutora?.id}"
                                          class="many-to-one form-control input-sm" disabled=""/>
                            </span>
                        </div>
                    </div>
                </div>
                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="grupo">
                            <span class="col-md-2 label label-primary text-info mediano">Provincia</span>
                            <div class="col-md-2">
                                <g:hiddenField name="provincia" value="${unidad?.parroquia?.canton?.provincia?.id}"/>
                                <input name="provinciaName" id="provinciaTexto" type='text' class="form-control"
                                       readonly="" value="${unidad.parroquia?.canton?.provincia?.nombre}"/>
                            </div>
                        </span>
                        <span class="grupo">
                            <label class="col-md-1 control-label text-info">
                                Cantón
                            </label>
                            <div class="col-md-2">
                                <input name="canton" id="cantonTexto" type='text' class="form-control" readonly=""
                                       value="${unidad?.parroquia?.canton?.nombre}"/>
                            </div>
                        </span>
                        <span class="grupo">
                            <label class="col-md-1 control-label text-info">
                                Parroquia
                            </label>
                            <div class="col-md-4">
                                <g:hiddenField name="parroquia" value="${unidad?.parroquia?.id}"/>
                                <input name="parroquiaName" id="parroquiaTexto" type='text' class="form-control"
                                       required="" readonly="" value="${unidad?.parroquia?.nombre}"/>
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
                                    <g:textField name="nombre" maxlength="255" class="form-control input-sm required"
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
                                <input name="fechaPresentacion" id="fp" type='text' class="form-control"
                                       value="${plns?.fechaPresentacion?.format("dd-MM-yyyy")}"/>
                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Comité</span>
                        <span class="grupo">
                            <div class="col-md-2">
                                <input name="fechaComite" id="fc" type='text' class="form-control"
                                       value="${plns?.fechaComite?.format("dd-MM-yyyy")}"/>
                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Aprobación</span>
                        <span class="grupo">
                            <div class="col-md-2">
                                <input name="fechaAprobacion" id="fa" type='text' class="form-control"
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
                            <g:textField name="monto" class="form-control input-sm required number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.monto, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                        </div>
                        <span class="col-md-2 label label-primary text-info mediano">Calificación</span>
                        <div class="col-md-1">
                            <input name="calificacion" type='text' class="form-control number"
                                   value="${plns?.calificacion}" maxlength="2"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>
                        <span class="col-md-1"></span>
                        <span class="col-md-2 label label-primary text-info mediano">Inversión por Socio</span>
                        <div class="col-md-2">
                            <g:textField name="numeroSocios" class="form-control input-sm number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.numeroSocios, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                    </div>
                </div>
                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Ventas proyectadas</span>
                        <div class="col-md-2">
                            <g:textField name="venta" class="form-control input-sm required number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.venta, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                        </div>
                        <span class="col-md-2 label label-primary text-info mediano">Costos proyectados</span>
                        <div class="col-md-2">
                            <g:textField name="costo" class="form-control input-sm number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.costo, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>
                        <span class="col-md-2 label label-primary text-info mediano">Excedente</span>
                        <div class="col-md-2">
                            <g:textField name="excedente" class="form-control input-sm number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.excedente, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>
                    </div>
                </div>
                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Valos Actual Neto</span>
                        <div class="col-md-2">
                            <g:textField name="van" class="form-control input-sm required number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.van, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                        </div>
                        <span class="col-md-2 label label-primary text-info mediano">Tasa Interna de Retorno</span>
                        <div class="col-md-2">
                            <g:textField name="tir" class="form-control input-sm number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.tir, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Tasa</span>
                        <div class="col-md-2">
                            <g:textField name="tasa" class="form-control input-sm number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.tasa, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>
                    </div>
                </div>
                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Capital de Trabajo</span>
                        <div class="col-md-2">
                            <g:textField name="capitalTrabajo" class="form-control input-sm required number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.capitalTrabajo, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                        </div>
                        <span class="col-md-2 label label-primary text-info mediano">Inversiones preoperativas y legales</span>
                        <div class="col-md-2">
                            <g:textField name="inversiones" class="form-control input-sm number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.inversiones, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Terrenos y Construcciones</span>
                        <div class="col-md-2">
                            <g:textField name="terreno" class="form-control input-sm number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.terreno, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>
                    </div>
                </div>
                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Maquinaria y Equipo</span>
                        <div class="col-md-2">
                            <g:textField name="maquinaria" class="form-control input-sm number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.maquinaria, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Muebles y equipos de oficina</span>
                        <div class="col-md-2">
                            <g:textField name="muebles" class="form-control input-sm number" maxlength="14"
                                         value="${util.formatNumber(number: plns?.muebles, maxFractionDigits: 2, minFractionDigits: 2)}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>

                        <span class="col-md-2 label label-primary text-info mediano">Plazo de ejecución (días)</span>
                        <div class="col-md-1">
                            <g:textField name="plazo" class="form-control input-sm number text-info" maxlength="14"
                                         value="${plns?.plazo}"/>
                            <p class="help-block ui-helper-hidden"></p>
                        </div>
                        <span>Días</span>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>

<script type="text/javascript">

    $("#btnRegistrarPlan").click(function () {
        var dialog = cargarLoader("Guardando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'planesNegocio', action: 'registrarPlan_ajax')}',
            data:{
                id: '${plns?.id}'
            },
            success: function (msg){
                dialog.modal('hide');
                if(msg == 'ok'){
                    log("Cambio de estado correcto","success");
                    setTimeout(function () {
                        location.href="${createLink(controller: 'planesNegocio', action: 'planes')}/" + '${unidad?.id}'
                    }, 1000);
                }else{
                    log("Error al registrar el plan","error")
                }
            }
        });
    });

    $("#btnFinanciamiento").click(function () {
        var id = '${plns?.id}';
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'planesNegocio', action:'financiamiento_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Presupuesto/Fuentes",
                    class   : "modal-lg",
                    message : msg,
                    buttons : {
                        ok : {
                            label     : "Salir",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        });
    });

    $("#btnIndicadores").click(function () {
            $.ajax({
                type: "POST",
                url: "${createLink(controller: 'planesNegocio',action:'formIndicadores_ajax')}",
                data: {
                    id: '${plns?.id}'
                },
                success: function (msg) {
                    var b = bootbox.dialog({
                        id: "dlgIndicadores",
                        title: "Indicadores del plan",
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

    $(".btnRegresar").click(function () {
        location.href="${createLink(controller: 'unidadEjecutora', action: 'organizacion')}/" + '${unidad?.id}'
    });

    $("#btnDocumentos").click(function () {
        location.href="${createLink(controller: 'documento', action: 'listConvenio')}?id=" +
            '${plns?.unidadEjecutora?.id}' + "&plns=" + '${plns?.id}'
    });

    $("#btnEvaluaciones").click(function () {
        location.href="${createLink(controller: 'planesNegocio', action: 'evaluaciones')}/" + '${plns?.id}'

    });

    $("#btnPlanificacion").click(function () {
        location.href="${createLink(controller: 'plan', action: 'planesConvenio')}/" + '${plns?.id}'

    });

    $("#btnConvenio").click(function () {
        location.href="${createLink(controller: 'convenio', action: 'convenio')}/" + '${plns?.id}'

    });


    $("#btnEliminar").click(function () {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea eliminar el plan de negocio? Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(controller:'planesNegocio', action:'deletePlan_ajax')}',
                            data    : {
                                id : '${plns?.id}'
                            },
                            success : function (msg) {
                                dialog.modal('hide');
                                if (msg == "ok") {
                                    log("Plan borrado correctamente","success")
                                    setTimeout(function () {
                                        location.href="${createLink(controller: 'planesNegocio', action: 'planes')}/" + '${unidad?.id}'
                                    }, 1000);
                                } else {
                                    log("Error al borrar el plan","error")
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
                        log("Plan de negocios guardado correctamente", "success");
                        setTimeout(function () {
                            location.href="${createLink(controller: 'planesNegocio', action: 'planes')}/" + '${unidad?.id}'
                        }, 1000);
                    }else{
                        if(msg = 'er'){
                            bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i></br> '
                                + '<strong style="font-size: 14px">'
                                + "La suma de los valores:" + '</br>' + " * Capital de trabajo" + '</br>'
                                + " * Inversiones preoperativas y legales" + '</br>' + " * Terrenos y Construcciones" + '</br>'
                                + " * Maquinarias y Equipo" + '</br>' + " * Muebles y equipos de oficina" + '</br>'
                                + "es mayor al monto total del Plan" + '</strong>');
                        }else{
                            log("Error al guardar el plan de negocios","error")
                        }
                    }
                }
            });
        } else {
            return false;
        } //else
        return false;
    }

    $('#fc').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true
    });

    $('#fp').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true
    });

    $('#fa').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true,
    });



</script>
</body>
</html>