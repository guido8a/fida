<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${convenios}" var="convenio">
            <tr style="width: 100%">
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSeleccion"  title="Seleccionar convenio"
                       data-id="${convenio.unej__id}" data-nombre="${convenio.unejnmbr}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
                <td style="width: 30%">
                    ${convenio.unejnmbr}
                </td>
                <td style="width: 15%">
                    ${convenio.provnmbr}
                </td>
                <td style="width: 15%">
                    ${convenio.cntnnmbr}
                </td>
                <td style="width: 15%">
                    ${convenio.parrnmbr}
                </td>
                <td style="width: 13%">
                    <g:if test="${convenio.unejfcin}">
                        ${convenio.unejfcin.format("dd-MM-yyyy")}
                    </g:if>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleccion").click(function () {
        var id = $(this).data("id");
        var nombre = $(this).data("nombre");

        ${tipo == '1'} ?  ($("#unidadEjecutoraName").val(nombre), $("#unidadEjecutora").val(id) ,  cerrarDialogoBuscarOrganizacion()) : location.href="${createLink(controller: 'unidadEjecutora', action: 'organizacion')}/" + id;
    });

</script>