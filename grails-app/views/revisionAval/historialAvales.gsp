<%@ page import="avales.SolicitudAval; avales.Aval" %>
<%@ page import="seguridad.FirmasService" %>
<%
    def firmasService = grailsApplication.classLoader.loadClass('seguridad.FirmasService').newInstance()
%>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>

%{--<div class="modal-contenido">--}%

<table class="table table-condensed table-bordered table-striped table-hover">
    <thead>
    <div>
        <tr style="width: 100%">
            <th sort="requiriente" style="width: 10%">Requirente</th>
            <th style="width: 10%">Solicitud No.</th>
            <th sort="numero" class="sort ${(sort == 'numero') ? order : ''}" style="width: 10%">Aval No.</th>
            <th sort="fechaAprobacion" class="sort ${(sort == 'fechaAprobacion') ? order : ''}" style="width: 10%">F. Emisión</th>
            <th sort="proceso" class="sort ${(sort == 'proceso') ? order : ''}" style="width: 39%">Proceso</th>
            <th sort="monto" class="sort ${(sort == 'monto') ? order : ''}" style="width: 10%">Monto</th>
            <th sort="estado" class="sort ${(sort == 'estado') ? order : ''}" style="width: 10%">Estado</th>
            <th style="width: 1%"></th>
        </tr>
    </div>
    </thead>
</table>

<div class="row-fluid"  style="width: 99.7%;height: 600px;overflow-y: auto;float: right; margin-top: -20px">
    <div class="span12">
        <div style="width: 100%; height: 600px;">
            <table class="table table-condensed table-bordered table-striped table-hover">
                <tbody>
                <g:each in="${datos}" var="aval" status="j">
