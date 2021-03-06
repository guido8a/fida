<html>
<head>
    <meta name="layout" content="main">
    <title>Procesar solicitud de reforma</title>

    <asset:javascript src="/ckeditor/ckeditor.js"/>

    <style type="text/css">
    .horizontal-container {
        border-bottom : none;
    }

    .table {
        margin-top : 15px;
    }

    .rowC {
        background-color: #dd8404;
    }

    .rowD {
        background-color: #a47680;
    }
    </style>
</head>

<g:set var="btnSelect" value="${tipo == 'I' || tipo == 'C'}"/>
<g:set var="editable" value="${tipo == 'A' || tipo == 'C'}"/>

<body>
<g:hiddenField name="anio" value="${reforma.anioId}"/>
<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link action="pendientes" class="btn btn-default">
            <i class="fa fa-arrow-left"></i> Reformas pendientes
        </g:link>
    </div>
</div>

<g:if test="${reforma && reforma.estado.codigo == "D03"}">
    <div class="alert alert-warning">
        <g:if test="${reforma.firma1.observaciones && reforma.firma1.observaciones != '' && reforma.firma1.observaciones != 'S'}">
            <h4>Devuelto por ${reforma.firma1.usuario}</h4>
            ${reforma.firma1.observaciones}
        </g:if>
%{--        <g:if test="${reforma.firma2.observaciones && reforma.firma2.observaciones != '' && reforma.firma2.observaciones != 'S'}">--}%
%{--            <h4>Devuelto por ${reforma.firma2.usuario}</h4>--}%
%{--            ${reforma.firma2.observaciones}--}%
%{--        </g:if>--}%
    </div>
</g:if>

<div class="panel-primary col-md-12" style="text-align: center; font-size: 16px; margin-bottom: 15px">
    <strong> Solicitud de reforma a procesar: </strong> <strong style="color: #5596ff; "> ${elm.tipoReforma(reforma: reforma)}</strong>
</div>

