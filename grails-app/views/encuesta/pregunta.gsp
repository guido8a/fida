<%@ page contentType="text/html;charset=UTF-8" %>

<html lang="es">
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta name="layout" content="main_ec"/>
    <link rel="stylesheet" href="${resource(dir: 'css', file: 'jquery-ui-1.12.0.css')}" rel="stylesheet">
    <script src="${resource(dir: 'js', file: 'jquery-ui.min.js')}"></script>

    <title>Encuesta</title>
    <style>
    .fila1 {
        border: 1px solid #495a6b;
        float: left;
        width: 65%;
    }

    .fila2 {
        border: 1px solid #495a6b;
        margin-left: 15px;
        float: left;
        width: 33%;
    }

    .radio-toolbar input[type="radio"] {
        cursor: pointer;
    }

    .radio-toolbar label {
        line-height: 1.0em;
        padding: 2px 5px;
        margin-top: -2px;
        font-weight: normal;
        border-radius: 8px;
        font-size: 14px;
        border-style: solid;
        border-color: #d0d0ff;
        border-width: 1px;
    }

    .radio-toolbar input[type="radio"]:checked + label {
        font-weight: bold;
        background-color: #fff3d0;
    }

    </style>
</head>

<body>
<div class="ui-widget-content ui-corner-all" style="height: auto">
    <p style="text-align: center; font-size: large; color: #495a6b">Encuesta de Indicadores del Marco Lógico</p>

    <g:form name="forma" role="form" action="respuesta" controller="encuesta" method="POST">
        <input type="hidden" name="encu__id" value="${encu}">
        <input type="hidden" name="actual" value="${actual}">
        <input type="hidden" name="total" value="${total}">
        <input type="hidden" name="unidad" value="${unidad}">

        <div class="mensaje" style="display: none;"></div>

        <div class="panel panel-default fila1">
            <div class="panel-heading">
                <h3 class="panel-title">Pregunta ${actual} de ${total}</h3>
            </div>

            <div class="panel-body" style="font-size: 1.5em">${pregunta.dscr}</div>
            <input type="hidden" name="preg__id" value="${pregunta.id}">
        </div>

        <div class="panel panel-default fila2">

            <div class="panel-heading">
                <span style="font-weight: bold">Respuesta</span>
            </div>

            <div class="panel-body">
%{--                ${rp[0].id == 3}--}%
                <g:if test="${rp[0].dscr == 'Número'}">
                    <div class="resp" style="margin-bottom: 0;">
                        <label for="numero">Ingrese un numéro</label>
                        <input type="number" name="numero" value="${resp[1]}" id="numero">
                        <input type="hidden" name="resp" value="3">
                        <input type="hidden" name="rspg" value="${rp[0].id}">
                    </div>
                </g:if>
                <g:else>
                    <g:if test="${rp[0].dscr == 'Texto libre'}">
                        <div class="resp" style="margin-bottom: 0;">
                            <label for="texto">Escriba su respuesta</label>
                            <input type="text" style="width: 230px" name="texto" value="${resp[1]?:''}" id="texto">
                            <input type="hidden" name="resp" value="4">
                            <input type="hidden" name="rspg" value="${rp[0].id}">
                        </div>
                    </g:if>
                    <g:else>
                    <g:each in="${rp}" var="respuesta">
                        <div class="radio-toolbar resp" style="margin-bottom: 0;">
                            <input type="radio" name="respuestas" value="${respuesta.id}"
                                ${(respuesta.id == resp[0] ? 'checked' : ' ')} id="${respuesta.id}">
                            <label for="${respuesta.id}">${respuesta.dscr}</label>
                        </div>
                    </g:each>
                    </g:else>
                </g:else>
            </div>
        </div>

    </g:form>

</div>

<div class="row col-md-12 col-xs-12">
    <a class="btn btn-danger col-md-4 col-xs-4" href="#" id="abandonar"><i class="fa fa-trash"></i> Abandonar encuesta</a>
    <a class="btn btn-default col-md-4 col-xs-4" href="#" id="anterior"><i class="fa fa-arrow-left"></i> Anterior</a>
    <g:if test="${actual == total}">
        <a class="btn btn-info  col-md-4 col-xs-4" href="#" id="siguiente"><strong>Finalizar Encuesta</strong> <i
                class="fa fa-check"></i></a>
    </g:if>
    <g:else>
        <a class="btn btn-default col-md-4 col-xs-4" href="#" id="siguiente">Siguiente <i class="fa fa-arrow-right"></i></a>
    </g:else>
</div>


<script type="text/javascript">
    var url = "${assetPath(src: '/apli/spinner32.gif')}";
//    var spinner = $("<div class='btn col-md-4 col-xs-4' style='height: auto; border-color: #495a6b'><img  src='" + url + "'/><span> Cargando...</span></div>");
    var spinner = $("<div class='btn col-md-4 col-xs-4' style='height: 40px; border-color: #495a6b'>" +
        "<img  src='" + url + "'/><span>  Cargando...</span></div>");

    $(function () {
        $(document).ready(function () {
            // Handler for .ready() called.
            $(".resp").change();
        });

        $("#abandonar").click(function () {
            bootbox.confirm({
                title: "¿Abandonar la encuesta?",
                message: "Si abandona la encuesta podrá retomarla desde la última pregunta contestada.",
                buttons: {
                    cancel: {
                        label: '<i class="fa fa-times"></i> Cancelar'
                    },
                    confirm: {
                        label: '<i class="fa fa-check"></i> Aceptar',
                        className: 'btn-success'
                    }
                },
                callback: function (result) {
                    if(result) {
                        $("#abandonar").replaceWith(spinner);
                        location.href = "${createLink(action: 'index')}"
                    }
                }
            });
        });


        $("#anterior").click(function () {
            bootbox.confirm({
                title: "¿Regresar a la pregunta anterior?",
                message: "Confirme la orden o presione Cancelar",
                buttons: {
                    cancel: {
                        label: '<i class="fa fa-times"></i> Cancelar'
                    },
                    confirm: {
                        label: '<i class="fa fa-check"></i> Aceptar',
                        className: 'btn-success'
                    }
                },
                callback: function (result) {
                    if(result) {
                        $("#anterior").replaceWith(spinner);
                        location.href = "${createLink(action: 'anterior')}" +
                            "?encu__id=${encu}&actual=${actual}&total=${total}&unej=${unidad}"
                    }
                }
            });
        });

        $("#siguiente").click(function () {
            var respit
            if("${rp[0].id == 3}") {
                respit = $('#numero').val()
            } else {
                respit = $('input[name=respuestas]:checked').length;
            }
            if (respit == 0) {
                bootbox.alert({
                    title: "No ha seleccionado una respuesta",
                    message: "Escoja una de las opciones de 'Seleccione una Respuesta', si ha seleccionado " +
                    "ASIGNATURA, asegúrese de haber escogido una.",
                    buttons: {
                        ok: {
                            label: '<i class="fa fa-check"></i> Aceptar',
                            className: 'btn-success'
                        }
                    }
                });
                return false;
            } else {
                $("#siguiente").replaceWith(spinner);
                $("#forma").submit();
                return true;
            }
        });
    });
</script>
</body>
</html>