%{--                    <g:set var="sol" value="${SolicitudAval.findByAval(aval)}"/>--}%
%{--                    <g:set var="avalEstado" value="${aval.estado?.codigo}"/>--}%
%{--                    <tr estadoTr="${aval?.estado?.codigo}" data-sol="${sol.id}" data-id="${aval?.id}" usu="${perfil}" style="width: 100%">--}%
%{--                        <td style="width: 10%">${sol?.unidad?.nombre}</td>--}%
%{--                        <td style="width: 10%">${sol.fecha?.format("yyyy")}-${firmasService.requirentes(sol.usuario.unidadEjecutora)?.codigo} No. ${sol?.zona}</td>--}%
%{--                        <td style="width: 10%">${aval.fechaAprobacion?.format("yyyy")}-GPE No.${aval?.zona}</td>--}%
%{--                        <td style="width: 10%">${aval.fechaAprobacion?.format("dd-MM-yyyy")}</td>--}%
%{--                        <td style="width: 39%">${aval.proceso.nombre}</td>--}%
%{--                        <td style="text-align: right; width: 10%">--}%
%{--                            <g:formatNumber number="${aval.monto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>--}%
%{--                        </td>--}%
%{--                        <td style="text-align: center; width: 11%" class="${avalEstado == 'E05' ? 'amarillo' : avalEstado == 'E04' ? 'rojo' : 'verde'}">--}%
%{--                            ${aval.estado?.descripcion}--}%
%{--                        </td>--}%
%{--                    </tr>--}%
                    <g:set var="sol" value="${SolicitudAval.findByAval(Aval.get(aval.aval__id))}"/>
                    <g:set var="avalEstado" value="${aval.edavcdgo}"/>
                    <tr estadoTr="${aval.edavcdgo}" data-sol="${sol.id}" data-id="${aval.aval__id}" usu="${perfil}" style="width: 100%">
                        <td style="width: 10%">${unidad?.nombre}</td>
                        <td style="width: 10%">${sol.fecha?.format("yyyy")}-${firmasService.requirentes(unidad)?.codigo} No. ${sol?.numero}</td>
                        <td style="width: 10%">${aval.avalfcap.format("yyyy")}-GPE No.${aval.avalnmro}</td>
                        <td style="width: 10%">${aval.avalfcap.format("dd-MM-yyyy")}</td>
                        <td style="width: 39%">${aval.prconmbr}</td>
                        <td style="text-align: right; width: 10%">
                            <g:formatNumber number="${aval.avalmnto}" format="###,##0" minFractionDigits="2" maxFractionDigits="2"/>
                        </td>
                        <td style="text-align: center; width: 11%" class="${avalEstado == 'E05' ? 'amarillo' : avalEstado == 'E04' ? 'rojo' : 'verde'}">
                            ${aval.edavdscr}
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script type="text/javascript">

    function submitForm() {
        var $form = $("#frmLiberar");
        var $btn = $("#dlgLiberar").find("#btnSave");
        if ($form.valid()) {
            $btn.replaceWith(spinner);
            openLoader("Liberando Aval");
            var formData = new FormData($form[0]);
            $.ajax({
                type        : "POST",
                url         : $form.attr("action"),
                data        : formData,
                async       : false,
                cache       : false,
                contentType : false,
                processData : false,
                success     : function (msg) {
                    var parts = msg.split("*");
                    log(parts[1], parts[0] == "SUCCESS" ? "success" : "error"); // log(msg, type, title, hide)
                    setTimeout(function () {
                        if (parts[0] == "SUCCESS") {
                            location.reload(true);
                            closeLoader();
                        } else {
                            closeLoader();
                            spinner.replaceWith($btn);
                            return false;

                        }
                    }, 1000);
                }
            });
        } else {
            $('.modal-contenido').animate({
                scrollTop : $($(".has-error")[0]).offset().top - 100
            }, 1000);
            return false;
        } //else
    }

    function liberarAval(id) {
        var data = id ? {id : id} : {};
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'liberarAval')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgLiberar",
                    title   : "Liberar Aval",
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
                                return submitForm();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //crea


    function cambiarNumero(id) {
        var data = id ? {id : id} : {};
        var idAval = id
        $.ajax({
            type    : "POST",
            url     : "${createLink(action:'cambiarNumero')}",
            data    : data,
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCambiarNumero",
                    title   : "Cambiar Número",
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
                                var sol = $("#numNuevo").val()
                                var av = $("#numNuevoAval").val()
                                $.ajax ({
                                    type: 'POST',
                                    url: '${createLink(action: 'guardarCambioNumero')}',
                                    data: {
                                        sol: sol,
                                        aval: av,
                                        id: idAval
                                    },
                                    success: function (msg) {
                                        var parts = msg.split("*")
                                        if(parts[0] == 'ok'){
                                            log("Número cambiado correctamente","success");
                                            setTimeout(function () {
                                                location.reload(true);
                                            }, 2000);
                                        }else{
                                            log(parts[1],"error");
                                        }
                                    }
                                });
//                                return submitForm();
//                                closeLoader();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    } //crea





    $(".imprimiAval").button({icons : {primary : "ui-icon-print"}, text : false}).click(function () {
        var url = "${g.createLink(controller: 'reportes',action: 'certificacion')}/?id=" + $(this).attr("iden")
        location.href = "${createLink(controller:'pdf',action:'pdfLink')}?url=" + url + "&filename=aval.pdf"
    });

    $(".sort").click(function () {
        var header = $(this);
        var sort = header.attr("sort");
        var order = "";
        if (header.hasClass("asc")) {
            order = "desc"
        } else {
            order = "asc"
        }
        cargarHistorialSort($("#anio").val(), $("#zona").val(), $("#descProceso").val(), sort, order)
    }).css({"cursor" : "pointer"});

    function createContextMenu(node) {
        var $tr = $(node);

        var items = {
            header   : {
                label  : "Acciones",
                header : true
            },
            imprimir : {
                label  : "Imprimir Aval",
                icon   : "fa fa-print",
                action : function ($element) {
                    var id = $element.data("sol");
                    location.href = "${g.createLink(controller: 'reporteSolicitud',action: 'imprimirSolicitudAval')}?id=" + id + "&filename=" + "_aval.pdf";
                }
            },
            solicitud: {
                label   : "Imprimir Solicitud",
                icon    : "fa fa-print" ,
                action : function ($element) {
                    var id = $element.data("sol");
                    location.href = "${g.createLink(controller: 'reporteSolicitud',action: 'imprimirSolicitudAval')}?id=" + id + "&filename=" + "solicitud_aval.pdf";
                }
            }
        };

        if ($tr.attr("estadoTr") == 'E02' && $tr.attr("usu") == 'ASPL') {
            items.liberar = {
                label  : "Liberar",
                icon   : "fa fa-unlink",
                action : function ($element) {
                    var id = $element.data("id");
                    liberarAval(id)
                    return false
                }
            };
        }

        //cambiar número
        if ($tr.attr("usu") == 'ASPL') {
            items.numero = {
                label  : "Cambiar número",
                icon   : "fa fa-list-ol",
                action : function ($element) {
                    var id = $element.data("id");
                    cambiarNumero(id);
                    return false
                }
            };
        }



        return items;
    }

    $("tbody>tr").contextMenu({

        items  : createContextMenu,
        onShow : function ($element) {
            $element.addClass("success");
        },
        onHide : function ($element) {
            $(".success").removeClass("success");
        }
    });

</script>