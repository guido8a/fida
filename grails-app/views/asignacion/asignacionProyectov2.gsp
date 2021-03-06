<%@ page import="parametros.Anio" %>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Asignaciones del proyecto: ${proyecto}</title>

    <style type="text/css">

    </style>
</head>

<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link class="btn btn-info btn-sm " controller="asignacion" action="programacionAsignacionesInversion" params="[id: proyecto.id, anio: actual.id]">
            <i class="fa fa-calendar"></i> Programación
        </g:link>
    %{--
            <g:link class="btn btn-default btn-sm" controller="asignacion" action="agregarAsignacionInv" id="${proyecto?.id}">
                <i class="fa fa-plus"></i> Agregar Asignaciones
            </g:link>
    --}%
        <a class="btn btn-default btn-sm" id="btnReporteAsignaciones">
            <i class="fa fa-print"></i> Reporte Asignaciones
        </a>
%{--        <a class="btn btn-default btn-sm" id="reporte2">--}%
%{--            <i class="fa fa-print"></i> Reporte Asignaciones planificado--}%
%{--        </a>--}%
    %{--<g:link class="btn btn-default btn-sm" controller="asignacion" action="asignacionProyectoUnidad" id="${proyecto?.id}">Reporte Unidad</g:link>--}%
        <g:if test="${actual?.estado == 1}">
        %{--<g:if test="${proyecto.aprobadoPoa == 'S'}">--}%
        %{--<g:link class="btn btn-default btn-sm" controller="modificacionesPoa" action="ajuste" id="${proyecto?.id}">--}%
        %{--<i class="fa fa-random"></i> Modificaciones--}%
        %{--</g:link>--}%
        %{--</g:if>--}%
        </g:if>
        <g:if test="${actual?.estado == 1}">
            <g:if test="${proyecto.aprobadoPoa != 'S'}">
                <a href="#" id="aprobPrio" class="btn btn-default btn-sm">
                    <i class="fa fa-check"></i> Aprobar Priorización
                </a>
            </g:if>
        </g:if>
        <a href="#" class="btn btn-default btn-sm" id="btn-filtros">
            <i class="fa fa-toggle-on"></i> Filtros
        </a>

        <div style="margin-left: 15px;display: inline-block;">
            <b style="font-size: 11px">Año:</b>
            <g:select from="${parametros.Anio.list([sort: 'anio'])}" id="anio_asg" name="anio" optionKey="id" optionValue="anio" value="${actual?.id}"
                      style="font-size: 11px;width: 80px;display: inline" class="form-control"/>

        </div>
    </div>
</div>

<div style="position: absolute;top:60px;right:380px;font-size: 11px;" class="text-info">
    <div style="top:5px;right:10px;font-size: 11px;">
        <b>Total invertido proyecto actual:</b>
        <span id="spTotInv">
            <g:if test="${actual?.estado == 0}">
                <util:formatNumber number="${proyecto?.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
            </g:if>
            <g:else>
                <util:formatNumber number="${totalP}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
            </g:else>
        </span>
    </div>
    <div style="top:20px;right:10px;font-size: 11px;">
        <b>Máximo Inversiones:</b>
        <span id="spMaxInv">
            <util:formatNumber number="${maxInv}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
        </span>
    </div>

    <div style="top:35px;right:10px;font-size: 11px;">
        <b>Total priorizado:</b>
        <span id="spTotPrio">
            <util:formatNumber number="${priorizado}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
        </span>
    </div>
    <div style="top:50px;right:10px;font-size: 11px;">
        <b>Restante:</b>
        <span id="spRestante">
            <util:formatNumber number="${maxInv - priorizado}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
        </span>
    </div>
</div>


<div class="panel-primary " style="font-size: 14px; margin-bottom: 5px; text-align: center; margin-top: 15px">
    <strong style="color: #5596ff; "> ${proyecto?.toStringCompleto()}, para el año ${actual}</strong>
</div>


