<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/09/20
  Time: 16:52
--%>

<div class="modal-contenido">
<g:form class="form-horizontal" name="frmEvaluacion" controller="evaluacion" action="saveEvaluacion_ajax" method="POST">
    <g:hiddenField name="id" value="${evaluacion?.id}"/>

    <div class="form-group keeptogether ${hasErrors(bean: evaluacion, field: 'planesNegocio', 'error')}">
        <span class="grupo">
            <label for="planesNegocio" class="col-md-3 control-label">
                Plan
            </label>
            <div class="col-md-9">
                <g:hiddenField name="planesNegocio" value="${plan?.id}"/>
                <g:select name="plan_name" from="${planes.PlanesNegocio.list().sort{it.nombre}}" class="form-control"
                          disabled="" value="${plan?.id}" optionValue="nombre" optionKey="id"/>
            </div>
        </span>
    </div>
    <div class="form-group keeptogether ${hasErrors(bean: evaluacion, field: 'tipoEvaluacion', 'error')}">
        <span class="grupo">
            <label for="tipoEvaluacion" class="col-md-3 control-label">
                Tipo de evaluación
            </label>
            <div class="col-md-9">
                <g:select name="tipoEvaluacion" from="${parametros.convenio.TipoEvaluacion.list().sort{it.descripcion}}" class="form-control"
                          value="${evaluacion?.tipoEvaluacion?.id}" optionValue="descripcion" optionKey="id"/>
            </div>
        </span>
    </div>
    <div class="form-group keeptogether ${hasErrors(bean: evaluacion, field: 'descripcion', 'error')} ">
        <span class="grupo">
            <label for="descripcion" class="col-md-3 control-label">
                Descripción
            </label>
            <div class="col-md-9">
                <g:textArea name="descripcion" maxlength="25" rows="2" style="resize: none" class="form-control input-sm required"
                             value="${evaluacion?.descripcion}"/>
            </div>
        </span>
    </div>
    <div class="form-group keeptogether ${hasErrors(bean: evaluacion, field: 'fechaInicio', 'error')}${hasErrors(bean: evaluacion, field: 'fechaFin', 'error')} ">
        <span class="grupo">
            <label  class="col-md-3 control-label">
                Fecha Inicio
            </label>

            <div class="col-md-3">
                <input name="fechaInicio" id='datetimepicker1' type='text' class="form-control"
                       value="${evaluacion?.fechaInicio?.format("dd-MM-yyyy")}"/>
            </div>
            <label  class="col-md-2 control-label">
                Fecha Fin
            </label>
            <span class="grupo">
                <div class="col-md-3">
                    <input name="fechaFin" id='datetimepicker2' type='text' class="form-control"
                           value="${evaluacion?.fechaFin?.format("dd-MM-yyyy")}"/>
                </div>
            </span>
        </span>
    </div>
</g:form>

<script type="text/javascript">


    $('#datetimepicker1').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true,
    });

    $('#datetimepicker2').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true,
    });


</script>