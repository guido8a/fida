<%@ page import="modificaciones.Reforma; avales.SolicitudAval; parametros.Anio" %>
%{--<%--}%
%{--    def firmasService = grailsApplication.classLoader.loadClass('seguridad.FirmasService').newInstance()--}%
%{--%>--}%
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Firmas pendientes</title>
</head>

<body>
<g:if test="${session.perfil.codigo == 'DRRQ'}">
    <div class="btn-toolbar toolbar">
        <div class="btn-group">
            <div class="fila" style="height: 35px;">
                <g:link controller="avales" action="listaProcesos" class="btn btn-default">Ver Solicitudes de Avales</g:link>
                <g:link controller="modificacionesPoa" action="historialUnidad" class="btn btn-default">Ver Solicitudes de Reformas al POA</g:link>
            </div>
        </div>
    </div>
</g:if>


%{--    <g:set var="serv" bean=""--}%


%{--<qrcode:text>Hello QRCode Plugin for Grails</qrcode:text>--}%
%{--<qrcode:text logoLink="http://upload.wikimedia.org/wikipedia/commons/5/51/Google.png">--}%
%{--Hello QRCode Plugin for Grails--}%
%{--</qrcode:text>--}%

<div class="panel panel-primary col-md-12" role="tabpanel" style="margin-top: 50px;">

    <h3>Firmas Pendientes</h3>

    <ul class="nav nav-pills" role="tablist" id="tabsFirmas" style="margin-top: 10px">
        <li role="presentation" class="active">
            <a href="#AVAL" class="" role="tab" data-toggle="tab">Firmas Avales</a>
        </li>
        <li role="presentation">
            <a href="#RFRM" class="" role="tab" data-toggle="tab">Firmas Reformas</a>
        </li>
        <li role="presentation">
            <a href="#AJST" class="" role="tab" data-toggle="tab">Firmas Ajustes</a>
        </li>
        <li role="presentation">
            <a href="#HIST" class="" role="tab" data-toggle="tab">Historial</a>
        </li>
    </ul>

    <div class="tab-content">
        <div role="tabpanel" class="tab-pane active" id="AVAL">
            <g:if test="${firmasAvales?.size() > 0}">
                <table class="table table-condensed table-bordered table-striped table-hover" style="margin-top: 20px">
                    <thead>
                    <tr>
                        <th>No. Solicitud</th>
                        <th>Fecha Solicitud</th>
                        <th>Proceso</th>
                        <th>Monto</th>
                        <th>Área gestión solicitante</th>
                        <th style="width: 250px;">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${firmasAvales}" var="f">
                        <g:set var="slav" value="${avales.SolicitudAval.get(f.idAccionVer)}"/>
                        <tr data-firma="${f}" esPdf="${f.esPdf}" accVer="${f.accionVer}">
                            %{--<td>${f.concepto}</td>--}%
                            %{--                                        <td>${slav.fecha?.format("yyyy")}-${firmasService.requirentes(slav.usuario.unidad)?.codigo} No.<elm:imprimeNumero solicitud="${slav.id}"/></td>--}%
                            %{--<td>${slav?.numero} </td>--}%
                            <td>${slav.fecha?.format("dd-MM-yyyy")}</td>
                            <td>${SolicitudAval.get(f.idAccionVer)?.proceso?.nombre} </td>
                            <td style="text-align: right">
                                <g:formatNumber number="${slav.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
                            </td>
                            %{--<td>${vesta.avales.SolicitudAval.findById(f.idAccionVer)?.usuario?.unidad?.nombre}</td>--}%
                            %{--                                        <td>${firmasService.requirentes(vesta.avales.SolicitudAval.findById(f.idAccionVer)?.usuario?.unidad)}</td>--}%
                            <td style="text-align: center">
                                <div class="btn-group btn-group-sm" role="group">
                                    <g:if test="${f.accionVer}">
                                    %{--<g:if test="${f.esPdf != 'N'}">--}%
                                        <g:if test="${f.esPdf == 'S'}">
                                            <a href="${g.createLink(controller: 'pdf', action: 'pdfLink')}?url=${g.createLink(action: f.accionVer, controller: f.controladorVer, id: f.idAccionVer)}"
                                               target="_blank" class="btn btn-info" title="Ver">
                                                <i class="fa fa-search"></i>
                                            </a>
                                        </g:if>
                                        <g:else>
                                            <a href="${g.createLink(action: f.accionVer, controller: f.controladorVer, id: f.idAccionVer)}"
                                               class="btn btn-info" title="Ver">
                                                <i class="fa fa-search"></i>
                                            </a>
                                        </g:else>
                                    </g:if>
                                    <a href="#" iden="${f.id}" class="aprobar btn btn-success" title="Firmar">
                                        ${imgFirma}
                                    </a>
                                    <g:if test="${f.tipoFirma && f.tipoFirma != ''}">
                                        <a href="#" iden="${f.id}" class="devolver btn btn-danger" title="Devolver">
                                            <i class="fa fa-thumbs-down"></i>
                                        </a>
                                    </g:if>
                                    <g:else>
                                        <a href="#" iden="${f.id}" class="devolver btn btn-danger" title="Devolver">
                                            <i class="fa fa-thumbs-down"></i>
                                        </a>
                                    </g:else>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:if>
            <g:else>
                <div class="alert alert-info" style="width: 450px;margin-top: 20px">No existen firmas de avales pendientes</div>
            </g:else>
        </div>

        <div role="tabpanel" class="tab-pane fade" id="RFRM">
            <g:if test="${firmasReformas?.size() > 0}">
                <table class="table table-condensed table-bordered table-striped table-hover" style="margin-top: 20px">
                    <thead>
                    <tr>
                        <th>Justificación</th>
                        <th>Área gestión solicitante</th>
                        <th style="width: 250px;">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${firmasReformas}" var="f">
                        <tr data-firma="${f}" esPdf="${f.esPdf}" accVer="${f.accionVer}">
                            <td>${f.concepto}</td>
                            <td>${modificaciones.Reforma?.get(f.idAccionVer)?.persona?.unidadEjecutora?.nombre}</td>
                            <td style="text-align: center">
                                <div class="btn-group btn-group-sm" role="group">
                                    <g:if test="${f.accionVer}">
                                        <g:if test="${f.esPdf == 'S'}">
                                            <a href="${g.createLink(controller: 'pdf', action: 'pdfLink')}?url=${g.createLink(action: f.accionVer, controller: f.controladorVer, id: f.idAccionVer)}"
                                               target="_blank" class="btn btn-info" title="Ver">
                                                <i class="fa fa-search"></i>
                                            </a>
                                        </g:if>
                                        <g:else>
                                            <a href="${g.createLink(action: f.accionVer, controller: f.controladorVer, id: f.idAccionVer)}"
                                               class="btn btn-info" title="Ver">
                                                <i class="fa fa-search"></i>
                                            </a>
                                        </g:else>
                                    </g:if>
                                    <a href="#" iden="${f.id}" class="aprobar btn btn-success" title="Firmar">
                                        <i class="fa fa-edit"></i>  ${imgFirma}
                                    </a>
                                    <g:if test="${f.tipoFirma && f.tipoFirma != ''}">
                                        <a href="#" iden="${f.id}" class="devolver btn btn-danger" title="Devolver">
                                            <i class="fa fa-thumbs-down"></i>
                                        </a>
                                    </g:if>
                                    <g:else>
                                        <a href="#" iden="${f.id}" class="devolver btn btn-danger" title="Devolver">
                                            <i class="fa fa-thumbs-down"></i>
                                        </a>
                                    </g:else>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:if>
            <g:else>
                <div class="alert alert-info" style="width: 450px;margin-top: 20px">No existen firmas de reformas pendientes</div>
            </g:else>
        </div>

        <div role="tabpanel" class="tab-pane fade" id="AJST">
            <g:if test="${firmasAjustes?.size() > 0}">
                <table class="table table-condensed table-bordered table-striped table-hover" style="margin-top: 20px">
                    <thead>
                    <tr>
                        <th>Concepto</th>
                        <th style="width: 250px;">Acciones</th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${firmasAjustes}" var="f">
                        <tr data-firma="${f}" esPdf="${f.esPdf}" accVer="${f.accionVer}">
                            <td>${f.concepto}</td>

                            <td style="text-align: center">
                                <div class="btn-group btn-group-sm" role="group">
                                    <g:if test="${f.accionVer}">
