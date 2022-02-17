<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 16/02/22
  Time: 15:33
--%>

<div class="" style="width: 97.7%;height: 420px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${beneficiarios}" var="beneficiario">
            <tr data-id="${beneficiario.id}" style="width: 100%">
                <td style="width: 20%">${beneficiario.cedula}</td>
                <td style="width: 35%"><elm:textoBusqueda busca="${params.search}">${beneficiario.nombre}</elm:textoBusqueda></td>
                <td style="width: 35%"><elm:textoBusqueda busca="${params.search}">${beneficiario.apellido}</elm:textoBusqueda></td>
                <td style="width: 10%">
                    <div class="form-check form-check-inline">
                        <input class="form-check-input btnAsistencia" type="checkbox" id="asis" data-id="${beneficiario.id}" ${taller.Asiste.findByPersonaOrganizacionAndTaller(beneficiario, taller) ? 'checked' : ''}
                               name="asis_anme">
                    </div>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    $(function () {
        $.switcher('input[type=checkbox]');


        $(".btnAsistencia").click(function () {
            var dg = cargarLoader("Cargando...");
            var id = $(this).data("id");
            var estado = 0
            if ($(this).prop('checked') == false) {
                estado = 0
            }else{
                estado = 1
            }

            $.ajax({
               type: 'POST',
                url: '${createLink(controller: 'asiste', action: 'guardarAsistente_ajax')}',
                data:{
                    id: id,
                    taller: '${taller?.id}',
                    estado: estado
                },
                success: function (msg) {
                    dg.modal("hide");
                    if(msg == 'ok'){
                        log("Asistente agregado correctamente","success")
                        reloadTablaTaller();
                    }else{
                        if(msg == 'er'){
                            log("Asistente removido correctamente","success");
                            reloadTablaTaller();
                        }else{
                            log("Error al agregar el asistente","error")
                        }
                    }
                }
            });

            console.log("click " + id + " " + estado)
        })


    });

</script>