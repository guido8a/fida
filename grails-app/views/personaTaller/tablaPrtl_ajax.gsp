%{--<script src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script src="${resource(dir: 'js/plugins/fixed-header-table-1.3', file: 'jquery.fixedheadertable.js')}"></script>--}%
%{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/plugins/fixed-header-table-1.3/css', file: 'defaultTheme.css')}"/>--}%

<table id="tblDocumentos" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
        <tr>
            <th>Cédula</th>
            <th>Nombre</th>
            <th>Apellido</th>
            <th>Parroquia</th>
            <th>Comunidad</th>
            <th>Cargo</th>
            <th>Sexo</th>
            <th>Autodetermanación</th>
        </tr>
    </thead>
    <tbody id="tbDoc">
        <g:each in="${prsnTaller}" var="pt">
            <tr data-id="${pt.id}">
                <td>${pt.cedula}</td>
                <td><elm:textoBusqueda busca="${params.search}">${pt.nombre}</elm:textoBusqueda></td>
                <td><elm:textoBusqueda busca="${params.search}">${pt.apellido}</elm:textoBusqueda></td>
                <td>${pt.parroquia.nombre}</td>
                <td>${pt.comunidad.nombre}</td>
                <td>${pt.cargo}</td>
                <td>${pt.sexo}</td>
                <td><elm:textoBusqueda busca="${params.search}">${pt.raza}</elm:textoBusqueda></td>

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
                                url: "${createLink(controller:'taller', action:'show_ajax')}",
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
                            createEditTaller(id);
                        }
                    },
                    Asistentes: {
                        label: "Asistentes al Taller",
                        icon: "fas fa-user-friends",
                        action: function ($element) {
                            var id = $element.data("id");
                            createEditTaller(id);
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