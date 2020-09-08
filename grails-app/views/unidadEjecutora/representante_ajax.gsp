<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/09/20
  Time: 9:54
--%>

<g:form class="form-horizontal" name="frmAsignarRepresentante" style="overflow-y: auto; min-height: 300px">
    <div class="col-md-12" style="margin-bottom: 10px;">
        <div class="col-md-2">
            <label>Representante:</label>
        </div>
        <div class="col-md-5">
            <g:select name="buscarA" from="${lista}" class="form-control" optionValue="${{it.nombre + " " + it.apellido}}" optionKey="id" noSelection="${[0: 'Seleccione...']}"/>
        </div>
        <div class="col-md-2">
            <label>Fecha de Inicio:</label>
        </div>
        <div class="col-md-2" style="margin-left: -30px">
            <input name="fechaInicioBA" id='fechaInicioBA' type='text' class="form-control"
                   value="${new Date().format("dd-MM-yyyy")}"/>
        </div>
        <div class="col-md-1 btn-group">
            <a href="#" class="btn btn-success" id="btnAgregarRep">
                <i class="fa fa-plus"></i> Agregar
            </a>
        </div>
    </div>

    <table class="table table-condensed table-bordered table-striped table-hover" style="width:100%;margin-top: 20px !important;">
        <thead style="width: 100%">
        <th style="width: 36%">Nombre</th>
        <th style="width: 12%">Fecha Inicio</th>
        <th style="width: 12%">Fecha Fin</th>
        <th style="width: 20%">Mail</th>
        <th style="width: 20%">Teléfono</th>
%{--        <th style="width: 5%"><i class="fa fa-trash"></i> </th>--}%
        </thead>
    </table>

    <div id="divTablaRep">

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

    cargarTablaRepresentante();

    function cargarTablaRepresentante(){
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'unidadEjecutora', action: 'tablaRepresentante_ajax')}',
            data:{
                id: '${unidad?.id}'
            },
            success: function (msg) {
                dialog.modal('hide');
                $("#divTablaRep").html(msg)
            }
        });
    }

    $("#btnAgregarRep").click(function () {
        var i = $("#buscarA").val();
        if(i == 0){
            bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning text-shadow'></i> <strong style='font-size: 14px'>Seleccione un representante!</strong>");
            return false;
        }else{
            $.ajax({
                type: 'POST',
                url:'${createLink(controller: 'unidadEjecutora', action: 'guardarRepresentante_ajax')}',
                data: {
                    id: '${unidad?.id}',
                    persona: $("#buscarA").val(),
                    fechaInicio: $("#fechaInicioBA").val()
                },
                success: function (msg) {
                    if(msg == 'ok'){
                        log("Representante asignado correctamente","success");
                        cargarTablaRepresentante();
                    }else{
                        // if(msg == 'er'){
                        //     bootbox.alert("<i class='fa fa-exclamation-triangle fa-2x text-warning text-shadow'></i> <strong style='font-size: 14px'>Ya se encuentra asignado un representante!</strong>");
                        //     return false;
                        // }else{
                            log("Error al asignar el representante","error")
                        // }
                    }
                }
            })

        }
    });
</script>