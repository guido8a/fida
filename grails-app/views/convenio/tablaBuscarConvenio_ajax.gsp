<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 13/07/20
  Time: 12:22
--%>

<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <g:each in="${convenios}" var="convenio">
            <tr style="width: 100%">
                <td style="width: 10%; text-align: center">
                    <a href="#" class="btn btn-xs btn-success btnSeleConvenio"  title="Seleccionar convenio" data-id="${convenio.cnvn__id}">
                        <i class="fa fa-check"></i>
                    </a>
                </td>
                <td style="width: 20%">
                    ${convenio.parrnmbr}
                </td>
                <td style="width: 10%">
                    ${convenio.cnvncdgo}
                </td>
                <td style="width: 30%">
                    ${convenio.cnvnnmbr}
                </td>
                <td style="width: 15%">
                    ${convenio.unejnmbr}
                </td>
                <td style="width: 15%">
                    ${convenio.cnvnfcin.format("dd-MM-yyyy")}
                </td>
            </tr>
        </g:each>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleConvenio").click(function () {
        var id = $(this).data("id");
        location.href="${createLink(controller: 'convenio', action: 'convenio')}/" + id
    });

</script>