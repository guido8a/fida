<%@ page import="parametros.Mes; proyectos.Cronograma; proyectos.MarcoLogico; parametros.Anio" %>
<table class="table table-condensed table-bordered table-hover table-striped" id="tblCrono">
    <thead>
    <tr>
        <th>Año</th>
        <th colspan="16">
            <g:select from="${parametros.Anio.list([sort: 'anio'])}" optionKey="id" optionValue="anio" class="form-control input-sm"
                      style="width: 100px; display: inline" name="anio" id="anio" value="${anio.id}"/>
        </th>
    </tr>

    <tr id="trMeses" >
%{--        <th colspan="2" style="width:300px;">Componentes/Rubros</th>--}%
        <th colspan="2" style="width: 6.25%">Componentes/Rubros</th>
        <g:each in="${parametros.Mes.list()}" var="mes">
%{--            <th style="width:100px;" data-id="${mes.id}" title="${mes.descripcion} ${anio.anio}">--}%
            <th style="width:5.25%;" data-id="${mes.id}" title="${mes.descripcion} ${anio.anio}">
                ${mes.descripcion[0..2]}.
            </th>
        </g:each>
        <th style="width: 8.25%;">Total<br/>Año</th>
        <th style="width: 8.25%;">Sin<br/>asignar</th>
        <th style="width: 8.25%;">Total<br/>Asignado</th>
    </tr>
    </thead>
</table>


