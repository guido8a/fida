<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/09/20
  Time: 12:46
--%>

<table class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr style="width: 100%">
        <th style="width: 10%">Cédula</th>
        <th style="width: 15%">Nombre</th>
        <th style="width: 16%">Apellido</th>
        <th style="width: 8%">F. Nacimiento</th>
        <th style="width: 6%">Sexo</th>
        <th style="width: 28%">Mail</th>
        <th style="width: 8%">Teléfono</th>
        <th style="width: 8%">Fecha</th>
        <th style="width: 1%"></th>
    </tr>
    </thead>
</table>
<div class="" style="width: 99.7%;height: 620px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${beneficiarios}" var="beneficiario">
            <tr data-id="${beneficiario.id}" style="width: 100%">
                <td style="width: 10%">${beneficiario.cedula}</td>
                <td style="width: 15%"><elm:textoBusqueda busca="${params.search}">${beneficiario.nombre}</elm:textoBusqueda></td>
                <td style="width: 16%"><elm:textoBusqueda busca="${params.search}">${beneficiario.apellido}</elm:textoBusqueda></td>
                <td style="width: 8%">${beneficiario?.fechaNacimiento?.format("dd-MM-yyyy")}</td>
                <td style="width: 6%; text-align: center">${beneficiario.sexo == 'M' ? 'Masculino' : 'Femenino'}</td>
                <td style="width: 28%">${beneficiario?.mail}</td>
                <td style="width: 8%">${beneficiario?.telefono}</td>
                <td style="width: 8%">${beneficiario?.fechaInicio?.format("dd-MM-yyyy")}</td>
                <g:if test="${beneficiarios?.size() > 1}">
                    <td style="width: 1%"></td>
                </g:if>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>


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
                            url: "${createLink(controller:'personaOrganizacion', action:'show_ajax')}",
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                bootbox.dialog({
                                    title: "Ver datos de la persona",
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
                        createEditBeneficiario(id);
                    }
                },
                eliminar: {
                    label: "Eliminar",
                    icon: "fa fa-trash",
                    separator_before: true,
                    action: function ($element) {
                        var id = $element.data("id");
                        borrarBeneficiario(id);
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