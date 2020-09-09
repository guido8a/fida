<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/08/20
  Time: 10:15
--%>

<style>

    .verde{
        background-color: #93c17d;
        font-weight: bold;
    }

</style>



<table class="table table-condensed table-bordered table-hover table-striped" style="margin-top: -20px">
    <g:set var="itera" value=""/>
    <g:set var="anterior" value=""/>
    <g:set var="totalFinal" value="${0}"/>
    <g:each in="${componentes}" var="comp" status="j">

    %{--        hacer iterativo para varios componentes--}%

        <g:if test="${j != 0}">
            <g:if test="${comp.comp__id !=  anterior}">
                <tr class="warning total">
                    <td colspan="14">TOTAL</td>
                    <td class="text-right nop">
                        <g:formatNumber number="${totalFinal}" type="currency" currencySymbol=""/>
                    </td>
                </tr>
                <g:set var="totalFinal" value="${0}"/>
            </g:if>
        </g:if>

        <tr id="comp${comp.comp__id}" class="comp">
            <g:if test="${j == 0}">
                <td colspan="17" class="info">
                    <strong>Componente</strong>:
                ${(comp.compdscr.length() > 200) ? comp.compdscr.substring(0, 200) + "..." : comp.compdscr}
                </td>
                <g:set var="itera" value="${comp.comp__id}"/>
            </g:if>
            <g:else>
                <g:if test="${comp.comp__id !=  itera}">
                    <td colspan="17" class="info">
                        <strong>Componente</strong>:
                    ${(comp.compdscr.length() > 200) ? comp.compdscr.substring(0, 200) + "..." : comp.compdscr}
                    </td>
                    <g:set var="itera" value="${comp.comp__id}"/>
                </g:if>
            </g:else>
        </tr>

        <tr data-id="${comp.actv__id}" class="act comp${comp.comp__id}">
            <td class="verde actividad" title="${comp.plandscr}" style="width:15%">
                ${(comp.actvdscr.length() > 100) ? comp.actvdscr.substring(0, 100) + "..." : comp.actvdscr}
            </td>
            <td class="verde actividad" title="${comp.actvdscr}" style="width:6%; text-align: right">
                <g:formatNumber number="${comp.plancsto}" type="currency" currencySymbol=""/>
            </td>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${1}">${comp.planms01}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${2}">${comp.planms02}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${3}">${comp.planms03}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${4}">${comp.planms04}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${5}">${comp.planms05}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${6}">${comp.planms06}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${7}">${comp.planms07}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${8}">${comp.planms08}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${9}">${comp.planms09}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${10}">${comp.planms10}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${11}">${comp.planms11}</th>
            <th style="width: 6%; text-align: right" data-plan="${comp.plan__id}" data-per="${12}">${comp.planms12}</th>

            <th colspan="3" class="disabled text-right total nop">
                <g:formatNumber number="${comp.plantotl}" type="currency" currencySymbol=""/>
            </th>

            <g:set var="totalFinal" value="${totalFinal += comp.plantotl}"/>
        </tr>

        <g:if test="${j+1 == tam}">
            <tr class="warning total">
                <td colspan="14"><strong>TOTAL</strong></td>
                <td class="text-right nop" style="font-weight: bold">
                    <g:formatNumber number="${totalFinal}" type="currency" currencySymbol=""/>
                </td>
            </tr>
        </g:if>

        <g:set var="anterior" value="${comp.comp__id}"/>
        <g:set var="totalFinal" value="${totalFinal}"/>
    </g:each>

</table>

<script type="text/javascript">

    $(function () {

        $("tbody>tr>th").contextMenu({
            items: {
                header: {
                    label: "Acciones",
                    header: true
                },
                editar: {
                    label: "Editar",
                    icon: "fa fa-edit",
                    action: function ($element) {
                        var id = $element.data("plan");
                        var per = $element.data("per");
                        $.ajax({
                            type: "POST",
                            url: "${createLink(controller:'plan', action:'valor_ajax')}",
                            data: {
                                id: id,
                                anio: '${anio}',
                                periodo: per
                            },
                            success: function (msg) {
                                bootbox.dialog({
                                    title: "Editar valor del período",
                                    message: msg,
                                    class : "modal-sm",
                                    buttons: {
                                        cancel:{
                                            label: "Cancelar",
                                            className: "btn-primary",
                                            callback: function () {
                                            }
                                        },
                                        ok: {
                                            label: "Aceptar",
                                            className: "btn-success",
                                            callback: function () {
                                                var valor = $("#valorPeriodo").val();
                                                guardarValorPeriodo(id, per, '${anio}', valor)
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                },
                eliminar: {
                    label: "Eliminar",
                    icon: "fa fa-trash",
                    separator_before: true,
                    action: function ($element) {
                        var id = $element.data("plan");
                        var per = $element.data("per");
                        guardarValorPeriodo(id, per, '${anio}', 0)
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


        function guardarValorPeriodo(id,periodo,anio, valor){
            $.ajax({
                type: 'POST',
                url:'${createLink(controller: 'plan', action: 'guardarValorPeriodo_ajax')}',
                data:{
                    plan: id,
                    periodo: periodo,
                    anio: anio,
                    valor: valor
                },
                success: function(msg){
                    if(msg == 'ok'){
                        log("Valor guardado correctamente","success");
                        setTimeout(function () {
                            cargarTablaComponentes(${convenio?.id}, $("#plazo option:selected").val());
                        }, 800);
                    }else{
                        log("Error al guardar el valor","error")
                    }
                }
            })



        }



    });

</script>