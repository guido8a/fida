<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 10/12/21
  Time: 11:19
--%>

<div class=""  style="width: 99.7%;height: 300px; overflow-y: auto;float: right; margin-top: -20px">
    <table id="tablaB" style="width: 100%" class="table-bordered table-condensed table-hover">
        <g:if test="${organizaciones}">
                <g:each in="${organizaciones}" var="organizacion" status="z">
                    <tr>
                        <td style="width: ${organizaciones.size() > 7 ? 88 : 86}%">
                            ${organizacion?.unejnmbr}
                        </td>
                        <td style="width: ${organizaciones.size() > 7 ? 12 : 14}%; text-align: center">
                            <a href="#" class="btn btn-sm btn-success btnSeleccionarOrg" data-id="${organizacion?.unej__id}"><i class="fa fa-check"></i> </a>
                        </td>
                    </tr>
                </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-danger" style="text-align: center; font-weight: bold">
                <i class="fa fa-exclamation-circle fa-2x text-danger"></i> No existen resultados para su búsqueda
            </div>
        </g:else>
    </table>
</div>

<script type="text/javascript">

    $(".btnSeleccionarOrg").click(function (msg) {
        cerrarDialogo();
        var idOrganizacion = $(this).data("id");
        if(${tipo == '1'}){
            location.href="${createLink(controller: 'reportes', action: 'reporteSociosExcel')}/" + idOrganizacion
        }else{
            if(${tipo == '2'}){
                location.href="${createLink(controller: 'reportes', action: 'reporteTalleresExcel')}/" + idOrganizacion
            }else{
                if(${tipo == '5'}){
                    location.href="${createLink(controller: 'reportes', action: 'reporteBeneficiariosExcel')}/" + idOrganizacion
                }else{
                    location.href="${createLink(controller: 'reportes', action: 'reportesConveniosExcel')}/" + idOrganizacion
                }
            }
        }

    })

</script>