<div class="" style="width: 99.7%;height: 350px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table table-condensed table-bordered table-hover table-striped" style="width: 100%">
        <tbody>
        <g:set var="asignadoAct" value="${0}"/> %{-- / --}%
        <g:set var="sinAsignarAct" value="${0}"/> %{-- * --}%
        <g:set var="totalAct" value="${0}"/> %{-- - --}%

        <g:set var="asignadoComp" value="${0}"/> %{-- // --}%
        <g:set var="sinAsignarComp" value="${0}"/> %{-- ** --}%
        <g:set var="totalComp" value="${0}"/> %{-- -- --}%

        <g:set var="asignadoTotal" value="${0}"/> %{-- /// --}%
        <g:set var="sinAsignarTotal" value="${0}"/> %{-- *** --}%
        <g:set var="totalTotal" value="${0}"/> %{-- --- --}%


        <g:each in="${componentes}" var="comp" status="j">

            <g:set var="totalEnero" value="${0}"/>
            <g:set var="totalFebrero" value="${0}"/>
            <g:set var="totalMarzo" value="${0}"/>
            <g:set var="totalAbril" value="${0}"/>
            <g:set var="totalMayo" value="${0}"/>
            <g:set var="totalJunio" value="${0}"/>
            <g:set var="totalJulio" value="${0}"/>
            <g:set var="totalAgosto" value="${0}"/>
            <g:set var="totalSeptiembre" value="${0}"/>
            <g:set var="totalOctubre" value="${0}"/>
            <g:set var="totalNoviembre" value="${0}"/>
            <g:set var="totalDiciembre" value="${0}"/>

            <g:set var="asignadoComp" value="${0}"/> %{-- // --}%
            <g:set var="sinAsignarComp" value="${0}"/> %{-- ** --}%
            <g:set var="totalComp" value="${0}"/> %{-- -- --}%
            <tr id="comp${comp.id}" class="comp">
                <th colspan="17" class="success">
                    <strong>Componente ${comp.numero}</strong>:
                ${(comp.objeto.length() > 80) ? comp.objeto.substring(0, 80) + "..." : comp.objeto}
                </th>
            </tr>
            <g:each in="${proyectos.MarcoLogico.findAllByMarcoLogicoAndEstado(comp, 0, [sort: 'id'])}" var="act" status="i">

                <g:if test="${!actSel || (actSel && actSel.id == act.id)}">
                    <g:set var="asignadoAct" value="${act.getTotalCronograma()}"/> %{-- / --}%
                    <g:set var="asignadoActAnio" value="${act.getTotalCronogramaAnio(anio)}"/> %{-- / --}%
                    <g:set var="totalAct" value="${act.monto}"/> %{-- - --}%
                    <g:set var="sinAsignarAct" value="${totalAct - asignadoAct}"/> %{-- * --}%

                    <g:set var="asignadoComp" value="${asignadoComp + asignadoActAnio}"/> %{-- // --}%
                    <g:set var="totalComp" value="${totalComp + totalAct}"/> %{-- -- --}%
                    <g:set var="sinAsignarComp" value="${sinAsignarComp + sinAsignarAct}"/> %{-- ** --}%

                    <g:set var="asignadoTotal" value="${asignadoTotal + asignadoActAnio}"/> %{-- /// --}%
                    <g:set var="totalTotal" value="${totalTotal + totalAct}"/> %{-- --- --}%
                    <g:set var="sinAsignarTotal" value="${sinAsignarTotal + sinAsignarAct}"/> %{-- *** --}%

                    <tr data-id="${act.id}" class="act comp${comp.id}">
                        <th class="success" style="width:2.25%;">
                            ${act.numero}
                        </th>
%{--                        <th class="success actividad" title="${act.objeto}" style="width:300px;">--}%
                        <th class="success actividad" title="${act.objeto}" style="width:4%;">
                            ${(act.objeto.length() > 100) ? act.objeto.substring(0, 100) + "..." : act.objeto}
                        </th>
                        <g:each in="${parametros.Mes.list()}" var="mes" status="k">
                            <g:set var="crga" value='${proyectos.Cronograma.findAllByMarcoLogicoAndMes(act, mes)}'/>
                            <g:set var="valor" value="${0}"/>
                            <g:set var="clase" value="disabled"/>

                            <g:if test="${crga.size() > 0}">
                                <g:each in="${crga}" var="c">
                                    <g:if test="${c?.anio == anio}">
                                        <g:set var="crg" value='${c}'/>
                                    </g:if>
                                </g:each>
                                <g:if test="${crg}">
                                    <g:set var="valor" value="${crg.valor + crg.valor2}"/>
                                    <g:set var="clase" value="clickable"/>
                                </g:if>
                            </g:if>
                            <g:if test="${totalAct > 0}">
                                <g:set var="clase" value="clickable"/>
                            </g:if>
                            <g:else>
                                <g:set var="clase" value="nop"/>
                            </g:else>
%{--                            <td style="width:100px;" class="text-right ${clase} ${crg && crg.fuente ? 'fnte_' + crg.fuente.id : ''} ${crg && crg.fuente2 ? 'fnte_' + crg.fuente2.id : ''}"--}%
                            <td style="width:5.25% !important;" class="text-right ${clase} ${crg && crg.fuente ? 'fnte_' + crg.fuente.id : ''} ${crg && crg.fuente2 ? 'fnte_' + crg.fuente2.id : ''}"
                                data-id="${crg?.id}" data-val="${valor}"
                                data-presupuesto1="${crg?.valor}" data-bsc-desc-partida1="${crg?.presupuesto?.toString()}"
                                data-partida1="${crg?.presupuesto?.id}"
                                data-fuente1="${crg?.fuente?.id}" data-desc-fuente1="${crg?.fuente?.descripcion}"
                                data-presupuesto2="${crg?.valor2}" data-bsc-desc-partida2="${crg?.presupuesto2?.toString()}"
                                data-partida2="${crg?.presupuesto2?.id}"
                                data-fuente2="${crg?.fuente2?.id}" data-desc-fuente2="${crg?.fuente2?.descripcion}">
                                %{--id: ${crg?.id}*${crg?.valor}*${crg?.valor2}--}%
                                <g:formatNumber number="${valor}" type="currency" currencySymbol=""/>
                                <g:if test="${k == 0}">
                                    <g:set var="totalEnero" value="${totalEnero += valor}"/>
                                </g:if>
                                <g:if test="${k == 1}">
                                    <g:set var="totalFebrero" value="${totalFebrero += valor}"/>
                                </g:if>
                                <g:if test="${k == 2}">
                                    <g:set var="totalMarzo" value="${totalMarzo += valor}"/>
                                </g:if>
                                <g:if test="${k == 3}">
                                    <g:set var="totalAbril" value="${totalAbril += valor}"/>
                                </g:if>
                                <g:if test="${k == 4}">
                                    <g:set var="totalMayo" value="${totalMayo += valor}"/>
                                </g:if>
                                <g:if test="${k == 5}">
                                    <g:set var="totalJunio" value="${totalJunio += valor}"/>
                                </g:if>
                                <g:if test="${k == 6}">
                                    <g:set var="totalJulio" value="${totalJulio += valor}"/>
                                </g:if>
                                <g:if test="${k == 7}">
                                    <g:set var="totalAgosto" value="${totalAgosto += valor}"/>
                                </g:if>
                                <g:if test="${k == 8}">
                                    <g:set var="totalSeptiembre" value="${totalSeptiembre += valor}"/>
                                </g:if>
                                <g:if test="${k == 9}">
                                    <g:set var="totalOctubre" value="${totalOctubre += valor}"/>
                                </g:if>
                                <g:if test="${k == 10}">
                                    <g:set var="totalNoviembre" value="${totalNoviembre += valor}"/>
                                </g:if>
                                <g:if test="${k == 11}">
                                    <g:set var="totalDiciembre" value="${totalDiciembre += valor}"/>
                                </g:if>

                            </td>
                            <g:if test="${crg}">
                                <g:set var="crg" value="${null}"/>
                            </g:if>
                        </g:each>
                        <th class="disabled text-right asignado nop" data-val="${asignadoAct}" style="width:7.25%;">
                            %{--1/--}%
                            <g:formatNumber number="${asignadoActAnio}" type="currency" currencySymbol="" />
                        </th>
                        <th class="disabled text-right sinAsignar nop" data-val="${sinAsignarAct}" style="width:6.25%;">
                            %{--1*--}%
                            <g:formatNumber number="${sinAsignarAct}" type="currency" currencySymbol=""/>
                        </th>
                        <th class="disabled text-right total nop" data-val="${totalAct}" style="width:6.25%;">
                            %{--1---}%
                            %{--${act.id}*${act.monto}--}%
                            <g:formatNumber number="${totalAct}" type="currency" currencySymbol=""/>
                        </th>
                    </tr>
                </g:if>
            </g:each>
            <tr class="warning total comp${comp.id}">
                <th colspan="2">TOTAL</th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalEnero}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalFebrero}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalMarzo}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalAbril}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalMayo}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalJunio}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalJulio}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalAgosto}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalSeptiembre}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalOctubre}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalNoviembre}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    <g:formatNumber number="${totalDiciembre}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    %{-- // --}%
                    <g:formatNumber number="${asignadoComp}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    %{-- ** --}%
                    <g:formatNumber number="${sinAsignarComp}" type="currency" currencySymbol=""/>
                </th>
                <th class="text-right nop">
                    %{-- -- --}%
                    <g:formatNumber number="${totalComp}" type="currency" currencySymbol=""/>
                </th>
            </tr>
        </g:each>
        </tbody>
        <tfoot>
        <tr class="danger">
            <th colspan="14">TOTAL DEL PROYECTO</th>
            <th class="text-right nop">
                %{-- /// --}%
                <g:formatNumber number="${asignadoTotal}" type="currency" currencySymbol=""/><g:formatNumber number="${totProyAsig}" type="currency" currencySymbol=""/>
            </th>
            <th class="text-right nop">
                %{-- *** --}%
                <g:formatNumber number="${sinAsignarTotal}" type="currency" currencySymbol=""/>
            </th>
            <th class="text-right nop">
                %{-- --- --}%
                <g:formatNumber number="${totalTotal}" type="currency" currencySymbol=""/>
            </th>
        </tr>
        </tfoot>
    </table>
</div>