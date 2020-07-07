<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 07/07/20
  Time: 11:25
--%>

<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${partidas}" var="partida">
            <tr style="width: 100%">
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSelePartida"  title="Seleccionar partida" data-id="${partida.prsp__id}" data-nombre="${partida.prspdscr}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
                <td style="width: 20%">
                    ${partida.prspnmro}
                </td>
                <td style="width: 70%">
                    ${partida.prspdscr}
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnSelePartida").click(function () {
        var id = $(this).data("id");
        var nombre = $(this).data("nombre");
        $("#partida1Texto").val(nombre);
        $("#partida1").val(id);
        cerrarDialogo();
    });

</script>
