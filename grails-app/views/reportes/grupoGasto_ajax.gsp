<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 24/09/20
  Time: 16:00
--%>

<span>
    <label>
        Grupo de gasto
    </label>
    <g:select name="grupo" from="${grupo}" class="form-control"/>
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