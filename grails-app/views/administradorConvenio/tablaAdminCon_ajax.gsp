<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 13/07/20
  Time: 15:42
--%>
<g:if test="${administradores.size() > 0}">
    <div class="" style="width: 99.7%;height: 100px; overflow-y: auto;float: right; margin-top: -20px">
        <table class="table-bordered table-condensed table-hover" style="width: 100%">
            <g:each in="${administradores}" var="administrador">
                <tr style="width: 100%" data-id="${administrador?.id}">
                    <td style="width: 40%">
                        ${administrador?.persona?.nombre + " " + administrador?.persona?.apellido}
                    </td>
                    <td style="width: 15%">
                        ${administrador?.fechaInicio?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 15%">
                        ${administrador?.fechaFin?.format("dd-MM-yyyy")}
                    </td>
                    <td style="width: 30%">
                        ${administrador?.observaciones}
                    </td>
                </tr>
            </g:each>
        </table>
    </div>
</g:if>
<g:else>
    <div class="alert alert-danger" style="text-align: center; margin-top: -20px">
        <strong style="color: #fdfbff"><i class='fa fa-exclamation-triangle fa-2x text-info text-shadow'></i> No existe un administrador asignado</strong>
    </div>
</g:else>

<script type="text/javascript">

    $(function () {

        $("tbody>tr").contextMenu({
            items: {
                header: {
                    label: "Acciones",
                    header: true
                },
                ver: {
                    label: "Observaciones",
                    icon: "fa fa-search",
                    action: function ($element) {
                        var id = $element.data("id");
                        $.ajax({
                            type: "POST",
                            url: "${createLink(controller:'convenio', action:'observaciones_ajax')}",
                            data: {
                                id: id
                            },
                            success: function (msg) {
                                bootbox.dialog({
                                    title: "Observaciones",
                                    message: msg,
                                    buttons: {
                                        cancelar: {
                                            label: "Aceptar",
                                            className: "btn-primary",
                                            callback: function () {
                                            }
                                        },
                                        guardar: {
                                            label: "Guardar",
                                            className: "btn-success",
                                            callback: function () {
                                                guardarObservacion(id, $("#observaciones").val())
                                            }
                                        }
                                    }
                                });
                            }
                        });
                    }
                }
            },
            onShow: function ($element) {
                $element.addClass("success");
            },
            onHide: function ($element) {
                $(".success").removeClass("success");
            }
        });

        function guardarObservacion(id, texto){
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'administradorConvenio', action: 'guardarObservacion_ajax')}',
                data:{
                    id: id,
                    texto: texto
                },
                success: function (msg) {
                    if(msg == 'ok'){
                        log("Observación guardada correctamente","success");
                        setTimeout(function () {
                            cargarTablaAdministrador();
                        }, 1000);
                    }else{
                        log("Error al guardar la observación","error")
                    }
                }
            })
        }
    });
</script>
