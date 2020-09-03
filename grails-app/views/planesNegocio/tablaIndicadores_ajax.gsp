<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 03/09/20
  Time: 13:40
--%>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr style="width: 100%">
        <th style="width: 90%">Indicador</th>
        <th style="width: 10%"><i class="fa fa-trash"></i> </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${indicadores}" var="indicador">
        <tr style="width: 100%">
            <td style="width: 90%">${indicador?.indicadores?.descripcion}</td>
            <td style="width: 10%; text-align: center">
                <a href="#" class="btn btn-danger btn-xs btnBorrarIndicador" data-id="${indicador?.id}"><i class="fa fa-trash"></i> </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnBorrarIndicador").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'planesNegocio', action: 'borrarIndicador_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Borrado correctamente","success");
                    cargarTablaIndicadores();
                }else{
                    log("Error al borrar el elemento","error")
                }
            }
        })
    });

</script>