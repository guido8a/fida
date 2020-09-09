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

<elm:flashMessage tipo="${flash.tipo}" clase="${flash.clase}">${flash.message}</elm:flashMessage>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="unidadEjecutora" action="organizacion" id="${planNs?.unidadEjecutora?.id}" class="btn btn-sm btn-default">
            <i class="fa fa-arrow-left"></i> Organización
        </g:link>
        <a href="#" id="btnPlanNegocio" class="btn btn-sm btn-default" title="Consultar documentos">
            <i class="fa fa-arrow-left"></i> Plan de Negocios Solidario
        </a>
        <g:link controller="plan" action="plan" id="${planNs?.id}" class="btn btn-sm btn-info">
            <i class="fa fa-camera-retro"></i> Cronograma valorado
        </g:link>
    </div>
    <div class="btn-group">
        <a href="#" class="btn btn-success" id="btnAgregarPlan" >
            <i class="fa fa-plus"></i> Agregar actividad del Plan
        </a>
    </div>
    <div class="btn-group">
        <g:link controller="plan" action="arbol" id="${planNs?.id}" class="btn btn-sm btn-default">
            <i class="fas fa-clipboard-list"></i> Componentes y Actividades del Cronograma
        </g:link>
    </div>
    <g:if test="${cnvn}">
        <div class="btn-group">
            <g:link controller="plan" action="poneFechas" id="${planNs?.id}"
                    class="btn btn-sm btn-default ${periodo? 'disabled' : ''}">
                <i class="fas fa-cogs"></i> Poner fechas de ejecución
            </g:link>
        </div>
    </g:if>
</div>

<div class="row" style="text-align: center">
    <div class="panel-primary " style="font-size: 14px; margin-bottom: 5px">
        <g:if test="${cnvn}">
            <h3>Convenio: ${cnvn?.nombre}</h3>
        </g:if>
        <strong style="color: #5596ff; ">Planificación: ${planNs?.nombre}</strong>
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
                <td style="width: 15%">${plan?.grupoActividad?.padre?.descripcion}</td>
                <td style="width: 15%">${plan?.grupoActividad?.padre != null ? plan?.grupoActividad?.descripcion : ''}</td>
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


    function agregarFuenteFNPL(id){
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'plan', action:'fuenteFnpl_ajax')}",
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

    $("#btnPlanNegocio").click(function () {
        location.href="${createLink(controller: 'planesNegocio', action: 'planes')}/?unej=" + '${planNs?.unidadEjecutora.id}'
    });

    function agregarPlan(id) {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller:'plan', action:'formPlan_ajax')}",
            data    : {
                planNs: '${planNs?.id}',
                id: id
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id      : "dlgCreatePlan",
                    title   : "Plan",
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
                    // agregarFuente(id);
                    agregarFuenteFNPL(id)
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