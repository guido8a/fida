<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/08/20
  Time: 10:15
--%>

<table class="table table-condensed table-bordered table-hover table-striped" style="margin-top: -20px">
    <g:set var="itera" value=""/>
    <g:each in="${componentes}" var="comp" status="j">

%{--        hacer iterativo para varios componentes--}%

        <tr id="comp${comp.comp__id}" class="comp">
            <g:if test="${j == 0}">
                <th colspan="17" class="info">
                    <strong>Componente</strong>:
                ${(comp.compdscr.length() > 200) ? comp.compdscr.substring(0, 200) + "..." : comp.compdscr}
                </th>
                <g:set var="itera" value="${comp.comp__id}"/>
            </g:if>
            <g:else>
                <g:if test="${comp.comp__id !=  itera}">
                    <th colspan="17" class="info">
                        <strong>Componente</strong>:
                    ${(comp.compdscr.length() > 200) ? comp.compdscr.substring(0, 200) + "..." : comp.compdscr}
                    </th>
                    <g:set var="itera" value="${comp.comp__id}"/>
                </g:if>
            </g:else>
        </tr>

        <tr data-id="${comp.actv__id}" class="act comp${comp.comp__id}">
            <th class="success actividad" title="${comp.actvdscr}" style="width:15%">
                ${(comp.actvdscr.length() > 100) ? comp.actvdscr.substring(0, 100) + "..." : comp.actvdscr}
            </th>
            <th class="success actividad" title="${comp.actvdscr}" style="width:6%; text-align: right">
%{--                ${comp.plancsto}--}%
                <g:formatNumber number="${comp.plancsto}" type="currency" currencySymbol=""/>
            </th>
                <th style="width: 6%; text-align: right">${comp.planms01}</th>
                <th style="width: 6%; text-align: right">${comp.planms02}</th>
                <th style="width: 6%; text-align: right">${comp.planms03}</th>
                <th style="width: 6%; text-align: right">${comp.planms04}</th>
                <th style="width: 6%; text-align: right">${comp.planms05}</th>
                <th style="width: 6%; text-align: right">${comp.planms06}</th>
                <th style="width: 6%; text-align: right">${comp.planms07}</th>
                <th style="width: 6%; text-align: right">${comp.planms08}</th>
                <th style="width: 6%; text-align: right">${comp.planms09}</th>
                <th style="width: 6%; text-align: right">${comp.planms10}</th>
                <th style="width: 6%; text-align: right">${comp.planms11}</th>
                <th style="width: 6%; text-align: right">${comp.planms12}</th>

            <th colspan="3" class="disabled text-right total nop" data-val="${totalAct}">
                <g:formatNumber number="${comp.plantotl}" type="currency" currencySymbol=""/>
            </th>
        </tr>

    </g:each>

    <tr class="warning total">
        <th colspan="14">TOTAL</th>
%{--
        <th class="text-right nop">
            <g:formatNumber number="${asignadoComp}" type="currency" currencySymbol=""/>
        </th>
        <th class="text-right nop">
            <g:formatNumber number="${sinAsignarComp}" type="currency" currencySymbol=""/>
        </th>
--}%
        <th class="text-right nop">
            <g:formatNumber number="${totalComp}" type="currency" currencySymbol=""/>
        </th>
    </tr>

</table>

<script type="text/javascript">

    $(function () {

        $("tbody>tr").contextMenu({
            items: {
                header: {
                    label: "Acciones",
                    header: true
                },
                ver: {
                    label: "Ver",
                    icon: "fa fa-search",
                    action: function ($element) {
                        var id = $element.data("id");
                        $.ajax({
                            type: "POST",
                            url: "${createLink(controller:'personaTaller', action:'show_ajax')}",
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                bootbox.dialog({
                                    title: "Ver Persona del taller",
                                    message: msg,
                                    buttons: {
                                        ok: {
                                            label: "Aceptar",
                                            className: "btn-primary",
                                            callback: function () {
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                },
                editar: {
                    label: "Editar",
                    icon: "fa fa-edit",
                    action: function ($element) {
                        var id = $element.data("id");
                        createEditPersonaTaller(id);
                    }
                },
                eliminar: {
                    label: "Eliminar",
                    icon: "fa fa-trash",
                    separator_before: true,
                    action: function ($element) {
                        var id = $element.data("id");
                        boorarPersonaTaller(id);
                    }
                }
            },
            onShow: function ($element) {
                $element.addClass("success");
            },
            onHide: function ($element) {
                $(".success").removeClass("success");
            }
        });



    });

</script>