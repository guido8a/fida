<%@ page import="poa.ProgramacionAsignacion; parametros.Mes; poa.Asignacion; parametros.Anio" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Asignaciones del proyecto: ${proyecto}</title>


    <style type="text/css">
    input{
        font-size: 10px !important;
        margin: 0px;
    }
    </style>
</head>

<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn btn-default btn-sm" controller="asignacion" action="asignacionProyectov2"  params="[id:proyecto.id,anio:actual.id]"><i class="fa fa-arrow-left"></i> Asignaciones</g:link>
        <a class="btn btn-info btn-sm" id="btnReporteAsignacionesCrono">
            <i class="fa fa-print"></i> Reporte Asignaciones
        </a>
        <div style="margin-left: 15px;display: inline-block;">
            <b style="font-size: 11px">Año:</b>
            <g:select from="${parametros.Anio.list([sort:'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual.id}" style="font-size: 11px;width: 150px;display: inline" class="form-control"/>
        </div>
    </div>
</div>

<div class="panel panel-primary " style="text-align: center; font-size: 14px;">
    <strong>PROYECTO: </strong> <strong style="color: #5596ff; "> ${proyecto?.toStringCompleto()}, para el año ${actual}</strong>
</div>


<elm:container tipo="vertical" titulo="Programación de las asignaciones" color="black" >

    <table  class="table table-condensed table-bordered table-striped" style="font-size: 10px;">
        <thead>
        <th style="width: 70px;">Enero</th>
        <th style="width: 70px;">Feb.</th>
        <th style="width: 70px;">Marzo</th>
        <th style="width: 70px;">Abril</th>
        <th style="width: 70px;">Mayo</th>
        <th style="width: 70px;">Junio</th>
        <th style="width: 70px;">Julio</th>
        <th style="width: 70px;">Agos.</th>
        <th style="width: 70px;">Sept.</th>
        <th style="width: 70px;">Oct.</th>
        <th style="width: 70px;">Nov.</th>
        <th style="width: 70px;">Dic.</th>
        <th style="width: 70px;">Total</th>
        <th></th>
        </thead>
        <tbody>
        <g:set var="ene" value="${0}"/>
        <g:set var="feb" value="${0}"/>
        <g:set var="mar" value="${0}"/>
        <g:set var="abr" value="${0}"/>
        <g:set var="may" value="${0}"/>
        <g:set var="jun" value="${0}"/>
        <g:set var="jul" value="${0}"/>
        <g:set var="ago" value="${0}"/>
        <g:set var="sep" value="${0}"/>
        <g:set var="oct" value="${0}"/>
        <g:set var="nov" value="${0}"/>
        <g:set var="dic" value="${0}"/>
        <g:set var="asignado" value="0"/>
        <g:each in="${inversiones}" var="asg" status="i">
            <g:set var="totalFila" value="${0}"/>
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <td colspan="13"><b style="color: #5183e7; font-size: 12px">Asignación#${i+1} -> </b><strong><elm:poneHtml textoHtml="${asg}"/></strong></td>
                <td></td>
            </tr>
            <tr class="${(i % 2) == 0 ? 'odd' : 'even'}">
                <g:each in="${meses}" var="mes" status="j">
                    <g:if test="${poa.ProgramacionAsignacion.findAllByAsignacionAndMes(poa.Asignacion.get(asg.id),parametros.Mes.get(mes.id))?.size()>0}" >
                        <g:set var="progra" value="${poa.ProgramacionAsignacion.findAllByAsignacionAndMes(poa.Asignacion.get(asg.id),parametros.Mes.get(mes.id))?.pop()}"/>
                        <td class="${mes}" style="width: 70px;padding: 0px;height: 30px">
                            <input type="text" class="${j} valor asg_cor_${asg.id} form-control input-sm number"  mes="${mes.id}" value="${progra?.valor}" style="width: 100%;margin: 0px">
                            <g:set var="totalFila" value="${totalFila+=progra.valor}"/>
                            <g:if test="${j==0}">
                                <g:set var="ene" value="${ene.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==1}">
                                <g:set var="feb" value="${feb.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==2}">
                                <g:set var="mar" value="${mar.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==3}">
                                <g:set var="abr" value="${abr.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==4}">
                                <g:set var="may" value="${may.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==5}">
                                <g:set var="jun" value="${jun.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==6}">
                                <g:set var="jul" value="${jul.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==7}">
                                <g:set var="ago" value="${ago.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==8}">
                                <g:set var="sep" value="${sep.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==9}">
                                <g:set var="oct" value="${oct.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==10}">
                                <g:set var="nov" value="${nov.toDouble()+progra?.valor}"/>
                            </g:if>
                            <g:if test="${j==11}">
                                <g:set var="dic" value="${dic.toDouble()+progra?.valor}"/>
                            </g:if>
                        </td>
                    </g:if>
                    <g:else>
                        <td class="${mes}"  style="width: 70px;padding: 0px;height: 30px">
                            <input type="text" class="${mes} valor asg_cor_${asg.id} form-control input-sm number money" mes="${mes.id}"   value="0.00" style="width: 100%;margin: 0px">
                        </td>
                    </g:else>
                </g:each>
                <td class="total" id="total_cor_${asg.id}" style="width: 80px;text-align: right;${(totalFila.toDouble().round(2)!=asg.planificado.toDouble().round(2))?'color:red;':''}padding-top:0px;padding-bottom: 0px;line-height: 30px">
                    <util:formatNumber number="${totalFila}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
                    %{--${totalFila.toDouble().round(2)} -- ${asg.planificado.toDouble().round(2)}--}%
                </td>
                <g:if test="${actual.estado==0}">
                    <td style="width: 50px;text-align: center;padding-top:0px;padding-bottom: 0px">
                        <a href="#" class="btn guardar ajax btn-success btn-sm" asg="${asg.id}"   icono="ico_cor_${i}" max="${asg.planificado}" clase="asg_cor_${asg.id}" total="total_cor_${asg.id}" title="guardar">
                            <i class="fa fa-save"></i>
                        </a>
                    </td>
                </g:if>
            </tr>
        </g:each>
        <tr>
            <td colspan="15"><b>TOTALES</b></td>
        </tr>
        <tr>
            %{--
                        <td style="text-align: center"><util:formatNumber number="${ene}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${feb}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${mar}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${abr}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${may}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${jun}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${jul}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${ago}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${sep}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${oct}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${nov}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${dic}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
                        <td style="text-align: center"><util:formatNumber number="${ene.toDouble()+feb.toDouble()+mar.toDouble()+abr.toDouble()+may.toDouble()+jun.toDouble()+jul.toDouble()+ago.toDouble()+sep.toDouble()+oct.toDouble()+nov.toDouble()+dic.toDouble()}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            --}%

            <td style="text-align: center"><util:formatNumber number="${ene}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${feb}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${mar}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${abr}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${may}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${jun}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${jul}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${ago}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${sep}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${oct}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${nov}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${dic}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
            <td style="text-align: center"><util:formatNumber number="${ene.toDouble()+feb.toDouble()+mar.toDouble()+abr.toDouble()+may.toDouble()+jun.toDouble()+jul.toDouble()+ago.toDouble()+sep.toDouble()+oct.toDouble()+nov.toDouble()+dic.toDouble()}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/></td>
        </tr>
        </tbody>
    </table>
</elm:container>


<script type="text/javascript">

    $("#btnReporteAsignacionesCrono").click(function () {
        var anio = $("#anio_asg").val();
        location.href="${createLink(controller: 'reportes', action: 'reporteAsignacionesExcel')}?id=" + '${proyecto?.id}' + "&anio=" + anio;
    });

    $("#anio_asg").change(function(){
        location.href="${createLink(controller:'asignacion',action:'programacionAsignacionesInversion')}?id=${proyecto.id}&anio="+$(this).val()
    });

    $(".guardar").click(function() {
        var boton = $(this)
        var icono = $("#" + $(this).attr("icono"))
        var total = 0
        var max = $(this).attr("max")*1
        var datos =""
        $.each($("."+$(this).attr("clase")),function(){
            var txto = $(this).val()
            // var val = ""
            // var vl = 0.0
            // var lastIndex = txto.lastIndexOf('.');
            // val = txto.substr(0,lastIndex)
            // val = val.replace(".", "")
            // vl = val + txto.substr(lastIndex, txto.length)
            // vl=vl*1
            vl=txto*1
            // console.log('val', vl, 'ent:', txto.substr(0,lastIndex), 'frac:', txto.substr(lastIndex, txto.length))
            total+= vl
            datos+=$(this).attr("mes")+":"+vl+";"
        });
        total =parseFloat(total).toFixed(2);
        if(total!=max){
            bootbox.alert({
                    message: "El total programado ( " + total + " ) es diferente al monto priorizado: " + max,
                    title :"Error",
                    class : "modal-error"
                }
            );
            $("#"+$(this).attr("total")).html(total).css("color","red").show("pulsate")
        }else{
            $("#"+$(this).attr("total")).html(total).css("color","black");
            $.ajax({
                type: "POST",
                url: "${createLink(controller:'asignacion' ,action:'guardarProgramacion')}",
                data: "asignacion="+boton.attr("asg")+"&datos="+datos ,
                success: function(msg) {
                    if(msg=="ok"){
                        icono.show("pulsate")
                        window.location.reload(true)
                    }
                }
            });
        }

    });


</script>

</body>
</html>