<%@ page import="parametros.proyectos.GrupoProcesos" %>
<html>
<head>
<meta name="layout" content="main">
<title>Asistentes (Antigua lista)</title>
</head>

<div class="panel panel-primary col-md-12">
    <h3>Asistentes al Taller "${taller.nombre}" (Antigua lista)</h3>
    <div class="panel-info" style="padding: 3px; margin-top: 2px">
    <div class="btn-toolbar toolbar">

        <div class="btn-group">
            <g:link controller="taller" action="listTaller" id="${unidad?.id}" class="btn btn-sm btn-default">
                <i class="fa fa-arrow-left"></i> Regresar a taller
            </g:link>
        </div>

    <div class="btn-group">
        <a href="#" class="btn btn-sm btn-success" id="btnPrtl">
            <i class="fa fa-plus"></i> Agregar Asistente
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

    var bpt

    function reloadTablaTaller(search) {
        var data = {
            id : "${taller.id}"
        };
        if (search) {
            data.search = search;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'personaTaller', action:'tablaPrtl_ajax')}",
            data    : data,
            success : function (msg) {
                $("#tabla").html(msg);
            }
        });
    }

    function submitFormTaller() {
        var $form = $("#frmPersonaTaller");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        // $form.validate();
        // console.log('submit');
        if ($form.valid()) {
            // console.log('submit--')
            $btn.replaceWith(spinner);
            var dialog = cargarLoader("Guardando...");
            var formData = new FormData($form[0]);
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
                        reloadTablaTaller();
                        bpt.modal("hide");
                    } else {
                        if(parts[0] == 'er'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> " + parts[1])
                        }else{
                            spinner.replaceWith($btn);
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
    }
    function boorarPersonaTaller(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                    "¿Está seguro que desea eliminar la persona del taller seleccionado? Esta acción no se puede deshacer.</p>",
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
                        openLoader("Eliminando Taller");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'personaTaller', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                closeLoader();
                                if (parts[0] == "SUCCESS") {
                                    reloadTablaTaller();
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function createEditPersonaTaller(id) {
        var title = id ? "Editar" : "Nueva";
        %{--var data = id ? {id : id} : {};--}%
        %{--data += '&taller=' + '${taller?.id}';--}%
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'personaTaller', action:'formPersonaTaller_ajax')}",
            data    : {
                id: id,
                taller: '${taller?.id}'
            },
            success : function (msg) {
                bpt = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Asistentes al Taller",
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
                                return submitFormTaller();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    bpt.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit
    function downloadTaller(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'documento', action:'existeDoc_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                if (msg == "OK") {
                    location.href = "${createLink(controller: 'documento', action: 'downloadDoc')}/" + id;
                } else {
                    log("El documento solicitado no se encontró en el servidor", "error"); // log(msg, type, title, hide)
                }
            }
        });
    }

    reloadTablaTaller();

    $("#btnSearchDoc").click(function () {
        reloadTablaTaller($.trim($("#searchDoc").val()));
    });
    $("#searchDoc").keyup(function (ev) {
        if (ev.keyCode == 13) {
            reloadTablaTaller($.trim($("#searchDoc").val()));
        }
    });
    $("#btnPrtl").click(function () {
        createEditPersonaTaller();
    });


</script>
</html>