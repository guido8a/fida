<%@ page import="parametros.proyectos.GrupoProcesos" %>
<html>
<head>
<meta name="layout" content="main">
<title>Convenios</title>
</head>

<div class="panel panel-primary col-md-12">
    <h3>Convenios</h3>
    <div class="panel-info" style="padding: 3px; margin-top: 2px">
    <div class="btn-toolbar toolbar">

    <div class="btn-group">
        <a href="#" class="btn btn-sm btn-success" id="btnAddCnvn">
            <i class="fa fa-plus"></i> Agregar nuevo Convenio
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
    var bm

    function reloadTablaConvenio(search) {
        var data = {
            id : "${proyecto.id}"
        };
        if (search) {
            data.search = search;
        }
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'convenio', action:'tablaConvenio_ajax')}",
            data    : data,
            success : function (msg) {
                $("#tabla").html(msg);
            }
        });
    }

    function submitFormConvenio() {
        var $form = $("#frmConvenio");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        // $form.validate();
        // console.log('submit');
        if ($form.valid()) {
            // console.log('submit--')
            $btn.replaceWith(spinner);
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
                        reloadTablaConvenio();
                        bm.modal("hide");
                    } else {
                        if(parts[0] == 'er'){
                            bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> " + parts[1])
                            // return false;
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
        return false;
    }
    function deleteConvenio(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-3x pull-left text-danger text-shadow'></i><p>" +
                    "¿Está seguro que desea eliminar el Convenio seleccionado? Esta acción no se puede deshacer.</p>",
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
                        openLoader("Eliminando Convenio");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'convenio', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                closeLoader();
                                if (parts[0] == "SUCCESS") {
                                    reloadTablaConvenio();
                                }
                            }
                        });
                    }
                }
            }
        });
    }

    function createEditConvenio(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'convenio', action:'formConvenio_ajax')}",
            data    : data,
            success : function (msg) {
                bm = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " Convenio",
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
                                return submitFormConvenio();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    bm.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //createEdit

    reloadTablaConvenio();

    $("#btnSearchDoc").click(function () {
        reloadTablaConvenio($.trim($("#searchDoc").val()));
    });
    $("#searchDoc").keyup(function (ev) {
        if (ev.keyCode == 13) {
            reloadTablaConvenio($.trim($("#searchDoc").val()));
        }
    });
    $("#btnAddCnvn").click(function () {
        createEditConvenio();
    });


</script>
</html>