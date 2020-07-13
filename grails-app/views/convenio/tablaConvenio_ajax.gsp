%{--<script src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script src="${resource(dir: 'js/plugins/fixed-header-table-1.3', file: 'jquery.fixedheadertable.js')}"></script>--}%
%{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/plugins/fixed-header-table-1.3/css', file: 'defaultTheme.css')}"/>--}%

<table id="tblDocumentos" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
        <tr>
            <th>Número</th>
            <th>Convenio</th>
            <th>Organización</th>
            <th>Objetivo</th>
            <th>Inicio</th>
            <th>Fin</th>
            <th>Plazo</th>
            <th>Informa</th>
        </tr>
    </thead>
    <tbody id="tbDoc">
        <g:each in="${convenio}" var="dt">
            <tr data-id="${dt.id}" style="width: 100%">
                <td style="width: 6%">${dt.codigo}</td>
                <td style="width: 20%"><elm:textoBusqueda busca="${params.search}">${dt.nombre}</elm:textoBusqueda></td>
                <td style="width: 14%"><elm:textoBusqueda busca="${params.search}">${dt.unidadEjecutora}</elm:textoBusqueda></td>
                <td style="width: 30%"><elm:textoBusqueda busca="${params.search}">${dt.objetivo}</elm:textoBusqueda></td>
                <td style="width: 7%">${dt.fechaInicio?.format("dd-MM-yyyy")}</td>
                <td style="width: 7%">${dt.fechaFin?.format("dd-MM-yyyy")}</td>
                <td style="width: 7%">${dt.plazo}</td>
                <td style="width: 7%">${dt.periodo}</td>
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

        $(".btnDelDoc").click(function () {
            deleteDocumento($(this).data("id"));
        });
        $(".btnDownDoc").click(function () {
            downloadDocumento($(this).data("id"));
        });
        $(".btnEditDoc").click(function () {
            createEditDocumento($(this).data("id"));
        });

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
                                url: "${createLink(controller:'convenio', action:'show_ajax')}",
                                data: {
                                    id: id
                                },
                                success: function (msg) {
                                    bootbox.dialog({
                                        title: "Ver Taller",
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
                            createEditConvenio(id);
                        }
                    },
                    administrador: {
                        label: "Administrador",
                        icon: "fas fa-user",
                        action: function ($element) {
                            var id = $element.data("id");
                            var url = "${createLink(controller:'personaTaller', action:'listPrtl')}";
                            location.href = url + "/" + id;
                        }
                    },
                    indicadores: {
                        label: "Indicadores",
                        icon: "fas fa-user",
                        action: function ($element) {
                            var id = $element.data("id");
                            var url = "${createLink(controller:'personaTaller', action:'listPrtl')}";
                            location.href = url + "/" + id;
                        }
                    },
                    Biblioteca: {
                        label: "Bliblioteca",
                        icon: "fas fa-user",
                        action: function ($element) {
                            var id = $element.data("id");
                            var url = "${createLink(controller:'personaTaller', action:'listPrtl')}";
                            location.href = url + "/" + id;
                        }
                    },
                    Plan: {
                        label: "Plan de Negocios Solidario",
                        icon: "fas fa-user",
                        action: function ($element) {
                            var id = $element.data("id");
                            var url = "${createLink(controller:'personaTaller', action:'listPrtl')}";
                            location.href = url + "/" + id;
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



    });
</script>