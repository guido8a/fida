<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/09/20
  Time: 11:09
--%>

%{--<g:each in="${respuestas}" status="i" var="respuesta">--}%
%{--    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">--}%
%{--        <td>--}%
%{--            <input type="checkbox" name="respuestaSel" class="form-control respSeleccionada" value="${''}" ${seleccionadas?.respuesta?.contains(respuesta) ? 'checked' : ''}>--}%
%{--            <span>${respuesta?.opcion}</span>--}%
%{--        </td>--}%
%{--    </tr>--}%
%{--</g:each>--}%

<g:each in="${respuestas}" var="respuesta" status="i">
    <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
        <td>
            <g:checkBox class="c2" name="c1" data-id="${respuesta?.id}" value="${seleccionadas?.respuesta?.contains(respuesta.id)}"
                        checked="${seleccionadas?.respuesta?.contains(respuesta) ? 'true' : 'false'}"/>
            <span>${respuesta?.opcion}</span>
        </td>
    </tr>
</g:each>