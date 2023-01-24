<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${encuestas}" var="encuesta">
            <tr style="width: 100%">
                %{--<td style="width: 35%">--}%
                    %{--${encuesta.observaciones}--}%
                %{--</td>--}%
                <td style="width: 25%">
                    ${encuesta.fecha.format("dd-MM-yyyy")}
                </td>
                <td style="width: 10%">
                    ${encuesta.estado}
                </td>
                <td style="width: 20%">
                    ${(encuesta?.personaOrganizacion?.nombre ?: '') + " " + (encuesta?.personaOrganizacion?.apellido ?: '')}
                </td>
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSeleccion"  title="Seleccionar informante"
                       data-id="${encuesta.id}" >
                        <i class="fa fa-user"></i>
                    </a>
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">
    var de

    $(".btnSeleccion").click(function () {
        var idEncuesta = $(this).data("id");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'encuesta', action: 'buscarInformante_ajax')}',
            data: {
                unidad: '${organizacion?.id}',
                encuesta: idEncuesta
            },
            success: function (msg) {
                de = bootbox.dialog({
                    id: "dlgBuscarInformante",
                    title: "Buscar Informante",
                    class: "modal-lg",
                    closeButton: false,
                    message: msg,
                    buttons: {
                        cancelar: {
                            label: "Cancelar",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                }); //dialog
            }
        });
    });

</script>