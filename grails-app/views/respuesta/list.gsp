
<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Indicador ORMS</title>
</head>
<body>

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<!-- botones -->
<div class="btn-toolbar toolbar" style="margin-bottom: 15px">
    <div class="btn-group">
        <g:link controller="pregunta" action="pregunta" class="btn btn-default">
            <i class="fa fa-arrow-left"></i> Regresar
        </g:link>
    </div>
    <div class="btn-group">
        <g:link action="form" class="btn btn-success btnCrear">
            <i class="fa fa-clipboard-list"></i> Nueva Opción de respuesta
        </g:link>
    </div>
</div>

<div style="text-align: center">
    <table class="table table-condensed table-bordered table-striped" style="width: 80%">
        <thead>
        <tr style="width: 100%">
            <th style="width: 20%">Tipo</th>
            <th style="width: 90%">Opción de respuesta</th>
        </tr>
        </thead>
        <tbody>
        <g:each in="${respuesta}" status="i" var="dataInstance">
            <tr data-id="${dataInstance.id}">
                <td>${dataInstance?.tipo == 'M' ? 'Opción Múltiple' : (dataInstance?.tipo == 'N' ? 'Numérico' : 'Texto')}</td>
                <td>${fieldValue(bean: dataInstance, field: "opcion")}</td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>


<elm:pagination total="${respuestaInstanceCount}" params="${params}"/>

<script type="text/javascript">
    var id = null;
    function submitForm() {
        var $form = $("#frmRespuesta");
        var $btn = $("#dlgCreateEdit").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'respuesta', action:'save_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                    if (parts[0] == "OK") {
                        location.reload(true);
                    } else {
                        spinner.replaceWith($btn);
                        return false;
                    }
                }
            });
        } else {
            return false;
        } //else
    }
    function deleteRow(itemId) {
        bootbox.dialog({
            title   : "Alerta",
            message : "<i class='fa fa-trash fa-2x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea eliminar el Indicador ORMS? Esta acción no se puede deshacer.</p>",
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
                            url     : '${createLink(action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("_");
                                log(parts[1], parts[0] == "OK" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "OK") {
                                    location.reload(true);
                                }
                            }
                        });
                    }
                }
            }
        });
    }
    function createEditRow(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? { id: id } : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'respuesta', action:'form_ajax')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreateEdit",
                    title   : title + " opción de respuesta",
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
                                return submitForm();
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

    $(function () {

        $(".btnCrear").click(function() {
            createEditRow();
            return false;
        });

        $("tbody tr").contextMenu({
            items  : {
                header   : {
                    label  : "Acciones",
                    header : true
                },
                editar   : {
                    label  : "Editar",
                    icon   : "fa fa-pen",
                    action : function ($element) {
                        var id = $element.data("id");
                        createEditRow(id);
                    }
                },
                eliminar : {
                    label            : "Eliminar",
                    icon             : "fa fa-trash",
                    separator_before : true,
                    action           : function ($element) {
                        var id = $element.data("id");
                        deleteRow(id);
                    }
                }
            },
            onShow : function ($element) {
                $element.addClass("trHighlight");
            },
            onHide : function ($element) {
                $(".trHighlight").removeClass("trHighlight");
            }
        });

    });
</script>

</body>
</html>
