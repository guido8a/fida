<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 13/07/20
  Time: 15:42
--%>


<g:form class="form-horizontal" name="frmAsignarAdmin" style="overflow-y: auto; min-height: 300px">
    <div class="col-md-12" style="margin-bottom: 10px;">
        <div class="col-md-2">
            <label>Administrador:</label>
        </div>
        <div class="col-md-3">
            <g:select name="buscarA" from="${administradores}" class="form-control" optionValue="${{it.nombre + " " + it.apellido}}" optionKey="id" noSelection="${[0: 'Seleccione...']}"/>
        </div>
        <div class="col-md-2">
            <label>Fecha de Inicio:</label>
        </div>
        <div class="col-md-3">
            <input name="fechaInicioBA" id='fechaInicioBA' type='text' class="form-control"
                   value="${new Date().format("dd-MM-yyyy")}"/>
        </div>

        <div class="col-md-1 btn-group">
            <a href="#" class="btn btn-success" id="btnAgregarAdmin">
                <i class="fa fa-plus"></i> Agregar
            </a>

        </div>
    </div>

    <table class="table table-condensed table-bordered table-striped table-hover" style="width:100%;margin-top: 20px !important;">
        <thead style="width: 100%">
        <th style="width: 40%">Nombre</th>
        <th style="width: 15%">Fecha Inicio</th>
        <th style="width: 15%">Fecha Fin</th>
        <th style="width: 30%">Observaciones</th>
%{--        <th style="width: 10%"><i class="fa fa-check"></i> </th>--}%
        </thead>
    </table>

    <div id="divTablaAdmin">

    </div>
</g:form>

<script type="text/javascript">

    $('#fechaInicioBA').datetimepicker({
        locale: 'es',
        format: 'DD-MM-YYYY',
        daysOfWeekDisabled: [0, 6],
        sideBySide: true,
        showClose: true
    });

    $("#btnAgregarAdmin").click(function () {
        var i = $("#buscarA").val();
        if(i == 0){
            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning text-shadow'></i> <strong style='font-size: 14px'>Seleccione un administrador!</strong>");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                url:'${createLink(controller: 'administradorConvenio', action: 'guardarAdministrador_ajax')}',
                data: {
                    id: '${convenio?.id}',
                    persona: $("#buscarA").val(),
                    fechaInicio: $("#fechaInicioBA").val()
                },
                success: function (msg) {
                    if(msg == 'ok'){
                        log("Administrador asignado correctamente","success");
                        cargarTablaAdministrador();
                    }else{
                        log("Error al asignar el administrador","error")
                    }
                }
            })

        }
    });

    cargarTablaAdministrador();

    function cargarTablaAdministrador(){
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'administradorConvenio', action: 'tablaAdminCon_ajax')}',
            data:{
                id: '${convenio?.id}'
            },
            success: function (msg) {
                dialog.modal('hide');
                $("#divTablaAdmin").html(msg)
            }
        });
    }

</script>