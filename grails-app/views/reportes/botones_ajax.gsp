<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 22/03/22
  Time: 11:06
--%>

<div class="row" style="text-align: center">
    <button class="btn btn-info" id="btnSeleccionarOrg"><i class="fa fa-search-plus"></i> Seleccionar organización</button>
    <button class="btn btn-info" id="btnTodasOrg"><i class="fa fa-building"></i>Todas las organizaciones</button>
</div>

<script type="text/javascript">

    $("#btnTodasOrg").click(function () {
        location.href="${createLink(controller: 'reportes', action: 'reporteTalleresOrganizacionesExcel')}";
    });

    $("#btnSeleccionarOrg").click(function () {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'organizaciones_ajax')}',
            data:{
                tipo: 2
            },
            success: function (msg) {
                dialogoOrganizacion = bootbox.dialog({
                    id    : "dlOrganizacion",
                    title : "Seleccione una Organización",
                    message : msg,
                    buttons : {
                        cancelar : {
                            label     : "Cancelar",
                            className : "btn-primary",
                            callback  : function () {
                            }
                        }
                    } //buttons
                }); //dialog
            }
        })
    });

</script>