<%@ page import="seguridad.UnidadEjecutora" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 24/08/20
  Time: 12:46
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Datos de Organización</title>
</head>
<body>

<div class="btn-toolbar toolbar">
    <div class="btn-group">
        <g:link controller="unidadEjecutora" action="organizacion" id="${unidad?.id}" class="btn btn-sm btn-default">
            <i class="fa fa-arrow-left"></i> Organización
        </g:link>
        <a href="#" class="btn btn-success" id="btnGuardarDatosOrg"><i class="fa fa-save"></i>Guardar</a>
    </div>
</div>

<div class="panel panel-primary col-md-12">
    <div class="col-md-12" style="text-align: center">
        <h3>Organización: ${unidad.nombre}</h3>
    </div>

    <div class="panel-info" style="padding: 3px; margin-top: 2px">
        <g:form class="form-horizontal" name="frmSaveDatos" controller="datosOrganizacion" action="saveDatos_ajax">
            <g:hiddenField name="id" value="${dato?.id}"/>

%{--
            <div class="form-group ${hasErrors(bean: dato, field: 'unidadEjecutora', 'error')}  ">
                <span class="grupo">
                    <label for="unidadEjecutora_nombre" class="col-md-2 control-label text-info">
                        Organización
                    </label>
                    <div class="col-md-7">
                        <g:hiddenField name="unidadEjecutora" value="${unidad?.id}"/>
                        <g:select from="${seguridad.UnidadEjecutora.list().sort{it.nombre}}" name="unidadEjecutora_nombre" class="form-control input-sm"
                                  value="${unidad?.id}" optionKey="id" optionValue="nombre" disabled=""/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
--}%
            <div class="form-group ${hasErrors(bean: dato, field: 'cuenta', 'error')} ${hasErrors(bean: dato, field: 'financiera', 'error')} ">
                <span class="grupo">
                    <div class="col-md-4">
                        <label for="financiera" class="control-label text-info">
                            Entidad Financiera
                        </label>
                        <g:textField name="financiera" value="${dato?.financiera}" maxlenght="127" class="form-control input-sm"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <div class="col-md-2">
                        <label for="cuenta" class="control-label text-info">
                            Número cuenta
                        </label>
                        <g:textField name="cuenta" value="${dato?.cuenta}" maxlenght="20" class="form-control input-sm"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <div class="col-md-2">
                        <label for="tipoCuenta" class="control-label text-info">
                            Tipo de cuenta
                        </label>
                        <g:select name="tipoCuenta" from="${[0:'Ahorros', 1:'Corriente']}" value="${dato?.tipoCuenta}" optionValue="value" optionKey="key" class="form-control input-sm"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>

                <span class="grupo">
                    <label for="persona" class="col-md-3 control-label text-warning">
                        Persona responsable de datos: ${dato?.persona?.id}
                    </label>
                    <div class="col-md-4">
                        <g:select name="persona" from="${seguridad.Persona.findAllByUnidadEjecutora(seguridad.UnidadEjecutora.get(2)).sort{it.apellido}}"
                                  class="form-control" optionKey="id" optionValue="${{it.apellido + " " + it.nombre}}" value="${dato?.persona?.id}"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>

            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'legales', 'error')} ${hasErrors(bean: dato, field: 'noLegales', 'error')}  ">
                <span class="grupo">
                    <label for="legales" class="col-md-3 control-label text-info">
                        Socios de la organización Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="legales" value="${dato?.legales}" maxlength="3" class="form-control input-sm number "/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>

                <span class="grupo">
                    <label for="noLegales" class="col-md-3 control-label text-info">
                        Socios de la organización No Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="noLegales" value="${dato?.noLegales}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="totalSocios" class="col-md-3 control-label text-success">
                        Total de Socios
                    </label>
                    <div class="col-md-1">
                        <g:textField name="totalSocios" value="${(dato?.legales + dato?.noLegales) ?: 0}" readonly="" class="form-control input-sm number totalSoc"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>

            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'familiasLegales', 'error')} ${hasErrors(bean: dato, field: 'familiasNoLegales', 'error')}  ">
                <span class="grupo">
                    <label for="familiasLegales" class="col-md-3 control-label text-info">
                        Familias Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="familiasLegales" value="${dato?.familiasLegales}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="familiasNoLegales" class="col-md-3 control-label text-info">
                        Familias No Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="familiasNoLegales" value="${dato?.familiasNoLegales}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="totalFamilias" class="col-md-3 control-label text-success">
                        Total de Familias
                    </label>
                    <div class="col-md-1">
                        <g:textField name="totalFamilias" value="${(dato?.familiasLegales + dato?.familiasNoLegales) ?: 0}" readonly="" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'mujeresSocias', 'error')} ${hasErrors(bean: dato, field: 'hombresSocios', 'error')}  ">
                <span class="grupo">
                    <label for="mujeresSocias" class="col-md-3 control-label text-info">
                        Socias Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="mujeresSocias" value="${dato?.mujeresSocias}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="hombresSocios" class="col-md-3 control-label text-info">
                        Socios Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="hombresSocios" value="${dato?.hombresSocios}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="socios" class="col-md-3 control-label text-success">
                        Total de Socios Legales
                    </label>
                    <div class="col-md-1">
                        <g:textField name="socios" value="${(dato?.mujeresSocias + dato?.hombresSocios) ?: 0}" readonly="" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>

            <div class="form-group ${hasErrors(bean: dato, field: 'jovenes', 'error')}  ">
                <span class="grupo">
                    <label for="jovenes" class="col-md-3 control-label text-info">
                        Jóvenes (18 - 29 años) socios legales que participan en el negocio
                    </label>
                    <div class="col-md-1">
                        <g:textField name="jovenes" value="${dato?.jovenes}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'obreros', 'error')}  ">
                <span class="grupo">
                    <label for="obreros" class="col-md-3 control-label text-info">
                        Empleados/obreros del negocio (personal externo)
                    </label>
                    <div class="col-md-1">
                        <g:textField name="obreros" value="${dato?.obreros}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'adultos', 'error')}  ">
                <span class="grupo">
                    <label for="adultos" class="col-md-3 control-label text-info">
                        Socios adultos
                    </label>
                    <div class="col-md-1">
                        <g:textField name="adultos" value="${dato?.adultos}" maxlength="2" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'dirigentesMujeres', 'error')} ${hasErrors(bean: dato, field: 'dirigentesHombres', 'error')}  ">
                <span class="grupo">
                    <label for="dirigentesMujeres" class="col-md-3 control-label text-info">
                        Socias dirigentes mujeres
                    </label>
                    <div class="col-md-1">
                        <g:textField name="dirigentesMujeres" value="${dato?.dirigentesMujeres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="dirigentesHombres" class="col-md-3 control-label text-info">
                        Socios dirigentes hombres
                    </label>
                    <div class="col-md-1">
                        <g:textField name="dirigentesHombres" value="${dato?.dirigentesHombres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="dirigentes" class="col-md-3 control-label text-success">
                        Total de socios dirigentes
                    </label>
                    <div class="col-md-1">
                        <g:textField name="dirigentes" value="${(dato?.dirigentesMujeres + dato?.dirigentesHombres) ?: 0}" readonly="" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'sociosJovenesMujeres', 'error')} ${hasErrors(bean: dato, field: 'sociosJovenesHombres', 'error')}  ">
                <span class="grupo">
                    <label for="sociosJovenesMujeres" class="col-md-3 control-label text-info">
                        Socias jóvenes mujeres
                    </label>
                    <div class="col-md-1">
                        <g:textField name="sociosJovenesMujeres" value="${dato?.sociosJovenesMujeres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="sociosJovenesHombres" class="col-md-3 control-label text-info">
                        Socios jóvenes hombres
                    </label>
                    <div class="col-md-1">
                        <g:textField name="sociosJovenesHombres" value="${dato?.sociosJovenesHombres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="sociosJovenes" class="col-md-3 control-label text-success">
                        Total de socios jóvenes
                    </label>
                    <div class="col-md-1">
                        <g:textField name="sociosJovenes" value="${(dato?.sociosJovenesMujeres + dato?.sociosJovenesHombres) ?: 0}" readonly="" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'adultosMayoresMujeres', 'error')} ${hasErrors(bean: dato, field: 'adultosMayoresHombres', 'error')}  ">
                <span class="grupo">
                    <label for="adultosMayoresMujeres" class="col-md-3 control-label text-info">
                        Socios adultos mayores mujeres
                    </label>
                    <div class="col-md-1">
                        <g:textField name="adultosMayoresMujeres" value="${dato?.adultosMayoresMujeres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="adultosMayoresHombres" class="col-md-3 control-label text-info">
                        Socios  adultos mayores hombres
                    </label>
                    <div class="col-md-1">
                        <g:textField name="adultosMayoresHombres" value="${dato?.adultosMayoresHombres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="adultosMayores" class="col-md-3 control-label text-success">
                        Total de socios adultos mayores
                    </label>
                    <div class="col-md-1">
                        <g:textField name="adultosMayores" value="${(dato?.adultosMayoresMujeres + dato?.adultosMayoresHombres) ?: 0}" readonly="" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'discapacitadosMujeres', 'error')} ${hasErrors(bean: dato, field: 'discapacitadosHombres', 'error')}  ">
                <span class="grupo">
                    <label for="discapacitadosMujeres" class="col-md-3 control-label text-info">
                        Socios con discapcidad mujeres
                    </label>
                    <div class="col-md-1">
                        <g:textField name="discapacitadosMujeres" value="${dato?.discapacitadosMujeres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="discapacitadosHombres" class="col-md-3 control-label text-info">
                        Socios con discapacidad hombres
                    </label>
                    <div class="col-md-1">
                        <g:textField name="discapacitadosHombres" value="${dato?.discapacitadosHombres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="discapacitados" class="col-md-3 control-label text-success">
                        Total de socios con discapacidad
                    </label>
                    <div class="col-md-1">
                        <g:textField name="discapacitados" value="${(dato?.discapacitadosMujeres + dato?.discapacitadosHombres) ?: 0}" readonly="" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'usuariosBonoMujeres', 'error')} ${hasErrors(bean: dato, field: 'usuariosBonoHombres', 'error')}  ">
                <span class="grupo">
                    <label for="usuariosBonoMujeres" class="col-md-3 control-label text-info">
                        Socios mujeres usuarios del bono de desarrollo humano
                    </label>
                    <div class="col-md-1">
                        <g:textField name="usuariosBonoMujeres" value="${dato?.usuariosBonoMujeres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="usuariosBonoHombres" class="col-md-3 control-label text-info">
                        Socios hombres usuarios del bono de desarrollo humano
                    </label>
                    <div class="col-md-1">
                        <g:textField name="usuariosBonoHombres" value="${dato?.usuariosBonoHombres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="usuariosBono" class="col-md-3 control-label text-success">
                        Total de socios usuarios del bono de desarrollo humano
                    </label>
                    <div class="col-md-1">
                        <g:textField name="usuariosBono" value="${(dato?.usuariosBonoMujeres + dato?.usuariosBonoHombres) ?: 0}" readonly="" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'usuariosCreditoMujeres', 'error')} ${hasErrors(bean: dato, field: 'usuariosCreditoHombres', 'error')}  ">
                <span class="grupo">
                    <label for="usuariosCreditoMujeres" class="col-md-3 control-label text-info">
                        Socios mujeres usuarios del crédito de desarrollo humano
                    </label>
                    <div class="col-md-1">
                        <g:textField name="usuariosCreditoMujeres" value="${dato?.usuariosCreditoMujeres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="usuariosCreditoHombres" class="col-md-3 control-label text-info">
                        Socios hombres usuarios del crédito de desarrollo humano
                    </label>
                    <div class="col-md-1">
                        <g:textField name="usuariosCreditoHombres" value="${dato?.usuariosCreditoHombres}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <span class="grupo">
                    <label for="usuariosCredito" class="col-md-3 control-label text-success">
                        Total de socios usuarios del crédito de desarrollo humano
                    </label>
                    <div class="col-md-1">
                        <g:textField name="usuariosCredito" value="${(dato?.usuariosCreditoMujeres + dato?.usuariosCreditoHombres) ?: 0}" readonly="" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
            <div class="form-group ${hasErrors(bean: dato, field: 'mujeresCabezaHogar', 'error')}  ">
                <span class="grupo">
                    <label for="mujeresCabezaHogar" class="col-md-3 control-label text-info">
                        Socios mujeres cabeza de hogar
                    </label>
                    <div class="col-md-1">
                        <g:textField name="mujeresCabezaHogar" value="${dato?.mujeresCabezaHogar}" maxlength="3" class="form-control input-sm number"/>
                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>
        </g:form>
    </div>
