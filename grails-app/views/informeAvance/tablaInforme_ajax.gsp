%{--<script src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script src="${resource(dir: 'js/plugins/fixed-header-table-1.3', file: 'jquery.fixedheadertable.js')}"></script>--}%
%{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/plugins/fixed-header-table-1.3/css', file: 'defaultTheme.css')}"/>--}%

<table id="tblDocumentos" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
        <tr>
            <th>Desembolso</th>
            <th>Informe</th>
            <th>Dificultades</th>
            <th>Porcentaje</th>
            <th>Fecha</th>
        </tr>
    </thead>
    <tbody id="tbDoc">
        <g:each in="${informe}" var="info">
            <tr data-id="${info.id}" style="width: 100%">
                <td style="width: 20%"><elm:textoBusqueda busca="${params.search}">
                    ${info?.desembolso?.descripcion}</elm:textoBusqueda></td>
                <td style="width: 60%"><elm:textoBusqueda busca="${params.search}">
                    ${info?.informeAvance}</elm:textoBusqueda></td>
                <td style="width: 60%"><elm:textoBusqueda busca="${params.search}">
                    ${info?.dificultadesAvance}</elm:textoBusqueda></td>
                <td style="width: 10%">${info?.porcentaje} %</td>
                <td style="width: 10%">${info.fecha?.format("dd-MM-yyyy")}</td>
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
                                url: "${createLink(controller:'informeAvance', action:'show_ajax')}",
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
                            createEditInforme(id);
                        }
                    },
                    avance: {
                        label: "Detalle del Avance",
                        icon: "fa fa-edit",
                        action: function ($element) {
                            var id = $element.data("id");
                            location.href="${createLink(controller: 'avance', action: 'detalle')}" + "/?id=" + id;                           detalleAvance(id);
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