<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/08/20
  Time: 10:15
--%>

<table class="table table-condensed table-bordered table-hover table-striped" style="margin-top: -20px">
    <g:set var="itera" value=""/>
    <g:each in="${componentes}" var="comp" status="j">

        <tr id="comp${comp.comp__id}" class="comp">
            <g:if test="${j == 0}">
                <th colspan="17" class="info">
                    <strong>Componente</strong>:
                ${(comp.compdscr.length() > 80) ? comp.compdscr.substring(0, 80) + "..." : comp.compdscr}
                </th>
                <g:set var="itera" value="${comp.comp__id}"/>
            </g:if>
            <g:else>
                <g:if test="${comp.comp__id !=  itera}">
                    <th colspan="17" class="info">
                        <strong>Componente</strong>:
                    ${(comp.compdscr.length() > 80) ? comp.compdscr.substring(0, 80) + "..." : comp.compdscr}
                    </th>
                    <g:set var="itera" value="${comp.comp__id}"/>
                </g:if>
            </g:else>
        </tr>
    %{--        <g:each in="${proyectos.MarcoLogico.findAllByMarcoLogicoAndEstado(comp, 0, [sort: 'id'])}" var="act" status="i">--}%
    %{--            <g:if test="${!actSel || (actSel && actSel.id == act.id)}">--}%
    %{--                <g:set var="asignadoAct" value="${act.getTotalCronograma()}"/>  / --}%
    %{--                <g:set var="asignadoActAnio" value="${act.getTotalCronogramaAnio(anio)}"/>  / --}%
    %{--                <g:set var="totalAct" value="${act.monto}"/>  - --}%
    %{--                <g:set var="sinAsignarAct" value="${totalAct - asignadoAct}"/>  * --}%

    %{--                <g:set var="asignadoComp" value="${asignadoComp + asignadoActAnio}"/>  // --}%
    %{--                <g:set var="totalComp" value="${totalComp + totalAct}"/>  -- --}%
    %{--                <g:set var="sinAsignarComp" value="${sinAsignarComp + sinAsignarAct}"/>  ** --}%

    %{--                <g:set var="asignadoTotal" value="${asignadoTotal + asignadoActAnio}"/>  /// --}%
    %{--                <g:set var="totalTotal" value="${totalTotal + totalAct}"/>  --- --}%
    %{--                <g:set var="sinAsignarTotal" value="${sinAsignarTotal + sinAsignarAct}"/>  *** --}%
        <tr data-id="${comp.actv__id}" class="act comp${comp.comp__id}">
            %{--                    <th class="success">--}%
            %{--                        ${''}--}%
            %{--                    </th>--}%
            <th class="success actividad" title="${comp.actvdscr}" style="width:150px;">
                ${(comp.actvdscr.length() > 100) ? comp.actvdscr.substring(0, 100) + "..." : comp.actvdscr}
            </th>
            <th class="success actividad" title="${comp.actvdscr}" style="width:150px;">
                ${comp.plancsto}
            </th>
%{--            <g:each in="${lista}" var="mes" status="k">--}%
                <th>${comp.planms01}</th>
                <th>${comp.planms02}</th>
                <th>${comp.planms03}</th>
                <th>${comp.planms04}</th>
                <th>${comp.planms05}</th>
                <th>${comp.planms06}</th>
                <th>${comp.planms07}</th>
                <th>${comp.planms08}</th>
                <th>${comp.planms09}</th>
                <th>${comp.planms10}</th>
                <th>${comp.planms11}</th>
                <th>${comp.planms12}</th>
            %{--                        <g:set var="crga" value='${proyectos.Cronograma.findAllByMarcoLogicoAndMes(act, mes)}'/>--}%
            %{--                        <g:set var="valor" value="${0}"/>--}%
            %{--                        <g:set var="clase" value="disabled"/>--}%

            %{--                        <g:if test="${crga.size() > 0}">--}%
            %{--                            <g:each in="${crga}" var="c">--}%
            %{--                                <g:if test="${c?.anio == anio}">--}%
            %{--                                    <g:set var="crg" value='${c}'/>--}%
            %{--                                </g:if>--}%
            %{--                            </g:each>--}%
            %{--                            <g:if test="${crg}">--}%
            %{--                                <g:set var="valor" value="${crg.valor + crg.valor2}"/>--}%
            %{--                                <g:set var="clase" value="clickable"/>--}%
            %{--                            </g:if>--}%
            %{--                        </g:if>--}%
            %{--                        <g:if test="${totalAct > 0}">--}%
            %{--                            <g:set var="clase" value="clickable"/>--}%
            %{--                        </g:if>--}%
            %{--                        <g:else>--}%
            %{--                            <g:set var="clase" value="nop"/>--}%
            %{--                        </g:else>--}%
            %{--                        <td style="width:100px;" class="text-right ${clase} ${crg && crg.fuente ? 'fnte_' + crg.fuente.id : ''} ${crg && crg.fuente2 ? 'fnte_' + crg.fuente2.id : ''}"--}%
            %{--                            data-id="${crg?.id}" data-val="${valor}"--}%
            %{--                            data-presupuesto1="${crg?.valor}" data-bsc-desc-partida1="${crg?.presupuesto?.toString()}"--}%
            %{--                            data-partida1="${crg?.presupuesto?.id}"--}%
            %{--                            data-fuente1="${crg?.fuente?.id}" data-desc-fuente1="${crg?.fuente?.descripcion}"--}%
            %{--                            data-presupuesto2="${crg?.valor2}" data-bsc-desc-partida2="${crg?.presupuesto2?.toString()}"--}%
            %{--                            data-partida2="${crg?.presupuesto2?.id}"--}%
            %{--                            data-fuente2="${crg?.fuente2?.id}" data-desc-fuente2="${crg?.fuente2?.descripcion}">--}%
            %{--                            <g:formatNumber number="${valor}" type="currency" currencySymbol=""/>--}%
            %{--                        </td>--}%
            %{--                        <g:if test="${crg}">--}%
            %{--                            <g:set var="crg" value="${null}"/>--}%
            %{--                        </g:if>--}%
%{--            </g:each>--}%
%{--            <th class="disabled text-right asignado nop" data-val="${asignadoAct}">--}%
                %{--                        <g:formatNumber number="${asignadoActAnio}" type="currency" currencySymbol=""/>--}%
%{--            </th>--}%
%{--            <th class="disabled text-right sinAsignar nop" data-val="${sinAsignarAct}">--}%
                %{--                        <g:formatNumber number="${sinAsignarAct}" type="currency" currencySymbol=""/>--}%
%{--            </th>--}%
            <th colspan="3" class="disabled text-right total nop" data-val="${totalAct}">
                %{--                        <g:formatNumber number="${totalAct}" type="currency" currencySymbol=""/>--}%
            </th>
        </tr>
    %{--            </g:if>--}%
    %{--        </g:each>--}%



    </g:each>
    <tr class="warning total">
        <th colspan="14">TOTAL</th>
        <th class="text-right nop">
            <g:formatNumber number="${asignadoComp}" type="currency" currencySymbol=""/>
        </th>
        <th class="text-right nop">
            <g:formatNumber number="${sinAsignarComp}" type="currency" currencySymbol=""/>
        </th>
        <th class="text-right nop">
            <g:formatNumber number="${totalComp}" type="currency" currencySymbol=""/>
        </th>
    </tr>
</table>