%{--<elm:container tipo="vertical" titulo="Asignaciones del proyecto: ${proyecto?.toStringLargo()}, para el año ${actual}" color="black">--}%
<elm:container tipo="vertical" titulo="Asignaciones del proyecto" color="black">

    <table style="font-size: 11px" class="table table-condensed table-bordered table-striped" id="tblAsignaciones">
        <thead>
        <tr style="width: 400px">
            <th>Proyecto</th>
            <th style="">Componente</th>
            <th>#</th>
            <th style="">Actividad</th>
            <th style="">Unidad Ejecutora</th>
            <th style="width: 60px;">Partida</th>
            <th>Planificado</th>
            <g:if test="${actual?.estado == 1}">
                <th>Priorizado inicial</th>
                <th>Priorizado</th>
            </g:if>
            <th></th>
        </tr>
        </thead>

        <tbody>
        <g:set var="total" value="${0}"/>
        <g:set var="totalP" value="${0}"/>
        <g:set var="totalO" value="${0}"/>
        <g:each in="${asignaciones}" var="asg" status="i">
            <g:if test="${asg.planificado > 0}">
                <g:if test="${actual?.estado == 0}">
                %{--                        <g:set var="total" value="${total.toDouble() + asg.getValorReal()}"/>--}%
                    <g:set var="total" value="${total.toDouble() + (asg?.planificado ?: 0)}"/>
                </g:if>
                <g:else>
                %{--                        <g:set var="total" value="${total.toDouble() + asg.getValorReal()}"/>--}%
                    <g:set var="total" value="${total.toDouble() + (asg?.planificado ?: 0)}"/>
                    <g:set var="totalP" value="${totalP.toDouble() + asg.priorizado}"/>
                    <g:set var="totalO" value="${totalO.toDouble() + asg.priorizadoOriginal}"/>
                </g:else>
            </g:if>
            <tr>
                <td class="">
                    ${asg.marcoLogico.proyecto}
                </td>
                <td class=""
                    title="${asg.marcoLogico.marcoLogico.toStringCompleto()}">${asg.marcoLogico.marcoLogico}
                </td>
                <td>
                    ${asg.marcoLogico.numero}
                </td>
                <td class="" title="${asg.marcoLogico.toStringCompleto()}">
                    ${asg.marcoLogico}
                </td>
                <td>
                    ${asg.unidad}
                </td>
                <td title="${asg.presupuesto.descripcion}">
                    ${asg.presupuesto.numero}
                </td>
                <td class="valor" style="text-align: right">
                    <g:formatNumber number="${asg?.planificado?.toDouble()}" type="currency" currencySymbol=""/>
                </td>
                <g:if test="${actual.estado == 1}">
                    <g:if test="${proyecto.aprobadoPoa != 'S'}">
                        <td class="valor">
                            <div class="input-group input-group-sm" style="width: 160px">
                                <input type="text" name="prio_${asg.id}" class="form-control txt-prio  number money" style="text-align: right;" id="prio_${asg.id}" value="${asg.priorizado}">
                                <span class="input-group-btn">
                                    <a href="#prio_${asg.id}" class="savePrio btn btn-info " iden="${asg.id}" title="Guardar">
                                        <i class="fa fa-floppy-o"></i>
                                    </a>
                                </span>
                            </div><!-- /input-group -->
                        </td>
                    </g:if><g:else>
                    <td class="valor" style="text-align: right">
                        <g:formatNumber number="${asg.priorizadoOriginal.toDouble()}" type="currency" currencySymbol=""/>
                    </td>
                    <td class="valor" style="text-align: right">
                        <g:formatNumber number="${asg.priorizado.toDouble()}" type="currency" currencySymbol=""/>
                    </td>
                </g:else>
                </g:if>
                <td class="agr" style="text-align: center">
                    <g:if test="${actual.estado == 0}">
                        <a href="#" class="btn btn-default btn-xs btn_agregar" asgn="${asg.id}" proy="${proyecto.id}"
                           anio="${actual.id}" title="Dividir en dos partidas">
                            <span class="glyphicon glyphicon-resize-full" aria-hidden="true"></span>

                        </a>
                        <g:if test="${asg.padre != null}">
                            <a href="#" class=" btn btn-danger btn-xs  btn_borrar" asgn="${asg.id}" title="Eliminar la Asignación">
                                <span class="glyphicon glyphicon-trash" aria-hidden="true"></span>
                            </a>
                        </g:if>
                    </g:if>
                    <g:else>
                    </g:else>
                </td>
            </tr>
        </g:each>
        </tbody>
        <tfoot>
        <tr>
            <td colspan="5"></td>
            <td><b>TOTAL</b></td>

            <td class="valor" style="text-align: right; font-weight: bold;">
                <g:formatNumber number="${total.toDouble()}" type="currency" currencySymbol=""/>
            </td>
            <g:if test="${actual?.estado != 0}">
                <td style="text-align: right; font-weight: bold;" id="totalPrio">
                    <g:formatNumber number="${totalO.toDouble()}" type="currency" currencySymbol=""/>
                </td>
                <td style="text-align: right; font-weight: bold;" id="totalPrio">
                    <g:formatNumber number="${totalP.toDouble()}" type="currency" currencySymbol=""/>
                </td>
            </g:if>
        </tr>
        </tfoot>
    </table>
