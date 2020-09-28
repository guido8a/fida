<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/09/20
  Time: 11:38
--%>
<span>
    <label>
        Fuente
    </label>
<g:select name="fuente" from="${parametros.proyectos.Fuente.list().sort{it.descripcion}}" class="form-control" optionKey="id" optionValue="descripcion"/>
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
        // daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true
    });

    $('#fechaFin').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        // daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true
    });


</script>