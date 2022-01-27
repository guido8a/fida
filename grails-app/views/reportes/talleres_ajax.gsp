<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 27/01/22
  Time: 10:58
--%>


<span>
    <label>
        Año
    </label>
    <input name="anio" id='anio_1' type='text' class="form-control"/>
</span>

<script type="text/javascript">

    $('#anio_1').datetimepicker({
        locale: 'es',
        format: 'YYYY',
        // daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true
    });
</script>