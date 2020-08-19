<table>
    <tbody>


     %{--<tr>--}%
        %{--<td class="label">--}%
            %{--<g:message code="provincia.zona.label"--}%
                       %{--default="Numero"/>--}%
        %{--</td>--}%
        %{--<td class="campo">--}%
            %{--${fieldValue(bean: provinciaInstance, field: "zona")}--}%
        %{--</td> <!-- campo -->--}%
    %{--</tr>--}%

    <tr>
        <td class="label">
            <g:message code="provincia.nombre.label"
                       default="Provincia:"/>
        </td>
        <td class="campo">
            ${fieldValue(bean: provinciaInstance, field: "nombre")}
        </td> <!-- campo -->
    </tr>

    </tbody>
</table>