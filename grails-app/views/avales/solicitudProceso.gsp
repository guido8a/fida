<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Nueva solicitud de aval: 3-Solicitud</title>

    <asset:stylesheet src="/apli/wizard.css"/>

</head>

<body>
<elm:message tipo="${flash.tipo}" clase="${flash.clase}"><elm:poneHtml textoHtml="${flash.message}"/></elm:message>
<elm:message tipo="error" clase="error"><elm:poneHtml textoHtml="${params.error}"/></elm:message>


<input type="hidden" name="id" value="${proceso?.id}">

<div class="btn-toolbar" role="toolbar">
    <div class="btn-group" role="group">
        <g:link controller="revisionAval" action="pendientes" class="btn btn-default">
            <i class="fa fa-arrow-left"></i> Avales
        </g:link>
%{--        <g:if test="${proceso}">--}%
%{--            <g:link controller="avales" action="avalesProceso" id="${proceso?.id}" class="btn btn-info">--}%
%{--                <i class="fa fa-share-alt"></i> Avales y solicitudes de avales--}%
%{--            </g:link>--}%
%{--        </g:if>--}%
    </div>
</div>

<g:if test="${solicitud && solicitud.estado.codigo == 'D01' && solicitud.observaciones}">
    <div class="row">
        <div class="col-md-12">
            <elm:message tipo="warning" close="false"><elm:poneHtml textoHtml="${solicitud?.observaciones}"/></elm:message>
        </div>
    </div>
</g:if>

%{--********************************************--}%
<elm:wizardAvales paso="3" proceso="${proceso}"/>
%{--********************************************--}%

<g:uploadForm class="form-horizontal wizard-form corner-bottom frmAval" action="guardarSolicitud" controller="avales">
    <g:hiddenField name="proceso" value="${proceso.id}"/>
    <g:hiddenField name="disp" id="disponible" value="${disponible}"/>
    <g:hiddenField name="monto" value="${disponible}"/>
    <g:hiddenField name="numero" value="${numero}"/>
    <g:hiddenField name="referencial" value="${refencial}"/>
    <g:hiddenField name="solicitud" value="${solicitud?.id}"/>
    <g:hiddenField name="preview" value=""/>

    <div class="row">
        <span class="grupo">
            <label class="col-md-2 control-label">
                Número
            </label>

            <div class="col-md-2">
                <p class="form-control-static">
                    ${numero}
                </p>
            </div>
        </span>

        <span class="grupo">
            <label for="monto" class="col-md-2 control-label">
                Monto
            </label>

            <div class="col-md-2">
                <p class="form-control-static">
                    <strong>$<g:formatNumber number="${disponible}" type="number"/></strong>
                </p>
            </div>
        </span>
    </div>

    <div class="row">
        <label class="col-md-2 control-label">
            Proyecto
        </label>

        <div class="col-md-9">
            <p class="form-control-static">
                ${proceso.proyecto.toStringCompleto()}
            </p>
        </div>
    </div>

    <div class="row">
        <span class="grupo">
            <label for="memorando" class="col-md-2 control-label">
                Doc. de soporte
            </label>

            <div class="col-md-2">
                <g:if test="${!readOnly}">
                    <g:textField name="memorando" class="form-control input-sm " maxlength="63" style="width: 250px"
                                 value="${solicitud?.memo}" title="Documento de respaldo"/>
                </g:if>
                <g:else>
                    <p class="form-control-static">
                        ${solicitud?.memo}
                    </p>
                </g:else>
            </div>
        </span>

        <span class="grupo">
            <label for="monto" class="col-md-2 control-label" style="margin-left: 10px;">
                Doc. de respaldo
            </label>

            <div class="col-md-5">
                <g:if test="${!readOnly}">
                    <g:if test="${solicitud?.path}">
                        <input type="hidden" name="path" id="path" value="${solicitud?.path}" readonly
                               style="margin-left: -10px"/>
                        Archivo subido:
                        <a href="#" class="alert-link" id="btnDescargarArchivo" data-id="${solicitud?.id}">
                            <i class="fa fa-download"></i> ${solicitud?.path}
                        </a>
                    </g:if>
                    <input type="file" name="file" id="file" class="form-control input-sm " style="margin-left: -10px"/>
                </g:if>
                <g:else>
                    <p class="form-control-static">
                        <g:if test="${solicitud?.path}">
                            <a href="#" class="alert-link" id="btnDescargarArchivo" data-id="${solicitud?.id}">
                                <i class="fa fa-download"></i> ${solicitud?.path}
                            </a>
                        </g:if>
                        <g:else>
                            No ha subido un archivo
                        </g:else>
                    </p>
                </g:else>
            </div>
        </span>
    </div>

    <div class="row">
        <span class="grupo">
            <label for="memorando" class="col-md-2 control-label">
                Descripción del proceso (justificación)
            </label>

            <div class="col-md-9">
                <g:if test="${!readOnly}">
                    <g:textArea name="concepto" maxlength="1024" required="" class="form-control input-sm required"
                                style="height: 80px;resize: none" value="${solicitud?.concepto}"
                                title="Descripción del proceso"/>
                </g:if>
                <g:else>
                    <p class="form-control-static">
                        ${solicitud?.concepto}
                    </p>
                </g:else>
            </div>
        </span>
    </div>

