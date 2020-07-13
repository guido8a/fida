<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 13/07/20
  Time: 15:42
--%>
<g:if test="${administradores.size() > 0}">
    <div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
        <table class="table-bordered table-condensed table-hover" style="width: 100%">
            <g:each in="${administradores}" var="administrador">
                <tr style="width: 100%">
                    <td style="width: 40%">
                        ${administrador?.persona?.nombre + " " + administrador?.persona?.apellido}
                    </td>
                    <td style="width: 15%">
                        ${administrador?.fechaInicio?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 15%">
                        ${administrador?.fechaFin?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 30%">
                        ${administrador?.observaciones}
                    </td>
                </tr>
            </g:each>
        </table>
    </div>
</g:if>
<g:else>
    <div class="alert alert-danger" style="text-align: center; margin-top: -20px">
       <strong style="color: #fdfbff"><i class='fa fa-exclamation-triangle fa-2x text-info text-shadow'></i> No existe un administrador asignado</strong>
    </div>
</g:else>
