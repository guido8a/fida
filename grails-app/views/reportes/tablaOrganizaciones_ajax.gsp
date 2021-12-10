<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 10/12/21
  Time: 11:19
--%>

<div class=""  style="width: 99.7%;height: 300px; overflow-y: auto;float: right; margin-top: -20px">
    <table id="tablaB" class="table-bordered table-condensed table-hover">
        <g:if test="${organizaciones}">
            <g:each in="${organizaciones}" var="organizacion" status="z">

                <tr >
%{--                    <td style="width: 30%">--}%
%{--                        ${organizacion?.provincia?.nombre}--}%
%{--                    </td>--}%
%{--                    <td style="width: 30%">--}%
%{--                        ${organizacion?.codigo}--}%
%{--                    </td>--}%
                    <td style="width: 90%">
                        ${organizacion?.nombre}
                    </td>
                    <td style="width: 10%">
                        <a href="#" class="btn btn-sm btn-success"><i class="fa fa-check"></i> </a>
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