<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/09/20
  Time: 16:16
--%>

<%@ page import="parametros.proyectos.GrupoProcesos" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Evaluaciones</title>
</head>

<div class="panel panel-primary col-md-12">
    <h3>Evaluaciones del Plan de negocios</h3>
    <div class="panel-info" style="padding: 3px; margin-top: 2px">
        <div class="btn-toolbar toolbar">

            <div class="btn-group">
                <g:link controller="planesNegocio" action="planes" id="${plan?.unidadEjecutora?.id}" class="btn btn-sm btn-default">
                    <i class="fa fa-arrow-left"></i> Regresar a plan de negocio
                </g:link>
                <a href="#" class="btn btn-sm btn-success" id="btnAgregarEvaluacion">
                    <i class="fa fa-plus"></i> Agregar nueva evaluación
                </a>
            </div>

            <div class="btn-group col-md-3 pull-right">
                <div class="input-group input-group-sm">
                    <input type="text" class="form-control input-sm " id="searchDoc" placeholder="Buscar"/>
                    <span class="input-group-btn">
                        <a href="#" class="btn btn-default" id="btnSearchDoc"><i class="fa fa-search"></i></a>
                    </span>
                </div><!-- /input-group -->
            </div>
        </div>
    </div>
    <div id="tabla"></div>
</div>

<script type="text/javascript">
    var bm;

    cargarTablaEvaluaciones();

    function cargarTablaEvaluaciones(search) {
        var data = {
            id : "${plan.id}"
        };
        if (search) {
            data.search = search;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'planesNegocio', action:'tablaEvaluaciones_ajax')}",
            data    : data,
            success : function (msg) {
                $("#tabla").html(msg);
            }
        });
    }

    $("#btnAgregarEvaluacion").click(function () {
        createEditEvaluacion();
    });

    function borrarEvaluacion(id) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea eliminar la evaluación seleccionada? Esta acción no se puede deshacer.</p>",
            buttons : {
                cancelar : {
                    label     : "Cancelar",
                    className : "btn-primary",
                    callback  : function () {
                    }
                },
                eliminar : {
                    label     : "<i class='fa fa-trash'></i> Eliminar",
                    className : "btn-danger",
                    callback  : function () {
                        var dialog = cargarLoader("Borrando...");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'evaluacion', action:'borrarEvaluacion_ajax')}',
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                dialog.modal('hide');
                                var parts = msg.split("_");
                                if(parts[0] == 'ok'){
                                    log("Evaluación borrada correctamente","success")
                                    cargarTablaEvaluaciones();
                                }else{
                                    if(parts[0] == 'er'){
                                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "La evaluación ya posee detalles, no puede ser borrada!" + '</strong>');
                                        return false;
                                    }else{
                                        log("Error al borrar la evaluación","error")
                                    }
                                }

                            }
                        });
                    }
                }
            }
        });
    }
    function submitFormEvaluacion() {
        var $form = $("#frmEvaluacion");
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
                    // var parts = msg.split("_");
                    if(msg == 'ok'){
                        log("Evaluación creada correctamente", "success");
                        cargarTablaEvaluaciones();
                        %{--setTimeout(function () {--}%
                        %{--    location.href="${createLink(controller: 'unidadEjecutora', action: 'organizacion')}/" + parts[2]--}%
                        %{--}, 1000);--}%
                    }else{
                        log("Error al crear la evaluación", "success");
                    }
                }
            });
        } else {
            return false;
        } //else
        return false;
    }

    function createEditEvaluacion(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'evaluacion', action:'formEvaluacion_ajax')}",
            data    : {
                id: id ? id : '',
                plan: '${plan?.id}'
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEditEvaluacion",
                    title   : title + " evaluación del plan",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                submitFormEvaluacion();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

</script>
</html>