%{--                                        <g:if test="${f.esPdf == 'S'}">--}%
                                            <a href="${g.createLink(action: f.accionVer, controller: f.controladorVer, id: f.idAccionVer)}"
                                               target="_blank" class="btn btn-info" title="Ver">
                                                <i class="fa fa-search"></i>
                                            </a>
%{--                                        </g:if>--}%
%{--                                        <g:else>--}%
%{--                                            <a href="${g.createLink(action: f.accionVer, controller: f.controladorVer, id: f.idAccionVer)}"--}%
%{--                                               class="btn btn-info" title="Ver">--}%
%{--                                                <i class="fa fa-search"></i>--}%
%{--                                            </a>--}%
%{--                                        </g:else>--}%
                                    </g:if>
                                    <a href="#" iden="${f.id}" class="aprobar btn btn-success" title="Firmar">
                                        <i class="fa fa-edit"></i>  ${imgFirma}
                                    </a>
                                    <g:if test="${f.tipoFirma && f.tipoFirma != ''}">
                                        <a href="#" iden="${f.id}" class="devolver btn btn-danger" title="Devolver">
                                            <i class="fa fa-thumbs-down"></i>
                                        </a>
                                    </g:if>
                                    <g:else>
                                        <a href="#" iden="${f.id}" class="devolver btn btn-danger" title="Devolver">
                                            <i class="fa fa-thumbs-down"></i>
                                        </a>
                                    </g:else>
                                </div>
                            </td>
                        </tr>
                    </g:each>
                    </tbody>
                </table>
            </g:if>
            <g:else>
                <div class="alert alert-info" style="width: 450px;margin-top: 20px">No existen firmas de ajustes pendientes</div>
            </g:else>
        </div>

        <div role="tabpanel" class="tab-pane fade" id="HIST">
            <div class="row">
                <div class="col-md-1">
                    <label>Año:</label>
                </div>
                <div class="col-md-2">
                    <g:select name="anioName" from="${parametros.Anio.list([sort: 'anio'])}" optionKey="id" optionValue="anio" id="anio"
                              class="form-control input-sm" value="${actual?.id}"/>
                </div>
                <div class="col-md-1">
                    <label>Tipo:</label>
                </div>
                <div class="col-md-2">
                    <g:select name="tipo" from="${['': 'Todos', 'AVAL': 'Avales', 'RFRM': 'Reformas', 'AJST': 'Ajustes']}"
                              optionKey="key" optionValue="value" class="form-control input-sm"/>
                </div>
            </div>
            <div id="detalle" style="width: 100%;height: 500px;overflow: auto;margin-top: 20px;"></div>
        </div>
    </div>
