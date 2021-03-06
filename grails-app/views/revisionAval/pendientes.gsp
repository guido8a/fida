<%@ page import="seguridad.Persona; seguridad.UnidadEjecutora; parametros.Anio" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Solicitudes de aval</title>

    %{--    <link rel="stylesheet" href="${resource(dir: 'css/custom', file: 'avales.css')}" type="text/css"/>--}%

    <style>

    .amarillo{
        background-color: #e1a628;
        color: #fdfbff;
    }

    .rojo{
        background-color: #c42623;
        color: #fdfbff;
    }

    .verde{
        background-color:#78b665;
        color: #fdfbff;
    }
    </style>


</head>

<body>

<!-- botones -->

<div class="panel panel-primary col-md-12" role="tabpanel" style="margin-top: 20px; min-height: 300px">

    <h3>Solicitudes y Avales</h3>

    <div class="btn-toolbar toolbar">
        <div class="btn-group">
            <g:link controller="avales" action="nuevaSolicitud" class="btn btn-default">
                <i class="fa fa-file"></i> Nuevo proceso para solicitud de aval
            </g:link>
        </div>
    </div>

    <div role="tabpanel">
        <!-- Nav tabs -->
        <ul class="nav nav-pills" role="tablist">
            <li role="presentation" class="active">
                <a href="#pendientes" aria-controls="home" role="tab" data-toggle="pill">
                    Solicitudes pendientes
                </a>
            </li>
            <li role="presentation">
                <a href="#avales" aria-controls="home" role="tab" data-toggle="pill">
                    Avales pendientes
                </a>
            </li>
            <li role="presentation">
                <a href="#historial" aria-controls="profile" role="tab" data-toggle="pill">
                    Historial solicitudes
                </a>
            </li>
        </ul>

        <!-- Tab panes -->
        <div class="tab-content">
            <div role="tabpanel" class="tab-pane active" id="pendientes">
                <g:if test="${(solicitudes.size() > 0 || procesosSinSolicitud.size() > 0)}">
                    <table class="table table-condensed table-striped table-hover table-bordered" style="margin-top: 20px;">
                        <thead>
                        <tr style="width: 100%">
                            <th style="width: 10%;">Solicitud</th>
                            <th style="width: 10%;">Requirente</th>
                            <th style="width: 10%;">Proceso</th>
                            <th style="width: 10%;">Tipo</th>
                            <th style="width: 10%;">Justificación</th>
                            <th style="width: 10%;">Monto</th>
                            <th style="width: 10%;">Estado</th>
                            <th style="width: 10%;">Doc. Respaldo</th>
                            %{--                            <th style="width: 60px;">Solicitud</th>--}%
                            <th style="width: 10%;">Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${procesosSinSolicitud}" var="p">
                            <g:if test="${session.usuario.unidadEjecutora.codigo == seguridad.Persona.get(p?.usuario?.id).unidadEjecutora.codigo}">
                                <tr>
                                    <td></td>
                                    <td></td>
                                    <td>${p.nombre}</td>
                                    <td></td>
                                    <td></td>
                                    <td></td>
                                    <td>Solicitud pendiente </td>
                                    <td></td>
                                    %{--                                    <td></td>--}%
                                    <td class="text-center">
                                        <div class="btn-group btn-group-xs" role="group">
                                            <a href="${g.createLink(controller: 'avales', action: 'nuevaSolicitud', id: p.id)}" class="aprobar btn btn-success" title="Editar">
                                                <i class="fa fa-edit"></i>
                                            </a>
                                            <a href="#" class="borrarSolicitud btn btn-danger" title="Eliminar solicitud" sol="${p?.id}">
                                                <i class="fa fa-trash"></i>
                                            </a>
                                        </div>
                                    </td>
                                </tr>
                            </g:if>
                        </g:each>
                        <g:each in="${solicitudes}" var="p">
                            <g:set var="title"/>
                            <g:if test="${p.estado.codigo == 'D01'}">
                                <g:set var="title" value="${p.observaciones}"/>
                            </g:if>
                            <g:if test="${p.estado.codigo == 'D02'}">
                                <g:set var="title" value="Devuelto por ${p.firma.usuario}${p.firma.observaciones && p.firma.observaciones != 'S' ? ': ' + p.firma.observaciones : ''}"/>
                            </g:if>
                        %{--<g:if test="${session.usuario.unidad.codigo == p?.unidad?.codigo}">--}%
                            <tr>
                                <td>
                                    ${p.unidad?.codigo}-${p.numero}
                                </td>
                                <td>
                                    ${p.unidad}
                                </td>
                                <td>
                                    ${p.proceso.nombre} ${session.usuario.unidadEjecutora.codigo} ${p?.unidad?.codigo}
                                </td>
                                <td class="${(p.tipo == 'A') ? 'E03' : 'E02'}" style="text-align: center">
                                    ${(p.tipo == "A") ? 'Anulación' : 'Aprobación'}
                                </td>
                                <td>
                                    ${p.concepto}
                                </td>
                                <td class="text-right">
                                    <g:formatNumber number="${p.monto}" type="currency" currencySymbol=""/>
                                </td>
                                <td style="text-align: center" class="text-center ${p.estado?.codigo}" title="${title}">
                                    ${p.estado?.descripcion}
                                    ${p.tipo == "A" ? 'Anulación' : ''}
                                </td>
                                <td class="text-center">
                                    <g:if test="${p.path}">
                                        <a href="#" class="btn btn-info btn-xs descRespaldo" iden="${p.id}" title="Ver">
                                            <i class="fa fa-print"></i>
                                        </a>
                                    </g:if>
                                </td>
                                %{--                                <td class="text-center">--}%

                                %{--                                </td>--}%
                                <td class="text-center">
                                    <div class="btn-group btn-group-xs" role="group">
                                        <a href="${g.createLink(controller: 'avales', action: 'nuevaSolicitud', id: p.proceso.id)}" class="aprobar btn btn-success" title="Editar">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <g:if test="${p.estado.codigo == 'P01' || p.estado.codigo == 'D01'}">
                                            <g:if test="${session.usuario.id == p.usuarioId}">
                                            %{--                                                                                            <g:if test="${p.tipo == 'A'}">--}%
                                            %{--                                                                                                <a href="${g.createLink(controller: 'avales', action: 'solicitarAnulacion', params: [sol: p.id])}" class="aprobar btn btn-danger" title="Anular">--}%
                                            %{--                                                                                                    <i class="fa fa-edit"></i>--}%
                                            %{--                                                                                                </a>--}%
                                            %{--                                                                                            </g:if>--}%
                                            %{--                                                                                            <g:else>--}%
                                            %{--                                                                                                <a href="${g.createLink(controller: 'avales', action: 'nuevaSolicitud', id: p.proceso.id)}" class="aprobar btn btn-success" title="Editar">--}%
                                            %{--                                                                                                    <i class="fa fa-edit"></i>--}%
                                            %{--                                                                                                </a>--}%
                                                <a href="#" class="borrarSolicitud btn btn-danger" title="Eliminar solicitud" sol="${p.proceso.id}">
                                                    <i class="fa fa-trash"></i>
                                                </a>
                                            %{--                                                </g:else>--}%
                                            </g:if>
                                        </g:if>
                                        <g:elseif test="${(p.estado.codigo == 'R01' || p.estado.codigo == 'D02') && session.perfil.codigo == 'ASPL'}">
                                            <g:if test="${p?.tipo == 'A'}">
                                                <a href="${g.createLink(action: 'revisionSolicitud', id: p.id)}" class="aprobar btn btn-danger" title="Revisar solicitud de anulación">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                            </g:if>
                                            <g:else>
                                                <a href="${g.createLink(action: 'revisionSolicitud', id: p.id)}" class="aprobar btn btn-warning" title="Revisar solicitud">
                                                    <i class="fa fa-cog"></i>
                                                </a>
                                            </g:else>
                                        </g:elseif>
                                        <g:elseif test="${p.estado.codigo == 'E01' || p.estado.codigo == 'D03'}">
                                            <g:if test="${session.perfil.codigo == 'ASPL'}">
                                                <g:if test="${p.tipo != 'A'}">
                                                    <a href="${g.createLink(action: 'aprobarAval', id: p.id)}" class="aprobar btn btn-warning" title="Aprobar Aval">
                                                        <i class="fa fa-cog"></i>
                                                    </a>
                                                </g:if>
                                            %{--                                                <g:else>--}%
                                            %{--                                                    <a href="${g.createLink(action: 'aprobarAnulacion', id: p.id)}" class="aprobar btn btn-danger" title="Revisar">--}%
                                            %{--                                                        <i class="fa fa-times"></i>--}%
                                            %{--                                                    </a>--}%
                                            %{--                                                </g:else>--}%
                                            </g:if>
                                        </g:elseif>
                                        <a href="#" class="btn btn-info btn-xs imprimirSolicitud" iden="${p.id}" data-tipo="${p.tipo}" title="Ver">
                                            <i class="fa fa-search"></i>
                                        </a>
                                    </div>
                                </td>

                            </tr>
                        %{--</g:if>--}%
                        </g:each>

                        </tbody>
                    </table>
                </g:if>
                <g:else>
                    <div class="alert alert-info" style="width: 450px;margin-top: 20px">No existen solicitudes pendientes</div>
                </g:else>
            </div>


            <div role="tabpanel" class="tab-pane" id="avales">
                <g:if test="${(avales.size() > 0)}">
                    <table class="table table-condensed table-striped table-hover table-bordered" style="margin-top: 20px;">
                        <thead>
                        <tr style="width: 100%">
                            <th style="width: 10%;">Solicitud</th>
                            <th style="width: 10%;">Requirente</th>
                            <th style="width: 10%;">Proceso</th>
                            <th style="width: 10%;">Tipo</th>
                            <th style="width: 10%;">Justificación</th>
                            <th style="width: 10%;">Monto</th>
                            <th style="width: 10%;">Estado</th>
                            <th style="width: 10%;">Doc. Respaldo</th>
                            %{--                            <th style="width: 60px;">Solicitud</th>--}%
                            <th style="width: 10%;">Acciones</th>
                        </tr>
                        </thead>
                        <tbody>
                        <g:each in="${avales}" var="p">
                            <g:set var="title"/>
                            <g:if test="${p.estado.codigo == 'D01'}">
                                <g:set var="title" value="${p.observaciones}"/>
                            </g:if>
                            <g:if test="${p.estado.codigo == 'D02'}">
                                <g:set var="title" value="Devuelto por ${p.firma.usuario}${p.firma.observaciones && p.firma.observaciones != 'S' ? ': ' + p.firma.observaciones : ''}"/>
                            </g:if>
                        %{--<g:if test="${session.usuario.unidad.codigo == p?.unidad?.codigo}">--}%
                            <tr>
                                <td>
                                    ${p.unidad?.codigo}-${p.numero}
                                </td>
                                <td>
                                    ${p.unidad}
                                </td>
                                <td>
                                    ${p.proceso.nombre} ${session.usuario.unidadEjecutora.codigo} ${p?.unidad?.codigo}
                                </td>
                                <td class="${(p.tipo == 'A') ? 'E03' : 'E02'}" style="text-align: center">
                                    ${(p.tipo == "A") ? 'Anulación' : 'Aprobación'}
                                </td>
                                <td>
                                    ${p.concepto}
                                </td>
                                <td class="text-right">
                                    <g:formatNumber number="${p.monto}" type="currency" currencySymbol=""/>
                                </td>
                                <td style="text-align: center" class="text-center ${p.estado?.codigo} ${p?.aval?.estado?.codigo == 'E05' ? 'amarillo' : p?.aval?.estado?.codigo == 'E04' ? 'rojo' : p?.aval?.estado?.codigo == 'E02' ? 'verde' : ''}" title="${title}">
                                    ${p?.aval?.estado?.descripcion}
                                </td>
                                <td class="text-center">
                                    <g:if test="${p.path}">
                                        <a href="#" class="btn btn-info btn-xs descRespaldo" iden="${p.id}" title="Ver">
                                            <i class="fa fa-print"></i>
                                        </a>
                                    </g:if>
                                </td>
                                %{--                                <td class="text-center">--}%

                                %{--                                </td>--}%
                                <td class="text-center">
                                    <div class="btn-group btn-group-xs" role="group">
                                        <a href="${g.createLink(controller: 'avales', action: 'nuevaSolicitud', id: p.proceso.id)}" class="aprobar btn btn-success" title="Editar">
                                            <i class="fa fa-edit"></i>
                                        </a>
                                        <g:if test="${p.estado.codigo == 'P01' || p.estado.codigo == 'D01'}">
                                            <g:if test="${session.usuario.id == p.usuarioId}">
                                            %{--                                                <g:if test="${p.tipo == 'A'}">--}%
                                            %{--                                                    <a href="${g.createLink(controller: 'avales', action: 'solicitarAnulacion', params: [sol: p.id])}" class="aprobar btn btn-danger" title="Anular">--}%
                                            %{--                                                        <i class="fa fa-edit"></i>--}%
                                            %{--                                                    </a>--}%
                                            %{--                                                </g:if>--}%
                                            %{--                                                <g:else>--}%
                                            %{--                                                    <a href="${g.createLink(controller: 'avales', action: 'nuevaSolicitud', id: p.proceso.id)}" class="aprobar btn btn-success" title="Editar">--}%
                                            %{--                                                        <i class="fa fa-edit"></i>--}%
                                            %{--                                                    </a>--}%
                                                <a href="#" class="borrarSolicitud btn btn-danger" title="Eliminar solicitud" sol="${p.proceso.id}">
                                                    <i class="fa fa-trash"></i>
                                                </a>
                                            %{--                                                </g:else>--}%
                                            </g:if>
                                        </g:if>
                                        <g:elseif test="${p.estado.codigo == 'R01' || p.estado.codigo == 'D02'}">
                                            <a href="${g.createLink(action: 'revisionSolicitud', id: p.id)}" class="aprobar btn btn-warning" title="Revisar solicitud">
                                                <i class="fa fa-cog"></i>
                                            </a>
                                        </g:elseif>
                                        <g:elseif test="${p.estado.codigo == 'E01' || p.estado.codigo == 'D03'}">
                                            <g:if test="${session.perfil.codigo == 'ASPL'}">
                                                <g:if test="${p.tipo != 'A'}">
                                                    <a href="${g.createLink(action: 'aprobarAval', id: p.id)}" class="aprobar btn btn-warning" title="Aprobar Aval">
                                                        <i class="fa fa-cog"></i>
                                                    </a>
                                                </g:if>
                                                <g:else>
                                                    <a href="${g.createLink(action: 'aprobarAnulacion', id: p.id)}" class="aprobar btn btn-warning" title="Revisar">
                                                        <i class="fa fa-cog"></i>
                                                    </a>
                                                </g:else>
                                            </g:if>

                                        </g:elseif>
                                        <g:if test="${session.perfil.codigo in ['ASPL', 'RQ']}">
                                            <g:if test="${p.aval.estado.codigo == 'E02'}">
                                                <a href="#" class="solAnulacion btn btn-danger btn-sm" iden="${p.id}" data-aval="${p?.aval?.id}" title="Solicitar anulación">
                                                    <i class="fa fa-times"></i>
                                                </a>
                                            </g:if>
                                        </g:if>

                                        <a href="#" class="btn btn-info btn-xs imprimirSolicitud" iden="${p.id}" data-tipo="${p.tipo}" title="Ver">
                                            <i class="fa fa-search"></i>
                                        </a>
                                    </div>
                                </td>

                            </tr>
                        %{--</g:if>--}%
                        </g:each>

                        </tbody>
                    </table>
                </g:if>
                <g:else>
                    <div class="alert alert-info" style="width: 450px;margin-top: 20px">No existen solicitudes pendientes</div>
                </g:else>
            </div>

            <div role="tabpanel" class="tab-pane" id="historial">
                <div class="well" style="margin-top: 20px">
                    <form class="form-inline">
                        <div class="form-group">
                            <label for="anio">Año:</label>
                            <g:select from="${Anio.list([sort: 'anio'])}" id="anio" name="anio"
                                      optionKey="id" optionValue="anio" value="${actual.id}" class="form-control input-sm"/>
                        </div>

