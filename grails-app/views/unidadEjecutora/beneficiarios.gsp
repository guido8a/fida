<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 07/09/20
  Time: 16:04
--%>

<%@ page import="parametros.proyectos.GrupoProcesos" %>
<html>
<head>
    <meta name="layout" content="main">
    <title>Beneficiarios</title>
</head>

<div class="panel panel-primary col-md-12">
    <h3>Beneficiarios</h3>
    <div class="panel-info" style="padding: 3px; margin-top: 2px">
        <div class="btn-toolbar toolbar">

            <div class="btn-group">
                <g:link controller="unidadEjecutora" action="organizacion" id="${unidad?.id}" class="btn btn-sm btn-default">
                    <i class="fa fa-arrow-left"></i> Regresar a organización
                </g:link>
                <a href="#" class="btn btn-sm btn-success" id="btnAgregarBeneficiario">
                    <i class="fa fa-plus"></i> Agregar nuevo beneficiario
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
    <div id="tablaBeneficiarios">

    </div>
</div>



<script type="text/javascript">

    $("#btnAgregarBeneficiario").click(function () {
        createEditBeneficiario();
    });


    var bm;

    cargarTablaBeneficiarios();

    function cargarTablaBeneficiarios(search) {
        var data = {
            id : "${unidad.id}"
        };
        if (search) {
            data.search = search;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'unidadEjecutora', action:'tablaBeneficiarios_ajax')}",
            data    : data,
            success : function (msg) {
                $("#tablaBeneficiarios").html(msg);
            }
        });
    }

    function submitFormBeneficiario(){
        var $form = $("#frmBeneficiario");
        var $btn = $("#dlgCreateEditB").find("#btnSave");
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
                        log("Beneficiario creado correctamente", "success");
                            cargarTablaBeneficiarios();
                            bm.modal("hide")
                    }else{
                        log("Error al crear el beneficiario","error")
                    }
                }
            });
        } else {
            return false;
        } //else
        return false;
    }


    function borrarBeneficiario(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea eliminar el beneficiario seleccionado? Esta acción no se puede deshacer.</p>",
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
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'personaOrganizacion', action:'borrarBeneficiario_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                if (msg == "ok") {
                                    log("Beneficiario borrado correctamente","success");
                                    setTimeout(function () {
                                        cargarTablaBeneficiarios();
                                    }, 500);
                                }else{
                                    if(msg == "er"){
                                        bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "No se puede borrar el beneficiario, se encuentra asignado como Representante" + '</strong>');
                                        return false;
                                    }else{
                                        log("Error al borrar el beneficiario")
                                    }
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function createEditBeneficiario(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'personaOrganizacion', action:'form_ajax')}",
            data    : {
                id: id ? id : '',
                unidad: '${unidad?.id}'
            },
            success : function (msg) {
                bm = bootbox.dialog({
                    id      : "dlgCreateEditB",
                    title   : title + " Beneficiario",
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
                                return submitFormBeneficiario();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                // setTimeout(function () {
                //     bm.find(".form-control").first().focus()
                // }, 500);
            } //success
        }); //ajax
    } //createEdit


    var validator = $("#frmBeneficiario").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
            label.remove();
        }

    });



</script>
</html>