<%@ page import="fida.Provincia" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 02/09/19
  Time: 14:39
--%>
<g:form class="form-horizontal" name="frmSaveUnidad" controller="unidadEjecutora" action="saveUnidad_ajax">
    <g:hiddenField name="id" value="${unidad?.id}"/>

    <div class="form-group ${hasErrors(bean: unidad, field: 'padre', 'error')}  ">
        <span class="grupo">
            <label for="padre" class="col-md-2 control-label text-info">
                Unidad Padre
            </label>
            <div class="col-md-6">
                <g:if test="${unidad?.id}">
                    <g:select from="${seguridad.UnidadEjecutora.list().sort{it.nombre} - unidad}" name="padre" class="form-control"
                              value="${unidad?.padre?.id}" noSelection="[null:'- Ninguna -']" optionKey="id" optionValue="nombre"/>
                </g:if>
                <g:else>
                    <g:select from="${seguridad.UnidadEjecutora.list().sort{it.nombre}}" name="padre" class="form-control"
                              value="${unidad?.padre?.id}" noSelection="[null:'- Ninguna -']" optionKey="id" optionValue="nombre"/>
                </g:else>

                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>

    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'tipoInstitucion', 'error')} ${hasErrors(bean: unidad, field: 'provincia', 'error')}">
        <span class="grupo">
            <label for="tipoInstitucion" class="col-md-2 control-label text-info">
                Tipo Institución
            </label>
            <div class="col-md-3">
                <g:select from="${seguridad.TipoInstitucion.list().sort{it.descripcion}}" name="tipoInstitucion" class="form-control"
                          value="${unidad?.tipoInstitucion?.id}" optionKey="id" optionValue="descripcion"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="provincia" class="col-md-2 control-label text-info">
                Provincia
            </label>
            <div class="col-md-4">
                <g:select from="${fida.Provincia.list().sort{it.nombre}}" name="provincia" class="form-control"
                          value="${unidad?.provincia?.id}" optionKey="id" optionValue="nombre"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'codigo', 'error')}  ${hasErrors(bean: unidad, field: 'fechaInicio', 'error')}">
        <span class="grupo">
            <label for="codigo" class="col-md-2 control-label text-info">
                Código
            </label>
            <div class="col-md-3">
                <g:textField name="codigo" maxlength="4" class="form-control required" value="${unidad?.codigo}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Fecha Inicio
            </label>
            <div class="col-md-4">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control" value="${unidad?.fechaInicio?.format("dd-MM-yyyy")}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'nombre', 'error')} ${hasErrors(bean: unidad, field: 'sigla', 'error')}">
        <span class="grupo">
            <label for="nombre" class="col-md-2 control-label text-info">
                Nombre
            </label>
            <div class="col-md-6">
                <g:textField name="nombre" maxlength="63" class="form-control required" value="${unidad?.nombre}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="sigla" class="col-md-1 control-label text-info">
                Sigla
            </label>
            <div class="col-md-2">
                <g:textField name="sigla" maxlength="7" class="form-control" value="${unidad?.sigla}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'direccion', 'error')} ">
        <span class="grupo">
            <label for="direccion" class="col-md-2 control-label text-info">
                Dirección
            </label>
            <div class="col-md-9">
                <g:textArea name="direccion"  maxlength="127" class="form-control" style="resize: none" value="${unidad?.direccion}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'objetivo', 'error')} ">
        <span class="grupo">
            <label for="objetivo" class="col-md-2 control-label text-info">
                Objetivo
            </label>
            <div class="col-md-9">
                <g:textArea name="objetivo"  maxlength="63" class="form-control" style="resize: none" value="${unidad?.objetivo}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'telefono', 'error')} ${hasErrors(bean: unidad, field: 'mail', 'error')}">
        <span class="grupo">
            <label for="telefono" class="col-md-2 control-label text-info">
                Teléfono
            </label>
            <div class="col-md-3">
                <g:textField name="telefono" maxlength="63" class="form-control digits" value="${unidad?.telefono}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="mail" class="col-md-2 control-label text-info">
                Mail
            </label>
            <div class="col-md-4">
                <g:textField name="mail" maxlength="63" class="form-control email" value="${unidad?.mail}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'numero', 'error')} ${hasErrors(bean: unidad, field: 'orden', 'error')}">
        <span class="grupo">
            <label for="numero" class="col-md-2 control-label text-info">
                Número estado
            </label>
            <div class="col-md-3">
                <g:textField name="numero" maxlength="10" class="form-control digits" value="${unidad?.numero ?: ''}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
        <span class="grupo">
            <label for="orden" class="col-md-2 control-label text-info">
                Orden
            </label>
            <div class="col-md-4">
                <g:textField name="orden" maxlength="3" class="form-control digits" value="${unidad?.orden ?: ''}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>

    <div class="form-group ${hasErrors(bean: unidad, field: 'observaciones', 'error')} ">
        <span class="grupo">
            <label for="observaciones" class="col-md-2 control-label text-info">
                Observaciones
            </label>
            <div class="col-md-9">
                <g:textArea name="observaciones"  maxlength="127" class="form-control" style="resize: none" value="${unidad?.observaciones}"/>
                <p class="help-block ui-helper-hidden"></p>
            </div>
        </span>
    </div>
</g:form>

<script type="text/javascript">


    $('#datetimepicker1').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        // inline: true,
        sideBySide: true,
        // showClose: true,
        icons: {
            // close: 'closeText'
        }
    });

    var validator = $("#frmSaveUnidad").validate({
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
        }
    });
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitForm();
            return false;
        }
        return true;
    });
</script>
