<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 19/08/20
  Time: 11:47
--%>

<g:select name="canton" from="${cantones}" class="form-control" optionKey="id" optionValue="nombre" value="${unidad?.parroquia?.canton?.id}"/>

<script type="text/javascript">

    $("#canton").change(function () {
        var can = $(this).val();
        cargarParroquia(can);
    });

    cargarParroquia($("#canton option:selected").val());

    function cargarParroquia (id) {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'unidadEjecutora', action: 'parroquia_ajax')}',
            data:{
                id: id,
                unidad: '${unidad?.id}'
            },
            success: function (msg) {
                $("#divParroquia").html(msg)
            }
        });
    }

</script>