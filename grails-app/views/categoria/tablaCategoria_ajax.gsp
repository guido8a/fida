<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 26/08/20
  Time: 11:23
--%>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr style="width: 100%">
        <th style="width: 90%">Categoría</th>
        <th style="width: 10%"><i class="fa fa-trash"></i> </th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${categorias}" var="categoria">
        <tr style="width: 100%">
            <td style="width: 90%">${categoria?.tipoCategoria?.descripcion}</td>
            <td style="width: 10%; text-align: center">
                <a href="#" class="btn btn-danger btn-xs btnBorrarCategoria" data-id="${categoria?.id}"><i class="fa fa-trash"></i> </a>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>

<script type="text/javascript">

    $(".btnBorrarCategoria").click(function () {
        var id = $(this).data("id");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'categoria', action: 'borrarCategoria_ajax')}',
            data:{
                id: id
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Borrado correctamente","success");
                    cargarTablaCategorias();
                }else{
                    log("Error al borrar el elemento","error")
                }
            }
        })
    });

</script>