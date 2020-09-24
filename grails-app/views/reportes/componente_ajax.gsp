<%@ page import="parametros.proyectos.TipoElemento" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/09/20
  Time: 16:45
--%>

<span>
    <label>
        Componente
    </label>
    <g:select name="componente" from="${proyectos.MarcoLogico.findAllByTipoElemento(parametros.proyectos.TipoElemento.get(3))}" class="form-control" optionKey="id" optionValue="objeto"/>
    <label>
        Fecha inicio
    </label>
    <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"/>
    <label>
        Fecha fin
    </label>
    <input name="fechaFin" id='fechaFin' type='text' class="form-control"/>

</span>

<script type="text/javascript">

    $('#fechaInicio').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true
    });

    $('#fechaFin').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true
    });


</script>