</elm:container>

<div id="ajx_asgn" style="width:520px;"></div>

<div id="ajx_asgn_prio" style="width:520px;"></div>

%{--
<div style="margin-left: 30px">
    <div style="top:5px;right:10px;font-size: 11px;">
        <b>Total invertido proyecto actual:</b>
        <span id="spTotInv">
            <g:if test="${actual?.estado == 0}">
                <util:formatNumber number="${proyecto?.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
            </g:if>
            <g:else>
                <util:formatNumber number="${totalP}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
            </g:else>
        </span>
    </div>
    <div style="top:20px;right:10px;font-size: 11px;">
        <b>Máximo Inversiones:</b>
        <span id="spMaxInv">
            <util:formatNumber number="${maxInv}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
        </span>
    </div>

    <div style="top:35px;right:10px;font-size: 11px;">
        <b>Total priorizado:</b>
        <span id="spTotPrio">
            <util:formatNumber number="${priorizado}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
        </span>
    </div>
    <div style="top:50px;right:10px;font-size: 11px;">
        <b>Restante:</b>
        <span id="spRestante">
            <util:formatNumber number="${maxInv - priorizado}" format="###,##0" minFractionDigits="2" maxFractionDigits="2" />
        </span>
    </div>
</div>
--}%


<elm:modal titulo="Dividir asignación" id="modal-dividir">
    <div class="modal-body" id="body-dividir"></div>

    <div class="modal-footer">
        <a href="#" class="btn btn-default" data-dismiss="modal">Cerrar</a>
        <a href="#" class="btn btn-primary" id="btn-dividir">Guardar</a>
    </div>
</elm:modal>
<elm:modal titulo="Dividir asignación" id="modal-dividir-prio">
    <div class="modal-body" id="body-dividir-prio"></div>

    <div class="modal-footer">
        <a href="#" class="btn btn-default" data-dismiss="modal">Cerrar</a>
        <a href="#" class="btn btn-primary" id="btn-dividir-prio">Guardar</a>
    </div>
</elm:modal>
<elm:modal titulo="Filtrar las asignaciones" id="modal-filtros">
    <div class="modal-body">
        <div class="row">
            <div class="form-group keeptogether">
                <label class="col-md-2 control-label">
                    Filtro:
                </label>

                <div class="col-md-7">
%{--                    <g:select from="${['Seleccione...', 'Todos', 'Componente', 'Responsable']}" name="filtro" class="form-control input-sm" id="filtro"/>--}%
                    <g:select from="${['Seleccione...', 'Todos', 'Componente']}" name="filtro" class="form-control input-sm" id="filtro"/>
                </div>
            </div>
        </div>

        <div id="filtrados" class="row">
        </div>
    </div>

    <div class="modal-footer">
        <a href="#" class="btn btn-default" data-dismiss="modal">Cerrar</a>
    </div>