<elm:container tipo="vertical" titulo="Solicitud de reforma a procesar">
    <div class="row">
        <div class="col-md-1 show-label">
            POA Año
        </div>

        <div class="col-md-1">
            ${reforma.anio.anio}
        </div>

        <div class="col-md-1 show-label">
            Total
        </div>

        <div class="col-md-2" id="divTotal">
            <g:formatNumber number="${total}" type="currency"/>
        </div>

        <g:if test="${btnSelect}">
            <div class="col-md-1 show-label">
                Saldo
            </div>

            <div class="col-md-2" id="divTotal">
                <g:formatNumber number="${totalSaldo}" type="currency"/>
            </div>
        </g:if>

        <div class="col-md-1 show-label">
            Fecha
        </div>

        <div class="col-md-2">
            <g:formatDate date="${reforma.fecha}" format="dd-MM-yyyy"/>
        </div>
    </div>

    <div class="row">
        <div class="col-md-1 show-label">
            Concepto
        </div>

        <div class="col-md-6">
            ${reforma.concepto}
        </div>

        <g:if test="${reforma?.tipoSolicitud == 'X'}">
            <div class="col-md-5">
                <div class="btn-group" role="group" style="float: right">
                    <a href="#" id="btnAsignacion" class="btn btn-info">
                        <i class="fa fa-plus"></i> Asignación Origen
                    </a>
                </div>
            </div>
        </g:if>
    </div>

    <g:set var="totalOrigen" value="${0}"/>
    <g:set var="disminucion" value="${0}"/>
    <g:set var="incremento" value="${0}"/>
    <g:set var="montoFinal" value="${0}"/>

    <g:if test="${reforma?.tipoSolicitud == 'X'}">

        <table class="table table-hover table-condensed table-hover table-bordered">
            <thead>
            <tr>
                <th style="width:4%;">Año</th>
                %{--                <th style="width:15%;">Proyecto</th>--}%
                <th style="width:15%;">Componente</th>
                <th style="width:14%;">Actividad</th>
                <th style="width:8%;">Partida</th>
                %{--                <th style="width:8%;">Responsable</th>--}%
                <th style="width:8%;">Valor inicial<br/>USD</th>
                <th style="width:8%;">Disminución<br/>USD</th>
                <th style="width:9%;">Aumento<br/>USD</th>
                <th style="width:8%;">Valor final<br/>USD</th>
                <th style="width:3%;"></th>
            </tr>
            </thead>
            <tbody>
            <g:each in="${detallesX}" var="det" >

                <g:if test="${det?.tipoReforma?.codigo == 'O'}">
                    <tr class="info" data-id="${det?.id}" id="detr" data-cod="${det?.tipoReforma?.codigo}" data-par="${det?.asignacionOrigen?.id}" data-val="${det?.valor}" data-anio="${det?.anio?.id}">
                        <td style=width:4%>${det?.anio}</td>
                        %{--                        <td style=width:15%>${det?.componente?.proyecto?.nombre}</td>--}%
                        <td style=width:16%>${det?.componente?.objeto}</td>
                        <td style=width:15%>${det?.asignacionOrigen?.marcoLogico?.objeto}</td>
                        <td style='width:7%' class='text-center'>${det?.asignacionOrigen?.presupuesto?.numero}</td>
                        %{--                        <td style='width:8%' class='text-center'>${det?.responsable?.codigo}</td>--}%
                        <td style='width:8%' class='text-right'><g:formatNumber number="${det?.valorOrigenInicial}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                        <td style='width:9%' class='text-right'><g:formatNumber number="${det?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                        <td style='width:9%' class='text-center'>${' --- '}</td>
                        <td style='width:8%' class='text-right'><g:formatNumber number="${det?.valorOrigenInicial - det?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                        <td style=width:6%>
                            <a href='#' class='btn btn-danger btn-xs pull-right borrarTr' title="Borrar"><i class='fa fa-trash'></i></a>
                            <a href='#' class='btn btn-success btn-xs pull-right editarTr' title="Editar"><i class='fa fa-edit'></i></a>
                        </td>
                    </tr>
                    <g:set var="disminucion" value="${disminucion += det?.valor}"/>
                    <g:set var="montoFinal" value="${montoFinal += (det?.valorOrigenInicial - det?.valor)}"/>
                </g:if>
                <g:if test="${det?.tipoReforma?.codigo == 'E' || det?.tipoReforma?.codigo == 'P' }">
                    <g:if test="${det?.tipoReforma?.codigo == 'E'}">
                        <tr class="success" data-id="${det?.id}" id="detr" data-cod="${det?.tipoReforma?.codigo}" data-par="${det?.asignacionOrigen?.presupuesto?.id}" data-anio="${det?.anio?.id}">
                    </g:if>
                    <g:else>
                        <tr class="rowC" data-id="${det?.id}" id="detr" data-cod="${det?.tipoReforma?.codigo}" data-par="${det?.asignacionOrigen?.presupuesto?.id}" data-anio="${det?.anio?.id}">
                    </g:else>
                    <td style=width:4%>${det?.anio}</td>
                %{--                    <td style=width:15%>${det?.componente?.proyecto?.nombre}</td>--}%
                    <g:if test="${det?.tipoReforma?.codigo == 'P'}">
                        <td style=width:16%>${det?.componente?.marcoLogico?.objeto}</td>
                        <td style=width:15%>${det?.componente?.objeto}</td>
                    </g:if>
                    <g:else>
                        <td style=width:16%>${det?.componente?.objeto}</td>
                        <td style=width:15%>${det?.asignacionOrigen?.marcoLogico?.objeto}</td>
                    </g:else>
                    <g:if test="${det?.tipoReforma?.codigo == 'P'}">
                        <td style='width:8%' class='text-center'>${det?.presupuesto?.numero}</td>
                    </g:if>
                    <g:else>
                        <td style='width:8%' class='text-center'>${det?.asignacionOrigen?.presupuesto?.numero}</td>
                    </g:else>
                %{--                    <td style='width:8%' class='text-center'>${det?.responsable?.codigo}</td>--}%
                    <td style='width:8%' class='text-right'><g:formatNumber number="${det?.valorDestinoInicial}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                    <td style='width:9%' class='text-center'>${' --- '}</td>
                    <td style='width:9%' class='text-right'><g:formatNumber number="${det?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                    <td style='width:8%' class='text-right'><g:formatNumber number="${det?.valorDestinoInicial + det?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                    <td></td>
                    </tr>
                    <g:set var="incremento" value="${incremento += det?.valor}"/>
                    <g:set var="montoFinal" value="${montoFinal += (det?.valorDestinoInicial + det?.valor)}"/>
                </g:if>
                <g:if test="${det?.tipoReforma?.codigo == 'A'}" >
                    <tr class="rowD" data-id="${det?.id}" id="detr" data-cod="${det?.tipoReforma?.codigo}" data-par="${det?.asignacionOrigen?.presupuesto?.id}" data-anio="${det?.anio?.id}">
                        <td style=width:4%>${det?.anio}</td>
                        %{--                        <td style=width:15%>${det?.componente?.proyecto?.nombre}</td>--}%
                        <td style=width:16%>${det?.componente?.objeto}</td>
                        <td style=width:15%>${det?.descripcionNuevaActividad}</td>
                        <td style='width:8%' class='text-center'>${det?.presupuesto?.numero}</td>
                        %{--                        <td style='width:8%' class='text-center'>${det?.responsable?.codigo}</td>--}%
                        <td style='width:8%' class='text-center'>${' --- '}</td>
                        <td style='width:9%' class='text-center'>${' --- '}</td>
                        <td style='width:9%' class='text-right'><g:formatNumber number="${det?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                        <td style='width:8%' class='text-right'><g:formatNumber number="${det?.valor}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></td>
                        <td></td>
                    </tr>
                    <g:set var="incremento" value="${incremento += det?.valor}"/>
                    <g:set var="montoFinal" value="${montoFinal += det?.valor}"/>
                </g:if>
                <g:else>
                </g:else>
                <g:set var="totalOrigen" value="${totalOrigen += (det?.valorDestinoInicial + det?.valorOrigenInicial)}"/>
            </g:each>
            </tbody>
        </table>
        <table class="table table-bordered table-hover table-condensed" style="margin-top: 10px;">
            <thead>
            <tr>
                <th style="width: 42%;">TOTAL: </th>
                <th style="width: 8%;"><g:formatNumber number="${totalOrigen}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                <th style="width: 9%;"><g:formatNumber number="${disminucion}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                <th style="width: 8%;"><g:formatNumber number="${incremento}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                <g:if test="${totalOrigen != montoFinal}">
                    <g:if test="${detallesX?.tipoReforma?.codigo?.contains("E") || detallesX?.tipoReforma?.codigo?.contains("A") }">
                        <th style="width: 8%;"><g:formatNumber number="${montoFinal}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                    </g:if>
                    <g:else>
                        <th style="width: 8%; color: #ff180a"><g:formatNumber number="${montoFinal}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                    </g:else>
                </g:if>
                <g:else>
                    <th style="width: 8%;"><g:formatNumber number="${montoFinal}" maxFractionDigits="2" minFractionDigits="2" format="##,###"/></th>
                </g:else>
                <th th style="width: 6%"></th>
            </tr>
            </thead>
        </table>

    </g:if>
    <g:else>
%{--        <g:if test="${btnSelect}">--}%
%{--            <g:render template="/reportesReformaTemplates/tablaSolicitud"--}%
%{--                      model="[det: det2, tipo: tipo, btnSelect: btnSelect, btnDelete: false, editable: editable]"/>--}%
%{--            <g:if test="${detallado.size() > 0}">--}%
%{--                <g:render template="/reportesReformaTemplates/tablaSolicitud"--}%
%{--                          model="[det: detallado, tipo: tipo, btnSelect: false, btnDelete: btnSelect, editable: editable]"/>--}%
%{--            </g:if>--}%
%{--        </g:if>--}%
%{--        <g:else>--}%
%{--            <g:render template="/reportesReformaTemplates/tablaSolicitud"--}%
%{--                      model="[det: det, tipo: tipo, btnSelect: false, btnDelete: false, editable: editable]"/>--}%
%{--        </g:else>--}%
    </g:else>

</elm:container>

<form id="frmFirmas">
    <elm:container tipo="vertical" titulo="Observaciones">
        <div class="row">
            <div class="col-md-1 show-label">Observaciones</div>
            <div class="col-md-5">
                <g:textArea name='editor1' id="nota" class="form-class" style="resize: none; width: 100%; height: 150px">${reforma?.nota}</g:textArea>
            </div>
        <div class="col-md-2">
            <div class="btn-group">
                <a href="#" class="btn btn-success" id="btnGuardar">
                    <i class="fa fa-save"></i> Guardar texto
                </a>
            </div>
        </div>


%{--        <div class="row">--}%
%{--            <div class="col-md-11">--}%
%{--                <textarea name='editor1' id="nota" class="editor">${reforma?.nota}</textarea>--}%
%{--            </div>--}%
%{--        </div>--}%

%{--        <div class="row">--}%
%{--            <div class="btn-toolbar toolbar" style="margin-top: 5px; margin-left: 10px">--}%
%{--                <div class="btn-group">--}%
%{--                    <a href="#" class="btn btn-success" id="btnGuardar">--}%
%{--                        <i class="fa fa-save"></i> Guardar texto--}%
%{--                    </a>--}%
%{--                </div>--}%
%{--            </div>--}%
        </div>
    </elm:container>

    <elm:container tipo="vertical" titulo="Firmas">
        <div class="row">
            <div class="col-md-3 grupo">
                <g:if test="${reforma.estado.codigo == "D02"}">
                    ${reforma.firma1.usuario}
                </g:if>
                <g:else>
                    <g:select from="${personas}" optionKey="id" optionValue="${{
                        it.nombre + ' ' + it.apellido
                    }}" noSelection="['': '- Seleccione -']" name="firma1" class="form-control required input-sm"/>
                </g:else>
            </div>

            <div class="col-md-3 grupo">
                %{--                <g:if test="${reforma.estado.codigo == "D02"}">--}%
                %{--                    ${reforma.firma2.usuario}--}%
                %{--                </g:if>--}%
                %{--                <g:else>--}%
                %{--                    <g:select from="${gerentes}" optionKey="id" optionValue="${{--}%
                %{--                        it.nombre + ' ' + it.apellido--}%
                %{--                    }}" noSelection="['': '- Seleccione -']" name="firma2" class="form-control required input-sm"/>--}%
                %{--                </g:else>--}%
            </div>
            <div class="col-md-6" >
                <div class="btn-group" role="group" aria-label="..." style="float: right">
                    <elm:linkPdfReforma reforma="${reforma}" preview="${true}" class="btn-default" title="Previsualizar" label="true"/>
                    <a href="#" id="btnAprobar" class="btn btn-success ${btnSelect && totalSaldo > 0 ? 'disabled' : ''}" title="Aprobar y solicitar firmas">
                        <i class="fa fa-paper-plane"></i> Solicitar firmas
                    </a>
                    <a href="#" id="btnNegar" class="btn btn-danger" title="Negar definitivamente la solicitud de reforma">
                        <i class="fa fa-thumbs-down"></i> Negar
                    </a>
                </div>
            </div>
        </div>
    </elm:container>