</div>

<script type="text/javascript">

    cargarHistorial();

    function cargarHistorial() {
        $.ajax({
            type    : "POST", url : "${createLink(action:'historial', controller: 'firma')}",
            data    : {
                anio : $("#anio").val(),
                tipo : $("#tipo").val()
            },
            success : function (msg) {
                $("#detalle").html(msg)
            }
        });
    }

    $(function () {

        $(".btn-success, .btn-danger").addClass("disabled");
        $(".btn-info").click(function () {
            $(this).siblings().removeClass("disabled");
        });

        cargarHistorial();
        $("#anio, #tipo").change(function () {
            cargarHistorial()
        });

        $(".descRespaldo").click(function () {
            location.href = "${createLink(controller:'avales',action:'descargaSolicitud')}/" + $(this).attr("iden")
        });

        var id;

        $(".aprobar").click(function () {
            id = $(this).attr("iden");
            bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> ¿Está seguro de firmar este documento? Esta acción no puede revertirse", function (res) {
                if (res) {

                    var msg = $("<div>Ingrese su clave de autorización</div>");
                    var $txt = $("<input type='password' class='form-control input-sm'/>");
                    var $group = $('<div class="input-group">');
                    var $span = $('<span class="input-group-addon"><i class="fa fa-lock"></i> </span>');
                    $group.append($txt).append($span);
                    msg.append($group);

                    var bAuth = bootbox.dialog({
                        title   : "Autorización electrónica",
                        message : msg,
                        class   : "modal-sm",
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            firmar : {
                                label     : "${imgFirma} Firmar",
                                className : "btn-success",
                                callback  : function () {
                                    openLoader("Firmando aprobación");

                                    $.ajax({
                                        type    : "POST",
                                        url     : '${createLink(controller: 'firma', action:'firmar')}',
                                        data    : {
                                            id   : id,
                                            pass : $txt.val()
                                        },
                                        success : function (msg) {
//                                                closeLoader();
                                            if (msg == "error") {
                                                closeLoader();
                                                bootbox.alert({
                                                        message : "Clave incorrecta",
                                                        title   : "Error",
                                                        class   : "modal-error"
                                                    }
                                                );
                                            } else {
                                                //aprobacion MDAS

                                                log("Documento firmado correctamente", "success");
                                                setTimeout(function () {
                                                    location.reload(true)
                                                }, 1000);
//                                                    location.href = msg
                                                closeLoader();

                                            }
                                        },
                                        error   : function () {
                                            log("Ha ocurrido un error interno", "error");
                                        }
                                    });
                                }
                            }
                        }
                    });
                    setTimeout(function () {
                        bAuth.find(".form-control").first().focus();
                    }, 500);
                }
            });
        });

        $(".devolver").click(function () {
            id = $(this).attr("iden");
            bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> ¿Está seguro de querer devolver este documento? Esta acción no puede revertirse", function (res) {
                if (res) {
                    var msg = $("<div>Ingrese su clave de autorización</div>");
                    var $txt = $("<input type='password' class='form-control input-sm'/>");

                    var $group = $('<div class="input-group">');
                    var $span = $('<span class="input-group-addon"><i class="fa fa-lock"></i> </span>');
                    $group.append($txt).append($span);

                    var msg2 = $("<div>Observaciones:</div>");
                    var $ta = $("<textarea class='form-control required' style='margin-top: 10px; height:100px;'>");

                    msg.append($group).append(msg2).append($ta);

                    var bAuth = bootbox.dialog({
                        title   : "Autorización electrónica",
                        message : msg,
                        class   : 'modal-sm',
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            eliminar : {
                                label     : "<i class='fa fa-thumbs-down'></i> Devolver",
                                className : "btn-danger",
                                callback  : function () {
                                    if ($.trim($txt.val()) != "" && $.trim($ta.val()) != "") {
                                        var dialog = cargarLoader("Guardando...");
                                        $.ajax({
                                            type    : "POST",
                                            url     : '${createLink(controller: 'firma', action:'devolverFirma')}',
                                            data    : {
                                                id   : id,
                                                pass : $txt.val(),
                                                obs  : $ta.val()
                                            },
                                            success : function (msg) {
                                                dialog.modal('hide');
                                                if (msg == "error") {
                                                    closeLoader();
                                                    bootbox.alert({
                                                            message : "Clave incorrecta",
                                                            title   : "Error",
                                                            class   : "modal-error"
                                                        }
                                                    );
                                                } else {
                                                    log("Documento devuelto correctamente", "success");
                                                    setTimeout(function () {
                                                        location.reload(true)
                                                    }, 1000);
                                                    closeLoader();
                                                }
                                            },
                                            error   : function () {
                                                log("Ha ocurrido un error interno", "error");

                                                closeLoader();
                                            }
                                        });
                                    } else {
                                        msg.prepend("<div class='alert alert-danger'>Por favor ingrese su clave de autorización y las observaciones</div>");
                                        return false;
                                    }
                                }
                            }
                        }
                    });
                    setTimeout(function () {
                        bAuth.find(".form-control").first().focus();
                    }, 500);
                }
            });
        });

        $(".devolver1").click(function () {
            id = $(this).attr("iden");
            bootbox.confirm("¿Devolver solicitud", function (res) {
                if (res) {

                    var msg = $("<div>Ingrese la razón por la que se devuelve</div>");
                    var $txt = $("<input type='text' class='form-control input-sm'/>");

                    var $group = $('<div class="input-group">');
                    var $span = $('<span class="input-group-addon"><i class="fa fa-lock"></i> </span>');
                    $group.append($txt).append($span);

                    msg.append($group);

                    var bAuth = bootbox.dialog({
                        title   : "Devolver trámite",
                        message : msg,
                        class   : "modal-sm",
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                }
                            },
                            eliminar : {
                                label     : "<i class='fa fa-thumbs-down'></i> Devolver",
                                className : "btn-success",
                                callback  : function () {
                                    openLoader("Firmando aprobación");
                                    $.ajax({
                                        type    : "POST",
                                        url     : '${createLink(controller: 'firma', action:'devolver')}',
                                        data    : {
                                            id   : id,
                                            obsr : $txt.val()
                                        },
                                        success : function (msg) {
//                                                closeLoader();
                                            if (msg == "error") {
                                                bootbox.alert({
                                                        message : "No se pudo devolver el trámite",
                                                        title   : "Error",
                                                        class   : "modal-error"
                                                    }
                                                );
                                            } else {
                                                log("Documento devuelto", "success")
                                                setTimeout(function () {
                                                    location.reload(true)
                                                }, 1000);
//                                                    location.href = msg
                                                closeLoader();
                                            }
                                        },
                                        error   : function () {
                                            log("Ha ocurrido un error interno", "error");
                                            closeLoader();
                                        }
                                    });
                                }
                            }
                        }
                    });
                    setTimeout(function () {
                        bAuth.find(".form-control").first().focus();
                    }, 400);
                }
            });
        });

        $(".negar").click(function () {
            var id = $(this).attr("iden");
            if (confirm("Está seguro?")) {
                $.ajax({
                    type    : "POST", url : "${createLink(action:'negar', controller: 'firma' )}",
                    data    : "id=" + id,
                    success : function (msg) {
                        if (msg != "no") {
                            location.reload(true)
                        } else {
                            $.box({
                                title  : "Error",
                                text   : "Ha ocurrido un error interno",
                                dialog : {
                                    resizable : false,
                                    width     : 400,
                                    buttons   : {
                                        "Cerrar" : function () {

                                        }
                                    }
                                }
                            });
                        }

                    }
                });
            }
        });
    });
</script>
</body>
</html>