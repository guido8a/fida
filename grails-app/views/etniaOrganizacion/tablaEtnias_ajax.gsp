<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 25/08/20
  Time: 11:56
--%>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr style="width: 100%">
        <th style="width: 70%">Etnia</th>
        <th style="width: 20%">Cantidad</th>
        <th style="width: 10%"><i class="fa fa-trash"></i> </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${etnias}" var="etnia">
        <tr style="width: 100%">
            <td style="width: 70%">${etnia?.raza?.descripcion}</td>
            <td style="width: 20%">${etnia?.numero}</td>
            <td style="width: 10%; text-align: center">
                <a href="#" class="btn btn-danger btn-xs btnBorrarEtnia" data-id="${etnia?.id}"><i class="fa fa-trash"></i> </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnBorrarEtnia").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'etniaOrganizacion', action: 'borrarEtnia_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Borrado correctamente","success");
                    cargarTablaEtnias();
                }else{
                    log("Error al borrar el elemento","error")
                }
            }
        })
    });

</script>
