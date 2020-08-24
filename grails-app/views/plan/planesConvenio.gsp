<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 18/08/20
  Time: 10:59
--%>

<%@ page import="parametros.proyectos.TipoElemento" contentType="text/html;charset=UTF-8" %>
<html>
<head>
    <meta name="layout" content="main"/>
    <title>Planes</title>

    <style>
        .derecha{
            text-align: right;
        }
    </style>
</head>

<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="convenio" action="convenio" id="${convenio?.id}" class="btn btn-sm btn-default">
            <i class="fa fa-arrow-left"></i> Convenio
        </g:link>
        <g:link controller="plan" action="plan" id="${convenio?.id}" class="btn btn-sm btn-info">
            <i class="fa fa-camera-retro"></i> Planificación
        </g:link>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnAgregarPlan" >
            <i class="fa fa-plus"></i> Agregar Plan
        </a>
    </div>
</div>

<div class="row" style="text-align: center">
    <div class="panel-primary " style="font-size: 14px; margin-bottom: 5px">
        <strong style="color: #5596ff; ">Convenio: ${convenio?.nombre}</strong>
    </div>
</div>

    <table style="font-size: 11px" class="table table-condensed table-bordered table-striped">
        <thead>
        <tr style="width: 100%">
            <th style="width: 15%">Componente</th>
            <th style="width: 15%">Actividad</th>
            <th style="width: 19%">Descripción</th>
            <th style="width: 8%">Unidad compras públicas</th>
            <th style="width: 8%">Código compras públicas</th>
            <th style="width: 8%">Tipo de proceso</th>
            <th style="width: 9%">Cantidad</th>
            <th style="width: 9%">Costo</th>
            <th style="width: 9%">Ejecutado</th>
        </tr>
        </thead>

        <tbody>
        <g:set var="total" value="${0}"/>
        <g:set var="totalC" value="${0}"/>
        <g:set var="totalE" value="${0}"/>
        <g:each in="${planes}" var="plan" status="i">
            <tr style="width: 100%" data-id="${plan?.id}">

                <td style="width: 15%">${plan?.marcoLogico?.tipoElemento == parametros.proyectos.TipoElemento.get(4) ? plan?.marcoLogico?.marcoLogico?.objeto : ''}</td>
                <td style="width: 15%">${plan?.marcoLogico?.tipoElemento == parametros.proyectos.TipoElemento.get(4) ? plan?.marcoLogico?.objeto : ''}</td>
                <td style="width: 19%">${plan?.descripcion}</td>
                <td style="width: 8%">${plan?.unidadComprasPublicas?.descripcion}</td>
                <td style="width: 8%" title="${plan?.codigoComprasPublicas?.descripcion}">${plan?.codigoComprasPublicas?.numero}</td>
                <td style="width: 8%">${plan?.tipoProcesoComprasPublicas?.descripcion}</td>
                <td style="width: 9%" class="derecha">  <g:formatNumber number="${plan?.cantidad}" type="currency" currencySymbol=""/></td>
                <td style="width: 9%" class="derecha">  <g:formatNumber number="${plan?.costo}" type="currency" currencySymbol=""/></td>
                <td style="width: 9%"class="derecha">  <g:formatNumber number="${plan?.ejecutado}" type="currency" currencySymbol=""/></td>
                <g:set var="total" value="${total += plan?.cantidad}"/>
                <g:set var="totalC" value="${totalC += plan?.costo}"/>
                <g:set var="totalE" value="${totalE += plan?.ejecutado}"/>
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
            <td class="valor" style="text-align: right; font-weight: bold;">
                <g:formatNumber number="${totalC.toDouble()}" type="currency" currencySymbol=""/>
            </td>
            <td class="valor" style="text-align: right; font-weight: bold;">
                <g:formatNumber number="${totalE.toDouble()}" type="currency" currencySymbol=""/>
            </td>
        </tr>
        </tfoot>
    </table>

<script type="text/javascript">

    function agregarFuente(id){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'plan', action:'fuente_ajax')}",
            data    : {
                id : id
            },
            success : function (msg) {
                bootbox.dialog({
                    title   : "Fuentes",
                    class   : "modal-lg",
                    message : msg,
                    buttons : {
                        ok : {
                            label     : "Salir",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    }
                });
            }
        });
    }

    $("#btnAgregarPlan").click(function () {
        agregarPlan(null)
    });

    function agregarPlan(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'plan', action:'formPlan_ajax')}",
            data    : {
                convenio: '${convenio?.id}',
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreatePlan",
                    title   : "Plan",
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
                                return submitFormPlan();
                            } //callback
                        } //guardar
                    } //buttons
                }); //dialog
            } //success
        }); //ajax
    }


    function submitFormPlan(){
            var $form = $("#frmPlan");
            if ($form.valid()) {
                $.ajax({
                    type    : "POST",
                    url     : '${createLink(controller: 'plan', action:'savePlan_ajax')}',
                    data    : $form.serialize(),
                    success : function (msg) {
                        if (msg=="ok") {
                            log("Plan creado correctamente","success");
                            setTimeout(function () {
                                location.reload(true);
                            }, 1000);
                        } else {
                            log("Error al guardar el plan","error");
                            return false;
                        }
                    }
                });
            } else {
                return false;
            } //else
    }

    function borrarPlan(id) {
        bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> ¿Está seguro de querer eliminar este plan?", function (res) {
            if(res){
                $.ajax({
                    type    : "POST",
                    url     : '${createLink(controller: 'plan', action:'borrarPlan_ajax')}',
                    data    : {
                        id: id
                    },
                    success : function (msg) {
                        if (msg=="ok") {
                            log("Plan borrado correctamente","success");
                            setTimeout(function () {
                                location.reload(true);
                            }, 1000);
                        } else {
                            if(msg == 'er'){
                                bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> " + "El plan ya posee períodos asignados, no puede ser borrado!")
                            }else{
                                log("Error al borrar el plan","error");
                                return false;
                            }
                        }
                    }
                });
            }
        });
    }

    $("tbody>tr").contextMenu({
        items: {
            header: {
                label: "Acciones",
                header: true
            },
            editar: {
                label: "Editar",
                icon: "fa fa-edit",
                action: function ($element) {
                    var id = $element.data("id");
                    agregarPlan(id);
                }
            },
            fuente: {
                label: "Fuente",
                icon: "fa fa-money-bill",
                action: function ($element) {
                    var id = $element.data("id");
                    agregarFuente(id);
                }
            },
            eliminar: {
                label: "Eliminar",
                icon: "fa fa-trash",
                separator_before: true,
                action: function ($element) {
                    var id = $element.data("id");
                    borrarPlan(id);
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

</script>

</body>
</html>