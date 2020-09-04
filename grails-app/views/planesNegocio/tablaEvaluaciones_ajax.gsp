<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/09/20
  Time: 16:26
--%>

<table class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr style="width: 100%">
        <th style="width: 20%">Tipo de Evaluación</th>
        <th style="width: 39%">Descripción</th>
        <th style="width: 20%">Fecha de Inicio</th>
        <th style="width: 20%">Fecha de Fin</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>
<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <tbody>
                <g:each in="${evaluaciones}" var="evaluacion">
                    <tr data-id="${evaluacion.id}" style="width: 100%">
                        <td style="width: 20%"><elm:textoBusqueda busca="${params.search}">${evaluacion?.tipoEvaluacion?.descripcion}</elm:textoBusqueda></td>
                        <td style="width: 39%"><elm:textoBusqueda busca="${params.search}">${evaluacion?.descripcion}</elm:textoBusqueda></td>
                        <td style="width: 20%">${evaluacion?.fechaInicio?.format("dd-MM-yyyy")}</td>
                        <td style="width: 20%; text-align: center">${evaluacion?.fechaFin?.format("dd-MM-yyyy")}</td>
                        <g:if test="${evaluaciones?.size() < 7}">
                            <td style="width: 1%"></td>
                        </g:if>
                    </tr>
                </g:each>
        </tbody>
    </table>
</div>


<script type="text/javascript">
    $(function () {

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
                        var id = $element.data("id");
                        createEditEvaluacion(id);
                    }
                },
                detalle: {
                    label: "Detalle",
                    icon: "fa fa-align-justify",
                    action: function ($element) {
                        var id = $element.data("id");
                        location.href="${createLink(controller: 'evaluacion', action: 'detalleEvaluacion')}/" + id
                    }
                },
                eliminar: {
                    label: "Eliminar",
                    icon: "fa fa-trash",
                    separator_before: true,
                    action: function ($element) {
                        var id = $element.data("id");
                        borrarEvaluacion(id);
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