%{--                        <div class="form-group">--}%
%{--                            <label for="descProceso">Requirente:</label>--}%
%{--                            <g:select name="requirente" from="${unidades}" class="form-control input-sm" style="width: 200px;" optionKey="id"/>--}%
%{--                        </div>--}%

                        <div class="form-group">
                            <label for="numero">Número:</label>
                            ${actual.anio}-No.<input type="text" id="numero" class="form-control input-sm"/>
                        </div>

                        <div class="form-group">
                            <label for="descProceso">Proceso:</label>
                            <input type="text" id="descProceso" class="form-control input-sm" style="width: 200px;"/>
                        </div>
                        <a href="#" class="btn btn-info btn-sm" id="buscar">
                            <i class="fa fa-search-plus"></i> Buscar
                        </a>
                    </form>
                </div>

                <div id="detalle">

                </div>
            </div>
        </div>
    </div>
</div>

<script type="text/javascript">

    $(".solAnulacion").click(function () {
        var sol = $(this).attr("iden")
        var id = $(this).data("aval")
        location.href = '${g.createLink(controller: 'avales', action: "solicitarAnulacion")}?id=' + id + "&sol=" + sol
    });

    $(".descRespaldo").click(function () {
        location.href = "${createLink(controller:'avales',action:'descargaSolicitud')}/" + $(this).attr("iden")
    });

    function cargarHistorial(anio, numero, proceso, requirente) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'revisionAval', action:'historial')}",
            %{--url     : "${createLink(controller: 'revisionAval', action:'historialAvales')}",--}%
            data    : {
                anio       : anio,
                numero     : numero,
                proceso    : proceso,
                requirente : requirente
            },
            success : function (msg) {
                $("#detalle").html(msg)
                closeLoader();
            }
        });
    }

    $(function () {
        $(".descRespaldo").click(function () {
            location.href = "${createLink(controller:'avales',action:'descargaSolicitud')}/" + $(this).attr("iden");

        });
        $(".imprimirSolicitud").click(function () {
            var url, fn;
            var tipo = $(this).data("tipo");
            // if (tipo == "A") {
            %{--    url = "${g.createLink(controller: 'reporteSolicitud',action: 'imprimirSolicitudAnulacionAval')}/" + $(this).attr("iden");--}%
            //     fn = "solicitud_anulacion_aval.pdf";
            // } else {
            url = "${g.createLink(controller: 'reporteSolicitud',action: 'imprimirSolicitudAval')}/" + $(this).attr("iden");
            fn = "solicitud_aval.pdf";
            // }
            %{--location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=" + fn;--}%
            location.href = url + "&filename=" + fn;
        });

        $("#buscar").click(function () {
            openLoader("Cargando solicitudes...");
            cargarHistorial($("#anio").val(), $("#zona").val(), $("#descProceso").val(), $("#requirente").val());
        });
        $(".negar").click(function () {
            var id = $(this).attr("iden");
            var msg = $("<div>");
            msg.html("<i class='fa fa-times-circle fa-3x pull-left text-warning text-shadow'></i><p>" +
                "¿Está seguro que desea negar esta solicitud de aval?</p>");
            var $txa = $("<textarea class='form-control input-sm' cols='10' rows='5' />");
            var $p = $("<p>");
            $p.append("<strong>Observaciones</strong>").append($txa);
            msg.append($p);
            bootbox.dialog({
                title   : "Alerta",
                message : msg,
                buttons : {
                    cancelar : {
                        label     : "Cancelar",
                        className : "btn-primary",
                        callback  : function () {
                        }
                    },
                    eliminar : {
                        label     : "<i class='fa fa-times-circle'></i> Negar",
                        className : "btn-warning",
                        callback  : function () {
                            openLoader("Negando solicitud");
                            $.ajax({
                                type    : "POST",
                                url     : "${createLink( controller: 'revisionAval', action:'negarAval')}",
                                data    : {
                                    id  : id,
                                    obs : $txa.val()
                                },
                                success : function (msg) {
                                    if (msg != "no")
                                        location.reload(true);
                                    else
                                        location.href = "${createLink(controller:'certificacion',action:'listaSolicitudes')}/?msn=Usted no tiene los permisos para negar esta solicitud"

                                }
                            });
                            %{--$.ajax({--}%
                            %{--type    : "POST",--}%
                            %{--url     : '${createLink(action:'delete_ajax')}',--}%
                            %{--data    : {--}%
                            %{--id : itemId--}%
                            %{--},--}%
                            %{--success : function (msg) {--}%
                            %{--var parts = msg.split("*");--}%
                            %{--log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)--}%
                            %{--if (parts[0] == "SUCCESS") {--}%
                            %{--setTimeout(function () {--}%
                            %{--location.reload(true);--}%
                            %{--}, 1000);--}%
                            %{--} else {--}%
                            %{--closeLoader();--}%
                            %{--}--}%
                            %{--}--}%
                            %{--});--}%
                        }
                    }
                }
            });
        });
    });

    $(".borrarSolicitud").click(function (){
        var id = $(this).attr("sol")
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> ¿Está seguro de querer eliminar esta solicitud?", function (res) {
            if(res){
                openLoader('Eliminando solicitud');
                $.ajax({
                    type    : "POST",
                    data : {
                        id: id
                    },
                    url     : "${createLink(action:'borrarSolicitud_ajax')}",
                    success : function (msg) {
                        if (msg != "no") {
                            closeLoader();
                            log("Solicitud eliminada correctamente", "success");
                            setTimeout(function () {
                                location.reload(true)
                            }, 2000);
                        }else{
                            closeLoader();
                            bootbox.alert({
                                    message : "No se puede eliminar esta solicitud",
                                    title   : "Error",
                                    class   : "modal-error"
                                }
                            );
                        }
                    }
                });
            }
        });


    });

</script>

</body>
</html>