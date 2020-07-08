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
%{--    <g:if test="${marcoLogicoInstanceCount > 0}">--}%
%{--        <g:each in="${marcoLogicoInstanceList}" status="i" var="marcoLogicoInstance">--}%
%{--            <tr data-id="${marcoLogicoInstance.id}">--}%

%{--                <td>${marcoLogicoInstance.proyecto}</td>--}%

%{--                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${marcoLogicoInstance}" field="tipoElemento"/></elm:textoBusqueda></td>--}%

%{--                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${marcoLogicoInstance}" field="marcoLogico"/></elm:textoBusqueda></td>--}%

%{--                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${marcoLogicoInstance}" field="modificacionProyecto"/></elm:textoBusqueda></td>--}%

%{--                <td><elm:textoBusqueda busca="${params.search}"><g:fieldValue bean="${marcoLogicoInstance}" field="objeto"/></elm:textoBusqueda></td>--}%

%{--                <td><g:fieldValue bean="${marcoLogicoInstance}" field="monto"/></td>--}%

%{--            </tr>--}%
%{--        </g:each>--}%
%{--    </g:if>--}%
%{--    <g:else>--}%
%{--        <tr class="danger">--}%
%{--            <td class="text-center" colspan="15">--}%
%{--                <g:if test="${params.search && params.search != ''}">--}%
%{--                    No se encontraron resultados para su búsqueda--}%
%{--                </g:if>--}%
%{--                <g:else>--}%
%{--                    No se encontraron registros que mostrar--}%
%{--                </g:else>--}%
%{--            </td>--}%
%{--        </tr>--}%
%{--    </g:else>--}%
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
                    var parts = msg.split("*");
                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    setTimeout(function () {
                        if (parts[0] == "SUCCESS") {
                            location.reload(true);
                        } else {
                            spinner.replaceWith($btn);
                            return false;
                        }
                    }, 1000);
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
                "¿Está seguro que desea eliminar el MarcoLogico seleccionado? Esta acción no se puede deshacer.</p>",
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
                        openLoader("Eliminando MarcoLogico");
                        $.ajax({
                            type    : "POST",
                            url     : '${createLink(controller:'marcoLogico', action:'delete_ajax')}',
                            data    : {
                                id : itemId
                            },
                            success : function (msg) {
                                var parts = msg.split("*");
                                log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                                if (parts[0] == "SUCCESS") {
                                    setTimeout(function () {
                                        location.reload(true);
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
    }
    function createEditMeta(id) {
        var title = id ? "Editar" : "Crear";
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'meta', action:'form_ajax')}",
            data    : data,
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

        $(".btnCrear").click(function () {
            createEditRow();
            return false;
        });

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
                            url     : "${createLink(controller:'marcoLogico', action:'show_ajax')}",
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
                    icon   : "fa fa-pencil",
                    action : function ($element) {
                        var id = $element.data("id");
                        createEditRow(id);
                    }
                },
                eliminar : {
                    label            : "Eliminar",
                    icon             : "fa fa-trash-o",
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
