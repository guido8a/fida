%{--<script src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script src="${resource(dir: 'js/plugins/fixed-header-table-1.3', file: 'jquery.fixedheadertable.js')}"></script>--}%
%{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/plugins/fixed-header-table-1.3/css', file: 'defaultTheme.css')}"/>--}%

<table id="tblDocumentos" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
        <tr>
            <th>Financiamiento</th>
            <th>Garantía</th>
            <th>Descripción</th>
            <th>CUR</th>
            <th>Fecha</th>
            <th>Valor</th>
        </tr>
    </thead>
    <tbody id="tbDoc">
        <g:each in="${desembolso}" var="dsmb">
            <tr data-id="${dsmb.id}" style="width: 100%">
                <td style="width: 10%"><elm:textoBusqueda busca="${params.search}">
                    ${dsmb?.financiamientoPlanNegocio?.fuente?.descripcion}</elm:textoBusqueda></td>
                <td style="width: 17%"><elm:textoBusqueda busca="${params.search}">${dsmb?.garantia?.codigo}</elm:textoBusqueda></td>
                <td style="width: 23%">${dsmb?.descripcion}</td>
                <td style="width: 7%">${dsmb?.cur}</td>
                <td style="width: 7%">${dsmb.fecha?.format("dd-MM-yyyy")}</td>
                <td style="width: 8%">${dsmb.valor}</td>
            </tr>
        </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(function () {
        // setTimeout(function () {
        //     $("#tblDocumentos").fixedHeaderTable({
        //         height : 250
        //     });
        // }, 500);

            $("tbody>tr").contextMenu({
                items: {
                    header: {
                        label: "Acciones",
                        header: true
                    },
                    ver: {
                        label: "Ver",
                        icon: "fa fa-search",
                        action: function ($element) {
                            var id = $element.data("id");
                            $.ajax({
                                type: "POST",
                                url: "${createLink(controller:'desembolso', action:'show_ajax')}",
                                data: {
                                    id: id
                                },
                                success: function (msg) {
                                    bootbox.dialog({
                                        title: "Ver Desembolso",
                                        message: msg,
                                        buttons: {
                                            ok: {
                                                label: "Aceptar",
                                                className: "btn-primary",
                                                callback: function () {
                                                }
                                            }
                                        }
                                    });
                                }
                            });
                        }
                    },
                    editar: {
                        label: "Editar",
                        icon: "fa fa-edit",
                        action: function ($element) {
                            var id = $element.data("id");
                            createEditDesembolso(id);
                        }
                    },
                    eliminar: {
                        label: "Eliminar",
                        icon: "fa fa-trash",
                        separator_before: true,
                        action: function ($element) {
                            var id = $element.data("id");
                            deleteTaller(id);
                        }
                    }
                },
                onShow: function ($element) {
                    $element.addClass("success");
                },
                onHide: function ($element) {
                    $(".success").removeClass("success");
                }
            });

            function cargarInstituciones(id){
                $.ajax({
                    type: "POST",
                    url: "${createLink(controller: 'desembolso',action:'instituciones_ajax')}",
                    data: {
                        id:id
                    },
                    success: function (msg) {
                        var b = bootbox.dialog({
                            id: "dlgInstituciones",
                            title: "Instituciones participantes",
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
            }

    });
</script>