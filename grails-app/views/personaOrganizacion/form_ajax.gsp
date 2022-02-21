<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/09/20
  Time: 13:15
--%>

<%@ page import="seguridad.UnidadEjecutora" %>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmBeneficiario" controller="personaOrganizacion" action="saveBeneficiario_ajax" method="POST">
            <g:hiddenField name="id" value="${beneficiario?.id}"/>
            <g:hiddenField name="unidad" value="${unidad?.id}"/>

            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'cedula', 'error')} ${hasErrors(bean: beneficiario, field: 'fechaInicio', 'error')}">
                <span class="grupo">
                    <label class="col-md-3 control-label">
                        Cédula
                    </label>
                    <div class="col-md-3" >
                        <g:textField name="cedula" maxlength="10" class="form-control input-sm required digits"
                                     value="${beneficiario?.cedula}"/>
                    </div>
%{--                    <button class="col-md-1 btn btn-sm" id="btnCedula">--}%
%{--                        <i class="fa fa-info-circle"></i>--}%
%{--                    </button>--}%
                    <label class="col-md-2 control-label">
                        Fecha nacimiento
                    </label>
                    <div class="col-md-3" >
                        <input name="fechaNacimiento" id='fechaNa' type='text' class="form-control"
                               value="${beneficiario?.fechaNacimiento?.format("dd-MM-yyyy")}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'nombre', 'error')} ">
                <span class="grupo">
                    <label for="nombre" class="col-md-3 control-label">
                        Nombre
                    </label>

                    <div class="col-md-9">
                        <g:textField name="nombre" maxlength="31" minlength="4" class="form-control input-sm required"
                                     value="${beneficiario?.nombre}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'apellido', 'error')} ">
                <span class="grupo">
                    <label for="apellido" class="col-md-3 control-label">
                        Apellido
                    </label>

                    <div class="col-md-9">
                        <g:textField name="apellido" maxlength="31" minlength="4" class="form-control input-sm required"
                                     value="${beneficiario?.apellido}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'cargo', 'error')}${hasErrors(bean: beneficiario, field: 'sexo', 'error')} ">
                <span class="grupo">
                    <label for="cargo" class="col-md-3 control-label">
                        Cargo
                    </label>
                    <div class="col-md-9">
                        <g:textField name="cargo" maxlength="127" class="form-control input-sm"
                                     value="${beneficiario?.cargo}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'direccion', 'error')} ">
                <span class="grupo">
                    <label for="direccion" class="col-md-3 control-label">
                        Dirección
                    </label>

                    <div class="col-md-9">
                        <g:textField name="direccion" rows="2" maxlength="255" class="form-control input-sm" style="resize: none"
                                    value="${beneficiario?.direccion}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'referencia', "error")}">
                <span class="grupo">
                    <label for="referencia" class="col-md-3 control-label">
                        Referencia
                    </label>
                    <div class="col-md-9">
                        <g:textField name="referencia" maxlength="255" class="form-control input-sm"
                                     value="${beneficiario?.referencia}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'titulo', 'error')} ">
                <label for="sexo" class="col-md-3 control-label">
                    Sexo
                </label>
                <div class="col-md-3">
                    <g:select from="${[M: 'Masculino', F: 'Femenino']}" optionKey="key" optionValue="value" name="sexo" class="form-control" value="${beneficiario?.sexo}"/>
                </div>
                <label for="discapacidad" class="col-md-3 control-label">
                    Discapacitado
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <g:select from="${['0': 'NO', '1': 'SI']}" value="${beneficiario?.discapacidad ?: 0}"
                                  optionKey="key" optionValue="value" name="discapacidad" class="form-control"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'telefono', 'error')} ">
                <label for="telefono" class="col-md-3 control-label">
                    Teléfono
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <g:textField name="telefono" maxlength="31" class="form-control input-sm digits"
                                     value="${beneficiario?.telefono}"/>
                    </div>
                </span>

                <label for="mail" class="col-md-1 control-label">
                    Mail
                </label>
                <span class="grupo">
                    <div class="col-md-5">
                        <g:textField name="mail" maxlength="63" class="form-control input-sm email"
                                     value="${beneficiario?.mail}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'raza', 'error')} ">
                <label for="raza" class="col-md-3 control-label">
                    Etnia
                </label>
                <span class="grupo">
                    <div class="col-md-4">
                        <g:select name="raza" from="${taller.Raza.list().sort{it.descripcion}}" class="form-control"
                                  value="${beneficiario?.raza?.id}" optionValue="descripcion" optionKey="id"/>
                    </div>
                </span>

                <label for="raza" class="col-md-2 control-label text-info">
                    Nacionalidad
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <g:select name="nacionalidad" from="${taller.Nacionalidad.list().sort{it.descripcion}}"
                                  class="form-control" value="${beneficiario?.nacionalidad?.id}"
                                  optionValue="descripcion" optionKey="id" noSelection="['': '- - -']" />
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'jefeFamilia', 'error')} ">
                <label class="col-md-3 control-label">
                    Fecha inicio
                </label>
                <div class="col-md-4" >
                    <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"
                           value="${beneficiario?.fechaInicio?.format("dd-MM-yyyy")}"/>
                </div>
                <label for="jefeFamilia" class="col-md-2 control-label">
                    Jefe de familia
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <g:select from="${[0: 'NO', 1: 'SI']}" value="${beneficiario?.jefeFamilia ?: 0}" optionKey="key" optionValue="value" name="jefeFamilia" class="form-control"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: beneficiario, field: 'titulo', 'error')} ">
                <label for="bono" class="col-md-4 control-label">
                    Es beneficiario del Bono de desarrrollo humano
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <g:select from="${['0': 'NO', '1': 'SI']}" value="${beneficiario?.bono ?: 0}"
                                  optionKey="key" optionValue="value" name="bono" class="form-control"/>
                    </div>
                </span>
                <label for="socio" class="col-md-2 control-label">
                    Es socio
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <g:select from="${['0': 'NO', '1': 'SI']}" value="${beneficiario?.socio ?: 0}"
                                  optionKey="key" optionValue="value" name="socio" class="form-control"/>
                    </div>
                </span>
            </div>

        </g:form>
    </div>

    <script type="text/javascript">

        $('#fechaInicio').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            daysOfWeekDisabled: [0, 6],
            sideBySide: true,
            showClose: true,
        });

        $('#fechaNa').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            daysOfWeekDisabled: [0, 6],
            sideBySide: true,
            showClose: true,
        });

        %{--$('#btnCedula').click(function () {--}%
        %{--    var cdla = $("#cedula").val();--}%
        %{--        $.ajax({--}%
        %{--            type    : "POST",--}%
        %{--            url     : '${createLink(action:'cedula_ajax')}',--}%
        %{--            data    : {cdla: cdla},--}%
        %{--            success : function (msg) {--}%
        %{--                var parts = msg.split("*");--}%
        %{--                if (parts[0] == "SUCCESS") {--}%
        %{--                    $("#nombre").val(parts[1])--}%
        %{--                    $("#apellido").val(parts[1])--}%
        %{--                    $("#fechaNa").val(parts[2])--}%
        %{--                    $("#direccion").val(parts[3])--}%
        %{--                } else {--}%
        %{--                    log('No se ha encontrado la cédula', "error");--}%
        %{--                }--}%
        %{--            }--}%
        %{--        });--}%
        %{--    return false;--}%
        %{--});--}%


        var validator = $("#frmBeneficiario").validate({
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
            ,
            rules         : {
                cedula : {
                    remote: {
                        url : "${createLink(action: 'validarCedula_ajax')}",
                        type: "post",
                        data: {
                            id: "${beneficiario?.id}",
                            unidad: '${unidad?.id}'
                        }
                    }
                }
            },
            messages      : {
                cedula : {
                    remote: "Número de cédula ya existente"
                }
            }

        });


    </script>

