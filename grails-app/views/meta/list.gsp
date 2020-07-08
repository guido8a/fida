<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/07/20
  Time: 11:49
--%>

<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <title>Lista de Metas</title>
</head>

<body>

<elm:message tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:message>

<!-- botones -->
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <div class="btn-group">
            <g:link controller="proyecto" action="proy" id="${proyecto?.id}" class="btn btn-sm btn-default">
                <i class="fa fa-arrow-left"></i> Regresar a proyectos
            </g:link>
        </div>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-info btnCrearMeta">
            <i class="fa fa-file"></i> Nueva Meta
        </a>
    </div>
</div>

<table class="table table-condensed table-bordered table-striped table-hover">
    <thead>
    <tr>
        <th>Parroquia</th>
        <th>Actividad (Marco lógico)</th>
        <th>Unidad</th>
        <th>Indicador ORMS</th>
        <th>Descripción</th>
        <th>Valor</th>
    </tr>
    </thead>
    <tbody>
    <g:if test="${metas?.size() > 0}">
        <g:each in="${metas}" status="i" var="meta">
            <tr data-id="${meta.id}">
                <td>${meta?.parroquia?.nombre}</td>
                <td>${meta?.marcoLogico?.objeto}</td>
                <td>${meta?.unidad?.descripcion}</td>
                <td>${meta?.indicadorOrms?.descripcion}</td>
                <td>${meta?.descripcion}</td>
                <td>${meta?.valor}</td>
            </tr>
        </g:each>
    </g:if>
    <g:else>
        <tr class="danger">
            <td class="text-center" colspan="15">
                    No se encontraron registros que mostrar
            </td>
        </tr>
    </g:else>
    </tbody>
</table>

%{--<elm:pagination total="${marcoLogicoInstanceCount}" params="${params}"/>--}%

<script type="text/javascript">


    $(".btnCrearMeta").click(function () {
        createEditMeta()
    });

    var id = null;
    function submitFormMeta() {
        var $form = $("#frmMeta");
        var $btn = $("#dlgCreateEditMeta").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            $.ajax({
                type    : "POST",
                url     : $form.attr("action"),
                data    : $form.serialize(),
                success : function (msg) {
                    var parts = msg.split("_");
                    if (parts[0] == "ok") {
                        log(parts[1], "success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 1000);
                    }else{
                        log(parts[1], "error");
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
            message : "<i class='fa fa-trash-o fa-3x pull-left text-danger text-shadow'></i><p>" +
                "¿Está seguro que desea eliminar la meta seleccionada? Esta acción no se puede deshacer.</p>",
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
                        %{--openLoader("Eliminando MarcoLogico");--}%
                        %{--$.ajax({--}%
                        %{--    type    : "POST",--}%
                        %{--    url     : '${createLink(controller:'marcoLogico', action:'delete_ajax')}',--}%
                        %{--    data    : {--}%
                        %{--        id : itemId--}%
                        %{--    },--}%
                        %{--    success : function (msg) {--}%
                        %{--        var parts = msg.split("*");--}%
                        %{--        log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)--}%
                        %{--        if (parts[0] == "SUCCESS") {--}%
                        %{--            setTimeout(function () {--}%
                        %{--                location.reload(true);--}%
                        %{--            }, 1000);--}%
                        %{--        } else {--}%
                        %{--            closeLoader();--}%
                        %{--        }--}%
                        %{--    }--}%
                        %{--});--}%
                    }
                }
            }
        });
    }
    function createEditMeta(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        data += "&proyecto=" + '${proyecto?.id}';
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'meta', action:'form_ajax')}",
            // data    : data,
            data    : {
                id: id,
                proyecto : '${proyecto?.id}'
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgCreateEditMeta",
                    title : title + " Meta",
                    class : "modal-lg",
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
                                return submitFormMeta();
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

        $("tbody>tr").contextMenu({
            items  : {
                header   : {
                    label  : "Acciones",
                    header : true
                },
                ver      : {
                    label  : "Ver",
                    icon   : "fa fa-search",
                    action : function ($element) {
                        var id = $element.data("id");
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(controller:'meta', action:'show_ajax')}",
                            data    : {
                                id : id
                            },
                            success : function (msg) {
                                bootbox.dialog({
                                    title   : "Ver MarcoLogico",
                                    message : msg,
                                    buttons : {
                                        ok : {
                                            label     : "Aceptar",
                                            className : "btn-primary",
                                            callback  : function () {
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                },
                editar   : {
                    label  : "Editar",
                    icon   : "fa fa-edit",
                    action : function ($element) {
                        var id = $element.data("id");
                        createEditMeta(id);
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
                $element.addClass("success");
            },
            onHide : function ($element) {
                $(".success").removeClass("success");
            }
        });
    });
</script>

</body>
</html>
