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
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSeleParroquia"
                       title="Seleccionar parroquia" data-id="${parroquia.parr__id}"
                       data-nombre="${parroquia.parrnmbr}" data-prov="${parroquia.provnmbr}" data-can="${parroquia.cntnnmbr}" data-idProv="${parroquia.prov__id}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
                <td style="width: 20%">
                    ${parroquia.provnmbr}
                </td>
                <td style="width: 30%">
                    ${parroquia.cntnnmbr}
                </td>
                <td style="width: 40%">
                    ${parroquia.parrnmbr}
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleParroquia").click(function () {
        var id = $(this).data("id");
        var nombre = $(this).data("nombre");
        var provincia = $(this).data("prov");
        var canton = $(this).data("can");
        var idProvincia = $(this).data("idProv")

        $("#parroquiaTexto").val(nombre + " (" + provincia + ")");
        $("#parroquia").val(id);
        $(".buscarParroquia").removeAttr('disabled');

        if(${tipo == '3'}){
            $("#cantonTexto").val(canton);
            $("#provinciaTexto").val(provincia);
            $("#parroquiaTexto").val(nombre);
            $("#provincia").val(idProvincia);
        }

        if(${tipo != '1'}){
            comboComunidad(id)
        }
        cerrarDialogoParroquia();
    });

    function comboComunidad(id){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'taller', action: 'comunidad_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                colocarDiv(msg)
            }
        })
    }

    function colocarDiv(msg){
        var n = '';
        if(${tipo == '3'}){
            n = $("#divComunidadPersona").html(msg)
        }else{
            n = $("#divComunidad").html(msg)
        }

        return n
    }

</script>