%{--    <div class="row">--}%
%{--        <span class="grupo">--}%
%{--            <label for="firma1" class="col-md-2 control-label">--}%
%{--                Pedir revisión de--}%
%{--            </label>--}%

%{--            <div class="col-md-4">--}%
%{--                <g:if test="${!readOnly}">--}%

%{--                    <g:select from="${personas}" optionKey="id" class="form-control input-sm required"--}%
%{--                              optionValue="${{--}%
%{--                                  it.nombre + ' ' + it.apellido--}%
%{--                              }}" name="firma1" value="${solicitud?.directorId}"--}%
%{--                              noSelection="['': '.. Seleccione ..']"/>--}%
%{--                </g:if>--}%
%{--                <g:else>--}%
%{--                    <p class="form-control-static">--}%
%{--                        ${solicitud?.director}--}%
%{--                    </p>--}%
%{--                </g:else>--}%
%{--            </div>--}%
%{--        </span>--}%
%{--    </div>--}%

    <div class="row">
        <span class="grupo">
            <label for="notaTecnica" class="col-md-2 control-label">
                Nota Técnica
            </label>

            <div class="col-md-9">
                <g:if test="${!readOnly}">
                    <g:textArea name="notaTecnica" style="resize: none" maxlength="350"
                                class="form-control input-sm required"
                                value="${solicitud?.notaTecnica}"
                                title="* El monto solicitado incluye el Impuesto al Valor Agregado IVA 12%"/>
                </g:if>
                <g:else>
                    <p class="form-control-static">
                        ${solicitud?.notaTecnica}
                    </p>
                </g:else>
            </div>

        </span>
    </div>

    <div class="row">
        <div class="col-md-11 text-right">
            <g:if test="${!readOnly}">
                <div class="btn-group" role="group">
                    <a href="#" id="btnPreview" class="btn btn-default ${solicitud ? '' : 'disabled'}"
                       title="Previsualizar">
                        <i class="fa fa-search"></i> Previsualizar
                    </a>
                    <a href="#" id="btnGuardar" class="btn btn-info" title="Guardar y seguir editando">
                        <i class="fa fa-save"></i> Guardar
                    </a>
                    <a href="#" id="btnEnviar" class="btn btn-success" title="Guardar y solicitar revisión">
                        Guardar y Enviar <i class="fa fa-paper-plane"></i>
                    </a>
                </div>
            </g:if>
        </div>
    </div>
</g:uploadForm>

<script type="text/javascript">
    $(function () {

        $("#btnDescargarArchivo").click(function () {
            location.href = "${createLink(controller:'avales',action:'descargaSolicitud')}/" + $(this).data("id")
        });


        $(".frmAval").validate({
            errorClass: "help-block",
            errorPlacement: function (error, element) {
                if (element.parent().hasClass("input-group")) {
                    error.insertAfter(element.parent());
                } else {
                    error.insertAfter(element);
                }
                element.parents(".grupo").addClass('has-error');
            },
            success: function (label) {
                label.parents(".grupo").removeClass('has-error');
                label.remove();
            }
        });

        $("#btnEnviar").click(function () {
            $("#preview").val("");
            if (parseFloat("${disponible}") > 0) {
                if ($(".frmAval").valid()) {
                    bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> <strong>¿Está seguro de querer enviar la solicitud?</strong><br/><br/>" +
                    "Una vez enviada ya no se podrá modificar los datos de la Solicitud", function (res) {
                        if (res) {
                            openLoader("Por favor espere");
                            $(".frmAval").submit();
                        }
                    });
                }
            }
            else {
                bootbox.alert("No ha seleccionado asignaciones, por lo que no puede enviar esta solicitud.");
            }
        });

        $("#btnGuardar").click(function () {
            if ($(".frmAval").valid()) {
                $("#preview").val("S");
                openLoader("Por favor espere");
                $(".frmAval").submit();
            }
        });

        $("#btnPreview").click(function () {
            var url = "${g.createLink(controller: 'reporteSolicitud',action: 'imprimirSolicitudAval')}/?id=${solicitud?.id}";
            location.href = url + "&filename=solicitud.pdf"
        });
    });
</script>

</body>
</html>