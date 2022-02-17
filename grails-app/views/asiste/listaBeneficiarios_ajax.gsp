<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 16/02/22
  Time: 15:33
--%>

<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/09/20
  Time: 12:46
--%>

<table class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr style="width: 100%">
        <th style="width: 20%">Cédula</th>
        <th style="width: 35%">Nombre</th>
        <th style="width: 35%">Apellido</th>
        <th style="width: 10%">Asistencia</th>
    </tr>
    </thead>
</table>
<div id="tablaBeneficiariosAsiste" class="row">

</div>
%{--<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">--}%
%{--    <table class="table-bordered table-condensed table-hover" style="width: 100%">--}%
%{--        <tbody>--}%
%{--        <g:each in="${beneficiarios}" var="beneficiario">--}%
%{--            <tr data-id="${beneficiario.id}" style="width: 100%">--}%
%{--                <td style="width: 10%">${beneficiario.cedula}</td>--}%
%{--                <td style="width: 19%"><elm:textoBusqueda busca="${params.search}">${beneficiario.nombre}</elm:textoBusqueda></td>--}%
%{--                <td style="width: 20%"><elm:textoBusqueda busca="${params.search}">${beneficiario.apellido}</elm:textoBusqueda></td>--}%
%{--                --}%%{--                <td style="width: 10%">${beneficiario.cargo}</td>--}%
%{--                <td style="width: 10%; text-align: center">${beneficiario.sexo == 'M' ? 'Masculino' : 'Femenino'}</td>--}%
%{--                <td style="width: 20%">${beneficiario?.mail}</td>--}%
%{--                <td style="width: 10%">${beneficiario?.telefono}</td>--}%
%{--                <td style="width: 10%">${beneficiario?.fechaInicio?.format("dd-MM-yyyy")}</td>--}%
%{--                <g:if test="${beneficiarios?.size() < 7}">--}%
%{--                    <td style="width: 1%"></td>--}%
%{--                </g:if>--}%
%{--            </tr>--}%
%{--        </g:each>--}%
%{--        </tbody>--}%
%{--    </table>--}%
%{--</div>--}%


<script type="text/javascript">

    cargarTablaBeneficiarios();


    function cargarTablaBeneficiarios(){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'asiste', action:'tablaBeneficiariosAsiste_ajax')}",
            data    : {
                    id: '${unidad?.id}',
                    taller: '${taller?.id}'
            },
            success : function (msg) {
                $("#tablaBeneficiariosAsiste").html(msg);
            }
        });
    }


</script>