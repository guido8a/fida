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
                <td style="width: 15%"><elm:textoBusqueda busca="${params.search}">
                    ${info?.desembolso?.descripcion}</elm:textoBusqueda></td>
                <td style="width: 35%"><elm:textoBusqueda busca="${params.search}">
                    ${info?.informeAvance}</elm:textoBusqueda></td>
                <td style="width: 35%"><elm:textoBusqueda busca="${params.search}">
                    ${info?.dificultadesAvance}</elm:textoBusqueda></td>
                <td style="width: 7%">${info?.porcentaje} %</td>
                <td style="width: 8%">${info.fecha?.format("dd-MM-yyyy")}</td>
            </tr>
        </g:each>
    </tbody>
</table>

<script type="text/javascript">
    $(function () {

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
                            location.href="${createLink(controller: 'avance', action: 'detalle')}" + "/?id=" + id;
                        }
                    },
                    eliminar: {
                        label: "Eliminar",
                        icon: "fa fa-trash",
                        separator_before: true,
                        action: function ($element) {
                            var id = $element.data("id");
                            borrarInforme(id);
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

        function borrarInforme(id) {
            bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> ¿Está seguro de querer borrar este informe?", function (res) {
                if(res){
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'informeAvance', action: 'borrarInforme_ajax')}',
                        data:{
                            id: id
                        },
                        success: function (msg) {
                            if(msg == 'ok'){
                                log("Informe borrado correctamente","success");
                                reloadTablaInforme();
                            }else{
                                if(msg == 'er'){
                                    bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i>  La información del informe ya está siendo utilizada, no puede ser borrado!")
                                }else{
                                    log("Error al borrar el informe","error")
                                }
                            }
                        }
                    });
                }
            });
        }

    });
</script>