</form>

<script type="text/javascript">

    // CKEDITOR.replace( 'editor1', {
    //     height                  : 150,
    //     width                   : 1000,
    //     resize_enabled          : false,
    //     language: 'es',
    //     uiColor: '#9AB8F3',
    //     extraPlugins: 'entities',
    //     toolbar                 : [
    //         ['FontSize', 'Scayt', '-', 'Cut', 'Copy', 'Paste', 'PasteText', 'PasteFromWord', '-', 'Undo', 'Redo'],
    //         ['Bold', 'Italic', 'Underline','Subscript', 'Superscript'],
    //         ['NumberedList', 'BulletedList', '-', 'Outdent', 'Indent', '-', 'JustifyLeft', 'JustifyCenter', 'JustifyRight', 'JustifyBlock', '-']
    //     ]
    // });

    $(".borrarTr").click(function () {

        var detalleId = $(this).parent().parent().data("id");

        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> Está seguro de borrar este detalle?", function (res) {
            if(res){
                $.ajax({
                    type: 'POST',
                    url: "${createLink(controller: 'reforma', action: 'borrarDetalle')}",
                    data:{
                        detalle: detalleId
                    },
                    success: function (msg){
                        if(msg == 'ok'){
                            log("Detalle borrado correctamente!","success");
                            setTimeout(function () {
                                location.href = "${createLink(controller:'reforma',action:'procesar')}/" + '${reforma?.id}';
                            }, 500);
                        }else{
                            log("Error al borrar el detalle!","error");
                        }
                    }
                });
            }
        });
    });

    $(".editarTr").click(function () {
        var detalleId = $(this).parent().parent().data("id");
        var codigoDt = $(this).parent().parent().data("cod");
        var detalleAnio = $(this).parent().parent().data("anio");

        if(codigoDt == 'O'){
            $.ajax({
                type: 'POST',
                url     : "${createLink(controller: 'reforma', action: 'anio_ajax')}",
                data : {
                    id: detalleId,
                    anio: detalleAnio
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id    : "dlgOrigen",
                        title : '<h3 class="text-info">Asignación de Origen</h3>',
                        class : "modal-lg",
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            aceptar : {
                                label     : "<i class='fa fa-save'></i> Aceptar",
                                className : "btn-success",
                                callback  : function () {
                                    if($("#frmAsignacion").valid()){
                                        var dataOrigen = {};
                                        dataOrigen.monto = str_replace(",", "", $("#monto").val());
                                        var dataDestino = {};
                                        dataDestino.proyecto_nombre = $("#proyecto").find("option:selected").text();
                                        dataDestino.componente_nombre = $("#comp").find("option:selected").text();
                                        dataDestino.componente_id = $("#comp").val();
                                        dataDestino.actividad_nombre = $("#actividadRf").find("option:selected").text();
                                        dataDestino.actividad_id = $("#actividadRf").val();
                                        dataDestino.asignacion_nombre = $("#asignacion").find("option:selected").text();
                                        var part = $("#asignacion").find("option:selected").text().split(": ")
                                        var partid = part[2].split(",")
                                        var ini = part[1].split(", Partida")
                                        dataDestino.partida = partid[0]
                                        dataDestino.inicial = ini[0]
                                        dataDestino.asignacion_id = $("#asignacion").val();
//                                                resetForm();

                                        //grabar detalle reforma
                                        $.ajax({
                                            type: 'POST',
                                            url: "${createLink(controller: 'reforma', action: 'grabarDetalleA')}",
                                            data:{
                                                monto: dataOrigen.monto,
                                                componente: dataDestino.componente_id,
                                                actividad: dataDestino.actividad_id,
                                                asignacion: dataDestino.asignacion_id,
                                                tipoReforma: "O",
                                                reforma: '${reforma?.id}',
                                                id: detalleId
                                            },
                                            success: function (msg){
                                                if(msg == 'ok'){
                                                    log("Detalle guardado correctamente!","success");
                                                    setTimeout(function () {
                                                        location.href = "${createLink(controller:'reforma',action:'procesar')}/" + '${reforma?.id}';
                                                    }, 500);
                                                }else{
                                                    log("Error al guardar el detalle!","error");
                                                }
                                            }
                                        });
                                    }
                                    else{
                                        return false;
                                    }

                                }
                            }
                        } //buttons
                    }); //dialog
                }
            });

        }
    });


    //agregar y guardar asignacion de origen

    $("#btnAsignacion").click(function () {
        $.ajax({
            type: 'POST',
            url     : "${createLink(controller: 'reforma', action: 'anio_ajax')}",
            data:{
                anio: ' ${reforma.anio.id}'
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgOrigen",
                    title : '<h3 class="text-info">Asignación de Origen</h3>',
                    class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        },
                        aceptar : {
                            label     : "<i class='fa fa-save'></i> Aceptar",
                            className : "btn-success",
                            callback  : function () {
                                if($("#frmAsignacion").valid()){
                                    var dataOrigen = {};
                                    dataOrigen.monto = str_replace(",", "", $("#monto").val());
                                    var dataDestino = {};
                                    dataDestino.proyecto_nombre = $("#proyecto").find("option:selected").text();
                                    dataDestino.componente_nombre = $("#comp").find("option:selected").text();
                                    dataDestino.componente_id = $("#comp").val();
                                    dataDestino.actividad_nombre = $("#actividadRf").find("option:selected").text();
                                    dataDestino.actividad_id = $("#actividadRf").val();
                                    dataDestino.asignacion_nombre = $("#asignacion").find("option:selected").text();
                                    var part = $("#asignacion").find("option:selected").text().split(": ")
                                    var partid = part[2].split(",")
                                    var ini = part[1].split(", Partida")
                                    dataDestino.partida = partid[0]
                                    dataDestino.inicial = ini[0]
                                    dataDestino.asignacion_id = $("#asignacion").val();

                                    resetForm();

                                    //grabar detalle reforma

                                    $.ajax({
                                        type: 'POST',
                                        url: "${createLink(controller: 'reforma', action: 'grabarDetalleA')}",
                                        data:{
                                            monto: dataOrigen.monto,
                                            componente: dataDestino.componente_id,
                                            actividad: dataDestino.actividad_id,
                                            asignacion: dataDestino.asignacion_id,
                                            tipoReforma: "O",
                                            reforma: '${reforma?.id}',
                                            adicional: "R"
                                        },
                                        success: function (msg){
                                            if(msg == 'ok'){
                                                log("Detalle guardado correctamente!","success");
                                                setTimeout(function () {
                                                    location.href = "${createLink(controller:'reforma',action:'procesar')}/" + '${reforma?.id}';
                                                }, 500);
                                            }else{
                                                log("Error al guardar el detalle!","error");
                                            }
                                        }
                                    });
                                }
                                else{
                                    return false;
                                }
                            }
                        }
                    } //buttons
                }); //dialog
            }
        });
    });

    function resetForm() {
        $("#proyecto").val("-1");
        $("#divComp").html("");
        $("#divAct").html("");
        $("#divAsg").html("");
        $("#monto").val("");
        $("#max").html("");
    }

    function procesar(aprobado, mandar) {
        var url = "${createLink(action:'aprobar')}";
        var str = "Aprobando";
        var str2 = "aprobar";
        var str3 = "Aprobar";
        var clase = "success";
        var ico = "pencil";
        var data = {
            id : "${reforma.id}"
        };
        if (!aprobado) {  //negar
            url = "${createLink(action:'negar')}";
            str = "Negando";
            str2 = "negar";
            str3 = "Negar";
            clase = "danger";
            ico = "thumbs-down";
        } else {
            if (!mandar) {  // solo guarda texto
                url = "${createLink(action:'guardar')}";
                str = "Guardando";
                str2 = "guardar";
                str3 = "Guardar";
                clase = "success";
                ico = "thumbs-save";
            }
            data.firma1 = $("#firma1").val();
            // data.firma2 = $("#firma2").val();
            // data.observaciones = CKEDITOR.instances['nota'].getData();
            data.observaciones = $("#nota").val()
        }

        var $msg = $("<div>");
        var $form = $("<form class='form-horizontal'>");

        var $r2 = $("<div class='form-group'\"'>");
        $r2.append("<label class='col-sm-4 control-label' for='obs'>Autorización</label>");
        var $auth = $("<input type='password' class='form-control required'/>");
        var auth = $("<div class='col-sm-8 grupo'>");
        var authGrp = $("<div class='input-group'>");
        authGrp.append($auth);
        authGrp.append("<span class='input-group-addon'><i class='fa fa-unlock-alt'></i></span>");
        auth.append(authGrp);
        $r2.append(auth);
        $form.append($r2);

        $msg.append($form);

        $form.validate({
            errorClass     : "help-block",
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            }
        });

        var dlg = function () {
            openLoader(str);
            $.ajax({
                type    : "POST",
                url     : url,
                data    : data,
                success : function (msg) {
                    var parts = msg.split("*");
                    // log(parts[1], parts[0]);
                    if (parts[0] == "SUCCESS") {
                        log("Guardado correctamente","success");
                        if (mandar) {
                            location.href = "${createLink(action:'pendientes')}";
                        } else {
                            location.reload(true);
                        }
                    } else {
                        log("Error al guardar","error")
                    }
                }
            });
        };
        if (mandar) {
            bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i>" +
                " ¿Está seguro de querer <strong class='text-" + clase + "'>" + str2 + "</strong> " +
                "esta solicitud de reforma?<br/>Esta acción no puede revertirse.",
                function (res) {
                    if (res) {
                        dlg();
                    }
                });
        } else {
            dlg();
        }
    }

    $(function () {
        %{--$('#richText').ckeditor(function () { /* callback code */--}%
        %{--    },--}%
        %{--    {--}%
        %{--        customConfig : '${resource(dir: 'js/plugins/ckeditor-4.4.6', file: 'config_bullets_only.js')}'--}%
        %{--    });--}%
        $("#frmFirmas").validate({
            errorClass     : "help-block",
            onfocusout     : false,
            errorPlacement : function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success        : function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            }
        });
        $("#btnAprobar").click(function () {

            if($("#frmFirmas").valid()){
                if(${Math.round(disminucion*100)/100} == ${Math.round(incremento*100)/100}){
                    procesar(true, true)
                }else{
                    bootbox.alert("Los valores ingresados no cuadran :" + '</br>' + "Disminución: ${disminucion}" +
                        '</br>' + "Incremento: ${incremento}")
                }
            }else{
                bootbox.alert("Seleccione una persona para firmar")
            }

            return false;
        });
        $("#btnGuardar").click(function () {
            procesar(true, false);     //procesar(aprobado, mandar)
            return false;
        });
        $("#btnNegar").click(function () {
            procesar(false, true);
            return false;
        });

        <g:if test="${editable}">
        $(".txtActividad").blur(function () {
            var input = $(this).val();
            var original = $(this).data("val");
            var $td = $(this).parents("td");
            if (input == original) {
                $td.removeClass("danger");
            } else {
                $td.addClass("danger");
            }
        });
        $(".btnSaveActividad").click(function () {
            var $btn = $(this);
            var $input = $btn.parent().prev();
            var $td = $btn.parents("td");
            var input = $input.val();
            var original = $input.data("val");
            var id = $input.data("id");

            if (input != original) {
                var $button = $btn.button('loading');
                $input.prop("disabled", true);
                $.ajax({
                    type    : "POST",
                    url     : "${createLink(action:'guardarNombreActividad_ajax')}",
                    data    : {
                        id  : id,
                        act : input
                    },
                    success : function (msg) {
                        var parts = msg.split("*");
                        log(parts[1], parts[0]);
                        if (parts[0] == "SUCCESS") {
                            $td.removeClass("danger");
                            $input.data("val", input);
                        }
                        $button.button('reset');
                        $input.prop("disabled", false);
                    }
                });
            }
            return false;
        });
        </g:if>

        <g:if test="${btnSelect}">
        function validarPar(dataOrigen, dataDestino) {
//                    console.log(dataDestino, dataDestino.mrlg, dataDestino.prsp);
            var monto = parseFloat($.trim(str_replace(",", "", $("#monto").val())));
//                    console.log(dataOrigen.monto, monto, dataOrigen.max);
            var ok = true;
            if (monto > dataOrigen.max) {
                ok = false;
                bootbox.alert("No puede seleccionar una asignación cuyo máximo es menor que el valor de la asignación de destino");
            }
            if (ok) {

                $(".tb").children().each(function () {
                    var d = $(this).data();
                    if (ok) {
                        var b1 = false, b2 = false;

                        if (d.aso) {
//                                    console.log(d.aso, dataOrigen.asignacion_id, "compara:", dataDestino.mrlg, "con", d.dtrfmrlg, "y", dataDestino.prsp, "con", d.dtrfprsp);
                            b1 = (d.aso == dataOrigen.asignacion_id) && (d.dtrfmrlg == dataDestino.mrlg) && (d.dtrfprsp == dataDestino.prsp);
                            b2 = d.aso == dataDestino.asignacion_id
                            if (d.asd) {
                                b1 = b1 && d.asd == dataDestino.asignacion_id;
                                b2 = b2 || d.asd == dataOrigen.asignacion_id
                            }
                        } else {
                            if (d.asd) {
//                                        b1 = d.asd == dataDestino.asignacion_id;
                                b2 = d.asd == dataOrigen.asignacion_id
                            }
                        }
                        if (b1) {
                            ok = false;
                            bootbox.alert("No puede seleccionar un par de asignaciones ya ingresados");
                        } else {
                            if (b2) {
                                ok = false;
                                bootbox.alert("No puede seleccionar una asignación de origen que está listada como destino");
                            }
                        }
                    }
                });
            }
            return ok;
        }

        $(".btnDeleteDetalle").click(function () {
            var id = $(this).data("id");
            bootbox.confirm("<i class='fa fa-trash-o fa-3x text-danger'></i> ¿Está seguro de querer eliminar este detalle?", function (res) {
                if (res) {
                    openLoader();
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(action:'eliminarParAsignaciones_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            var parts = msg.split("*");
                            if (parts[0] == "SUCCESS") {
                                log("Detalle borrado correctamente","success")
                                setTimeout(function () {
                                    location.reload(true);
                                }, 1000);
                            } else {
                                log("Error al borrar el detalle","error")                            }
                        }
                    });
                }
            });
            return false;
        });

        $(".btnSelect").click(function () {
            var $btn = $(this);
            var $tr = $btn.parents("tr");
            $.ajax({
                type    : "POST",
                url     : "${createLink(action:'asignarOrigen_ajax')}",
                data    : {
                    id  : "${reforma.id}",
                    det : $btn.data("id")
                },
                success : function (msg) {
                    var b = bootbox.dialog({
                        id      : "dlgCreateEdit",
                        title   : "Asignación de origen",
                        class   : "modal-lg",
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
                                    if ($("#frmReforma").valid()) {
//                                                console.log('mrlg', $btn.data("mrlg"), 'prsp:')
//                                                console.log($btn.data("prsp"))
//                                                var partida = String($btn.data("prsp"));
//                                                var n = partida.indexOf(" ");
//                                                console.log('n', n);
//                                                if(n > 0) {
//                                                    prsp = partida.split(" ")[0]
//                                                }
                                        var dataDestino = {
                                            asignacion_id : $tr.data("asd"),
                                            mrlg : $btn.data("mrlg"),
//                                                    prsp : partida
                                            prsp : String($btn.data("prsp")).split(" ")[0]
                                        };
                                        var dataOrigen = {
                                            monto : $tr.data("saldo")
                                        };
                                        dataOrigen.proyecto_nombre = $("#proyecto").find("option:selected").text();
                                        dataOrigen.componente_nombre = $("#comp").find("option:selected").text();
                                        dataOrigen.actividad_nombre = $("#actividad").find("option:selected").text();
                                        dataOrigen.asignacion_nombre = $("#asignacion").find("option:selected").text();
                                        dataOrigen.asignacion_id = $("#asignacion").val();
                                        dataOrigen.inicial = $("#asignacion").find("option:selected").attr("class");
                                        dataOrigen.max = $("#max").data("max");
                                        if (validarPar(dataOrigen, dataDestino)) {
                                            openLoader();
                                            $.ajax({
                                                type    : "POST",
                                                url     : "${createLink(action:'asignarParAsignaciones_ajax')}",
                                                data    : {
                                                    det : $btn.data("id"),
                                                    asg : $("#asignacion").val(),
                                                    mnt : $("#monto").val()
                                                },
                                                success : function (msg) {
                                                    var parts = msg.split("*");
                                                    if (parts[0] == "SUCCESS") {
                                                        log("Origen asignado correctamente","success")
                                                        setTimeout(function () {
                                                            location.reload(true);
                                                        }, 1000);
                                                    } else {
                                                        log("Errro al asignar el origen","error")
                                                    }
                                                }
                                            });
                                        }
                                    }
                                    return false;
                                } //callback
                            } //guardar
                        } //buttons
                    }); //dialog
                    setTimeout(function () {
                        b.find(".form-control").first().focus()
                    }, 500);
                } //success
            }); //ajax
            return false;
        });
        </g:if>
    });
</script>

</body>
</html>