</div>

<script type="text/javascript">

    $("#btnEtnias").click(function () {
        $.ajax({
            type    : "POST",
            url     : "${createLink(controller: 'etniaOrganizacion',action:'formEtnias_ajax')}",
            data    : {
                unidad: '${unidad?.id}'
            },
            success : function (msg) {
                var b = bootbox.dialog({
                    id    : "dlgEtnias",
                    title : "Etnias de la organización",
                    // class : "modal-lg",
                    message : msg,
                    buttons : {
                        cancelar: {
                            label: "Salir",
                            className: "btn-primary",
                            callback: function () {
                            }
                        }
                    }
                }); //dialog
                setTimeout(function () {
                    b.find(".form-control").first().focus()
                }, 500);
            } //success
        }); //ajax
    });

    $("#btnGuardarDatosOrg").click(function () {
        submitForm()
    });

    function submitForm() {
        var $form = $("#frmSaveDatos");
            $.ajax({
                type    : "POST",
                url     : '${createLink(controller: 'datosOrganizacion', action:'saveDatos_ajax')}',
                data    : $form.serialize(),
                success : function (msg) {
                    if(msg == 'ok'){
                        log("Datos guardados correctamente","success");
                        setTimeout(function () {
                            location.reload(true);
                        }, 500);
                    }else{
                        log("Error al guardar los datos","error")
                    }
                }
            });
    }

    $("#legales, #noLegales").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#legales, #noLegales").on("change keyup blur",function () {
                var l =  $("#legales").val();
                var nl = $("#noLegales").val();
                $("#totalSocios").val(suma(l,nl))
            });
        }else{
            return false
        }
    });

    $("#familiasLegales, #familiasNoLegales").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#familiasLegales, #familiasNoLegales").on("change keyup blur",function () {
                var l2 =  $("#familiasLegales").val();
                var nl2 = $("#familiasNoLegales").val();
                $("#totalFamilias").val(suma(l2,nl2))
            });
        }else{
            return false
        }
    });

    $("#mujeresSocias, #hombresSocios").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#mujeresSocias, #hombresSocios").on("change keyup blur",function () {
                var l2 =  $("#mujeresSocias").val();
                var nl2 = $("#hombresSocios").val();
                $("#socios").val(suma(l2,nl2))
            });
        }else{
            return false
        }
    });

    $("#dirigentesMujeres, #dirigentesHombres").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#dirigentesMujeres, #dirigentesHombres").on("change keyup blur",function () {
                var l2 =  $("#dirigentesMujeres").val();
                var nl2 = $("#dirigentesHombres").val();
                $("#dirigentes").val(suma(l2,nl2))
            });
        }else{
            return false
        }
    });

    $("#sociosJovenesMujeres, #sociosJovenesHombres").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#sociosJovenesMujeres, #sociosJovenesHombres").on("change keyup blur",function () {
                var l2 =  $("#sociosJovenesMujeres").val();
                var nl2 = $("#sociosJovenesHombres").val();
                $("#sociosJovenes").val(suma(l2,nl2))
            });
        }else{
            return false
        }
    });

    $("#adultosMayoresMujeres, #adultosMayoresHombres").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#adultosMayoresMujeres, #adultosMayoresHombres").on("change keyup blur",function () {
                var l2 =  $("#adultosMayoresMujeres").val();
                var nl2 = $("#adultosMayoresHombres").val();
                $("#adultosMayores").val(suma(l2,nl2))
            });
        }else{
            return false
        }
    });

    $("#discapacitadosMujeres, #discapacitadosHombres").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#discapacitadosMujeres, #discapacitadosHombres").on("change keyup blur",function () {
                var l2 =  $("#discapacitadosMujeres").val();
                var nl2 = $("#discapacitadosHombres").val();
                $("#discapacitados").val(suma(l2,nl2))
            });
        }else{
            return false
        }
    });

    $("#usuariosBonoMujeres, #usuariosBonoHombres").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#usuariosBonoMujeres, #usuariosBonoHombres").on("change keyup blur",function () {
                var l2 =  $("#usuariosBonoMujeres").val();
                var nl2 = $("#usuariosBonoHombres").val();
                $("#usuariosBono").val(suma(l2,nl2))
            });
        }else{
            return false
        }
    });

    $("#usuariosCreditoMujeres, #usuariosCreditoHombres").keydown(function (ev) {
        if(validarNumero(ev)){
            $("#usuariosCreditoMujeres, #usuariosCreditoHombres").on("change keyup blur",function () {
                var l2 =  $("#usuariosCreditoMujeres").val();
                var nl2 = $("#usuariosCreditoHombres").val();
                $("#usuariosCredito").val(suma(l2,nl2))
            });
        }else{
            return false
        }
    });

    $("#obreros, #jovenes, #mujeresCabezaHogar").keydown(function (ev) {
        return validarNumero(ev)
    });

    function suma(uno, dos) {
        var total = 0;
        total += parseInt(uno);
        total += parseInt(dos);
        return total
    }

    function validarNumero(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39);
    }


</script>

</body>
</html>