<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 12/07/19
  Time: 12:36
--%>


<style type="text/css">
table {
    table-layout: fixed;
    overflow-x: scroll;
}
th, td {
    overflow: hidden;
    text-overflow: ellipsis;
    word-wrap: break-word;
}
</style>



<div class="" style="width: 99.7%;height: ${lista ? (bandera ? '350px' : '585px') : '100px'}; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" width="100%">

        <g:if test="${lista}">
            <g:each in="${lista.name}" var="registro">
                <tr>
                    <td width="240px" style="font-size: 14px">
                        ${registro}
                    </td>

                    <td width="120px">
                        <g:if test="${registro.split("\\.")[1] == 'pdf'}">
                            PDF
                        </g:if>
                        <g:else>
                            <g:if test="${registro.split("\\.")[1] in ['jpeg', 'jpg', 'png']}">
                                Imagen
                            </g:if>
                            <g:else>
                                Otro
                            </g:else>
                        </g:else>
                    </td>

                    <g:if test="${!bandera}">
                        <td width="30px" class="text-info" style="text-align: center">
                            <a href="#" class="btn btn-danger btn-sm btnBorrarArchivo" data-nombre="${registro}" title="Eliminar archivo"><i class="fa fa-times-circle"></i></a>
                        </td>
                    </g:if>

                    <td width="30px" class="text-info" style="text-align: center">
                        <g:link controller="base" action="retornarArchivo" params="[nombre: registro]" id="${base}"
                                class="btn btnDescargar  btn-info btn-sm" title="Descargar archivo">
                            <i class="fa fa-download"></i>
                        </g:link>
                    </td>
                </tr>
            </g:each>
        </g:if>
        <g:else>
            <div class="alert alert-info">No tiene documentos adjuntos</div>
        </g:else>

    </table>
</div>

<script type="text/javascript">

    $(".btnBorrarArchivo").click(function () {
        var id = '${base}';
        var nombre = $(this).data("nombre");

        bootbox.confirm({
            message: "<i class='fa fa-3x fa-exclamation-triangle text-danger'></i> <strong style='font-size: 14px'>  Está seguro de eliminar este archivo? </strong>",
            buttons: {
                confirm: {
                    label: 'Borrar',
                    className: 'btn-success'
                },
                cancel: {
                    label: 'Cancelar',
                    className: 'btn-danger'
                }
            },
            callback: function (result) {
                if(result){
                    $.ajax({
                        type: 'POST',
                        url: '${createLink(controller: 'base', action: 'borrarArchivo')}',
                        data:{
                            id: id,
                            nombre: nombre
                        },
                        success: function (msg){
                            if(msg == 'ok'){
                                log("Archivo eliminado correctamente","success");
                                setTimeout(function () {
                                    cargarArchivos('${base}', '${lista}');
                                    cargarCarrusel(${base})
                                    location.reload();
                                }, 800);
                            }else{
                                log("Error al eliminar el archivo", "error")
                            }
                        }
                    });
                }
            }
        });
    });


</script>
