<%@ page import="seguridad.PersonaOrganizacion" %>
<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${informantes}" var="informante">
            <tr style="width: 100%">
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSeleccion"  title="Seleccionar convenio"
                       data-id="${informante.pror__id}" data-nombre="${informante.prornmbr + " " + informante.prorapll}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
                <td style="width: 25%">
                    ${informante.prornmbr}
                </td>
                <td style="width: 25%">
                    ${informante.prorapll}
                </td>
                <td style="width: 15%">
                    ${informante.prorcdla}
                </td>
                <td style="width: 25%">
                    ${seguridad.UnidadEjecutora.get(informante.unej__id).nombre}
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleccion").click(function () {
        var id = $(this).data("id");
        var nombre = $(this).data("nombre");

        $("#personaOrganizacionName").val(nombre);
        $("#personaOrganizacion").val(id);
        cerrarDialogoBuscarOrganizacion()
    });

</script>