<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 26/08/20
  Time: 12:01
--%>



<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr style="width: 100%">
        <th style="width: 90%">Tipo de necesidad</th>
        <th style="width: 10%"><i class="fa fa-trash"></i> </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${necesidades}" var="necesidad">
        <tr style="width: 100%">
            <td style="width: 90%">${necesidad?.tipoNecesidad?.descripcion}</td>
            <td style="width: 10%; text-align: center">
                <a href="#" class="btn btn-danger btn-xs btnBorrarNecesidad" data-id="${necesidad?.id}"><i class="fa fa-trash"></i> </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnBorrarNecesidad").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'necesidad', action: 'borrarNecesidad_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Borrado correctamente","success");
                    cargarTablaNecesidades();
                }else{
                    log("Error al borrar el elemento","error")
                }
            }
        })
    });

</script>