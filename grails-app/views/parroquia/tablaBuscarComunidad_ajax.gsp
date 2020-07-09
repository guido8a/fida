<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/07/20
  Time: 13:34
--%>

<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${parroquias}" var="parroquia">
            <tr style="width: 100%">
                <td style="width: 5%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSeleParroquia"  title="Seleccionar parroquia"
                       data-id="${parroquia.cmnd__id}" data-nombre="${parroquia.cmndnmbr}" data-prov="${parroquia.provnmbr}"
                       data-parr="${parroquia.parrnmbr}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
                <td style="width: 15%">
                    ${parroquia.provnmbr}
                </td>
                <td style="width: 20%">
                    ${parroquia.cntnnmbr}
                </td>
                <td style="width: 30%">
                    ${parroquia.parrnmbr}
                </td>
                <td style="width: 30%">
                    ${parroquia.cmndnmbr}
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleParroquia").click(function () {
        var id = $(this).data("id");
        var nombre = $(this).data("nombre");
        var parroquia = $(this).data("parr");
        var provincia = $(this).data("prov");

        $("#comunidadTexto").val(nombre +" - "  + parroquia + " (" + provincia + ")");
        $("#comunidad").val(id);
        cerrarDialogoParroquia();
    });

</script>