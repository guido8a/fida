%{--<script src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script src="${resource(dir: 'js/plugins/fixed-header-table-1.3', file: 'jquery.fixedheadertable.js')}"></script>--}%
%{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/plugins/fixed-header-table-1.3/css', file: 'defaultTheme.css')}"/>--}%

<table id="tblDocumentos" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
        <tr>
            <th>Cédula</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Cargo</th>
            <th>Sexo</th>
            <th>Parroquia</th>
            <th>Comunidad</th>
        </tr>
    </thead>
    <tbody id="tbDoc">
        <g:each in="${prsnTaller}" var="pt">
            <tr data-id="${pt.id}" style="width: 100%">
                <td style="width: 10%">${pt.cedula}</td>
                <td style="width: 20%"><elm:textoBusqueda busca="${params.search}">${pt.nombre}</elm:textoBusqueda></td>
                <td style="width: 20%"><elm:textoBusqueda busca="${params.search}">${pt.apellido}</elm:textoBusqueda></td>
                <td style="width: 10%">${pt.cargo}</td>
                <td style="width: 10%; text-align: center">${pt.sexo == 'M' ? 'Masculino' : 'Femenino'}</td>
                <td style="width: 15%">${pt.parroquia.nombre}</td>
                <td style="width: 15%">${pt?.comunidad?.nombre}</td>
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
                                url: "${createLink(controller:'personaTaller', action:'show_ajax')}",
                                data: {
                                    id: id
                                },
                                success: function (msg) {
                                    bootbox.dialog({
                                        title: "Ver Persona del taller",
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
                            createEditPersonaTaller(id);
                        }
                    },
                    eliminar: {
                        label: "Eliminar",
                        icon: "fa fa-trash",
                        separator_before: true,
                        action: function ($element) {
                            var id = $element.data("id");
                            boorarPersonaTaller(id);
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