%{--<script src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script src="${resource(dir: 'js/plugins/fixed-header-table-1.3', file: 'jquery.fixedheadertable.js')}"></script>--}%
%{--<link rel="stylesheet" type="text/css" href="${resource(dir: 'js/plugins/fixed-header-table-1.3/css', file: 'defaultTheme.css')}"/>--}%

<table id="tblDocumentos" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
        <tr>
            <th>Grupo Procesos</th>
            <th>Descripción</th>
            <th>Palabras Clave</th>
            <th>Resumen</th>
            <th>Acciones</th>
        </tr>
    </thead>
    <tbody id="tbDoc">
        <g:each in="${documentos}" var="doc">
            <tr data-id="${doc.id}" style="width: 100%">
                <td style="width: 12%">${doc.grupoProcesos.descripcion}</td>
                <td style="width: 15%"><elm:textoBusqueda busca="${params.search}">${doc.descripcion}</elm:textoBusqueda></td>
                <td style="width: 15%"><elm:textoBusqueda busca="${params.search}">${doc.clave}</elm:textoBusqueda></td>
                <td style="width: 50%"><elm:textoBusqueda busca="${params.search}">${doc.resumen}</elm:textoBusqueda></td>
                <td style="width: 8%; text-align: center">
                    <div class="btn-group" role="group">

                        <a href="#" class="btn btn-xs btn-success btnDownDoc" data-id="${doc.id}" title="Descargar">
                            <i class="fa fa-download"></i>
                        </a>
                        <a href="#" class="btn btn-xs btn-info btnEditDoc" data-id="${doc.id}" title="Editar">
                            <i class="fa fa-edit"></i>
                        </a>
                        <a href="#" class="btn btn-xs btn-danger btnDelDoc" data-id="${doc.id}" title="Eliminar">
                            <i class="fa fa-trash"></i>
                        </a>
                    </div>
                </td>
            </tr>
        </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(function () {
        setTimeout(function () {
            $("#tblDocumentos").fixedHeaderTable({
                height : 250
            });
        }, 500);

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
                editar: {
                    label: "Editar",
                    icon: "fa fa-edit",
                    action: function ($element) {
                        createEditDocumento($element.data("id"));
                    }
                },
                descargar: {
                    label: "Descargar",
                    icon: "fa fa-download",
                    action: function ($element) {
                        downloadDocumento($element.data("id"));
                    }
                },
                eliminar: {
                    label: "Eliminar",
                    icon: "fa fa-trash",
                    separator_before: true,
                    action: function ($element) {
                        var id = $element.data("id");
                        deleteDocumento(id);
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