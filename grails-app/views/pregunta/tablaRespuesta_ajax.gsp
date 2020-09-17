<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/09/20
  Time: 12:18
--%>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr style="width: 100%">
        <th style="width: 90%">Respuesta</th>
        <th style="width: 10%"><i class="fa fa-trash"></i> </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${respuestas}" var="respuesta">
        <tr style="width: 100%">
            <td style="width: 90%">${respuesta?.respuesta?.opcion}</td>
            <td style="width: 10%; text-align: center">
                <a href="#" class="btn btn-danger btn-xs btnBorrarRespuesta" data-id="${respuesta?.id}"><i class="fa fa-trash"></i> </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnBorrarRespuesta").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'pregunta', action: 'borrarRespuestaSeleccionada_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Borrado correctamente","success");
                    cargarTablaRespuestas();
                }else{
                    log("Error al borrar el elemento","error")
                }
            }
        })
    });

</script>