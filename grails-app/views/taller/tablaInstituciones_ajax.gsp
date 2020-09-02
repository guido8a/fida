<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 01/09/20
  Time: 17:13
--%>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr style="width: 100%">
        <th style="width: 90%">Institución</th>
        <th style="width: 10%"><i class="fa fa-trash"></i> </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${instituciones}" var="institucion">
        <tr style="width: 100%">
            <td style="width: 90%">${institucion?.institucion?.descripcion}</td>
            <td style="width: 10%; text-align: center">
                <a href="#" class="btn btn-danger btn-xs btnBorrarInstitucion" data-id="${institucion?.id}"><i class="fa fa-trash"></i> </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnBorrarInstitucion").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'taller', action: 'borrarInstitucion_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Borrado correctamente","success");
                    cargarTablaInstituciones();
                }else{
                    log("Error al borrar el elemento","error")
                }
            }
        })
    });

</script>