</elm:modal>
<script type="text/javascript">

    function calcularTotal() {
        var total = 0;
        $("#totalPrio").html("0.00");
        $(".txt-prio").each(function () {
            var valor = str_replace(",", "", $(this).val());
            if (isNaN(valor))
                valor = 0;
            var tot = str_replace(",", "", $("#totalPrio").html());
            $("#totalPrio").html(number_format(tot * 1 + valor * 1, 2, ".", ","))
        })
    }

    $("#filtro").change(function () {
        var aniof = $("#anio_asg").val();
        var camp = $("#filtro").val();

        if ($("#filtro").val() != 'Todos') {
            $.ajax({
                type    : "POST",
                url     : "${createLink(action: 'filtro')}",
                data    : "id=${proyecto.id}" + "&anio=" + aniof + "&camp=" + camp,
                success : function (msg) {
                    $("#filtrados").html(msg)
                }
            });
        } else {
            location.href = "${createLink(controller:'asignacion',action:'asignacionProyectov2')}?id=${proyecto.id}&anio=" + aniof
        }
    });

    $("#btn-filtros").click(function () {
        $("#modal-filtros").modal("show")
    });

    $("#aprobPrio").click(function () {
        bootbox.confirm({
                message  : "Esta seguro?. Al aprobar la priorización no podrá realizar modificaciones a las asignaciones",
                title    : "Advertencia",
                class    : "modal-error",
                callback : function (result) {
                    if (result) {
                        openLoader();
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'aprobarPrio', controller: 'asignacion')}",
                            data    : "id=${proyecto.id}",
                            success : function (msg) {
                                if (msg == "ok") {
                                    location.reload(true)
                                }
                            }
                        });
                    }
                }
            }
        );

    });

    $(".savePrio").click(function (e) {
        var id = $(this).attr("iden");

        var monto = $("#prio_" + id).val();
        monto = str_replace(",", "", monto);
        var msg = "";
        if (isNaN(monto)) {
            msg = "El valor de la asignación debe ser un número positivo"
        } else {
            if (monto * 1 < 0) {
                msg = "El valor de la asignación debe ser un número positivo1"
            }
        }
        if (msg == "") {
            $.ajax({
                type    : "POST", url : "${createLink(action:'guardarPrio', controller: 'asignacion')}",
                data    : "id=" + id + "&prio=" + monto,
                success : function (msg) {
                    if (msg == "ok") {
                        log("Datos guardados.", "success");
                        calcularTotal()
                    }
                }
            });
        } else {
            bootbox.alert({
                    message : msg,
                    title   : "Error",
                    class   : "modal-error"
                }
            );
        }

        e.preventDefault();
    });

    $("#anio_asg").change(function () {
        location.href = "${createLink(controller:'asignacion',action:'asignacionProyectov2')}?id=${proyecto.id}&anio=" + $(this).val()
    });
    $(".btn_agregar").click(function () {
        $.ajax({
            type    : "POST",
             url : "${createLink(controller: 'asignacion', action:'agregaAsignacion')}",
            data    : "id=" + $(this).attr("asgn") + "&proy=" + $(this).attr("proy") + "&anio=" + $(this).attr("anio"),
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgDividir",
                    title : "Dividir en dos partidas",
                    class : "modal-md",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        guardar  : {
                            id        : "btnSave",
                            label     : "<i class='fa fa-save'></i> Guardar",
                            className : "btn-success",
                            callback  : function () {
                                guardarDivisionPartida()
                                return false;
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                // $("#body-dividir").html(msg)
            }
        });
        // $('#modal-dividir').modal("show")
    });

    $(".btn_agregar_prio").click(function () {
        $.ajax({
            type    : "POST", url : "${createLink(action:'agregaAsignacionPrio', controller: 'asignacion')}",
            data    : "id=" + $(this).attr("asgn") + "&proy=" + $(this).attr("proy") + "&anio=" + $(this).attr("anio"),
            success : function (msg) {
                $("#body-dividir-prio").html(msg)
            }
        });
        $('#modal-dividir-prio').modal("show")

    });

    $(".btn_borrar").click(function () {
        var boton = $(this);
        bootbox.confirm({
                message  : "Al eliminar esta asignación su valor se sumará a su asignación original y\n la programación deberá revisarse. La asignación no se eliminara si tiene distribuciones derivadas",
                title    : "Advertencia",
                class    : "modal-error",
                callback : function (result) {
                    if (result) {
                        openLoader();
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'borrarAsignacion', controller: 'asignacion')}",
                            data    : "id=" + boton.attr("asgn"),
                            success : function (msg) {
                                closeLoader()
                                if (msg == "ok")
                                    location.reload(true);
                                else {
                                    bootbox.alert({
                                            message : "Error al eliminar la asignación. Asegurese que no tenga distribuciones ni asignaciones hijas",
                                            title   : "Error",
                                            class   : "modal-error"
                                        }
                                    );
                                }

                            }
                        });
                    }

                }
            }
        );

    });
    $(".btn_borrar_prio").click(function () {
        var boton = $(this);
        bootbox.confirm({
                message  : "Al eliminar esta asignación su valor se sumará a su asignación original y\n la programación deberá revisarse. La asignación no se eliminara si tiene distribuciones derivadas",
                title    : "Advertencia",
                class    : "modal-error",
                callback : function (result) {
                    if (result) {
                        openLoader();
                        $.ajax({
                            type    : "POST",
                            url     : "${createLink(action:'borrarAsignacionPrio', controller: 'asignacion')}",
                            data    : "id=" + boton.attr("asgn"),
                            success : function (msg) {
                                closeLoader()
                                if (msg == "ok")
                                    location.reload(true);
                                else {
                                    bootbox.alert({
                                            message : "Error al eliminar la asignación. Asegurese que no tenga distribuciones ni asignaciones hijas",
                                            title   : "Error",
                                            class   : "modal-error"
                                        }
                                    );
                                }

                            }
                        });
                    }

                }
            }
        );
    });

    // $("#btn-dividir").click(function () {
        function guardarDivisionPartida() {
            if ($(".frmAsignacion").valid()) {
                var asgn = $('#padre').val();
                var mxmo = parseFloat($('#maximo').val());
                var valor = str_replace(",", "", $('#vlor').val());
                valor = parseFloat(valor);
                if (valor > mxmo) {
                    bootbox.alert({
                            message: "La nueva asignación debe ser menor a " + number_format(mxmo, 2, ".", ","),
                            title: "Error",
                            class: "modal-error"
                        }
                    );
                } else {
                    // var partida = $('#prsp').val();
                    var partida = $('#partida1').val();
                    var fuente = $('#fuente').val();
                    $.ajax({
                        type: "POST",
                        url: "${createLink(controller: 'asignacion', action:'creaHijo')}",
                        data: "id=" + asgn + "&fuente=" + fuente + "&partida=" + partida + "&valor=" + valor,
                        success: function (msg) {
                            location.reload(true);
                        }
                    });
                }
            }
        }
    // });

    $("#btn-dividir-prio").click(function () {
        if ($(".frmAsignacionPrio").valid()) {
            var asgn = $('#padre').val();
            var mxmo = parseFloat($('#maximo').val());
            var valor = str_replace(",", "", $('#vlor').val());
            valor = parseFloat(valor);
            if (valor > mxmo) {
                bootbox.alert({
                        message : "La nueva asignación debe ser menor a " + number_format(mxmo, 2, ".", ","),
                        title   : "Error",
                        class   : "modal-error"
                    }
                );
            } else {
                var partida = $('#prsp').val();
                var fuente = $('#fuente').val();
                openLoader();
                $.ajax({
                    type    : "POST", url : "${createLink(action:'creaHijoPrio', controller: 'asignacion')}",
                    data    : "id=" + asgn + "&fuente=" + fuente + "&partida=" + partida + "&valor=" + valor,
                    success : function (msg) {
                        closeLoader();
                        location.reload(true);

                    }
                });
            }
        }

    });

    $("#reporte").click(function () {
        var anio = $("#anio_asg").val();
        var url = "${createLink(controller: 'reportes2', action: 'reporteAsignacionProyecto')}?id=" + ${proyecto?.id} +"Wanio=" + anio;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename='Reporte_asignaciones.pdf'";
    });
    $("#reporte2").click(function () {
        var anio = $("#anio_asg").val();
        var url = "${createLink(controller: 'reportes2', action: 'reporteAsignacionProyecto2')}?id=" + ${proyecto?.id} +"Wanio=" + anio;
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename='Reporte_asignaciones_planificado.pdf'";
    });

    $("#btnReporteAsignaciones").click(function () {
        var anio = $("#anio_asg").val();
        location.href="${createLink(controller: 'reportes', action: 'reporteAsignaciones')}?id=" + '${proyecto?.id}' + "&anio=" + anio;
    });

</script>
</body>
</html>