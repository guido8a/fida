<g:form class="form-horizontal" name="frmBuscarConvenio" style="overflow-y: auto">
    <div class="col-md-12" style="margin-bottom: 10px">

        <div class="col-md-1">
            <label>Buscar:</label>
        </div>
        <div class="col-md-3">
            <g:select name="buscarC" from="${[0: 'Nombre', 1: 'RUC',  2: 'Provincia', 3: 'Cantón', 4: 'Parroquia']}" class="form-control" optionValue="value" optionKey="key"/>
        </div>
        <div class="col-md-4">
            <g:textField name="txtBuscarConvenio" class="form-control" />
        </div>

        <div class="col-md-4 btn-group">
            <a href="#" class="btn btn-success" id="btnBuscadorConvenio">
                <i class="fa fa-search"></i> Buscar
            </a>
            <a href="#" class="btn btn-warning" id="btnLimpiarConvenio">
                <i class="fa fa-eraser"></i> Limpiar
            </a>
        </div>
    </div>

    <table class="table table-condensed table-bordered table-striped table-hover" style="width:100%;margin-top: 20px !important;">
        <thead style="width: 100%">
        <tr>
            <th style="width: 10%"><i class="fa fa-check"></i> </th>
            <th style="width: 30%">Organización</th>
            <th style="width: 15%">Provincia</th>
            <th style="width: 15%">Cantón</th>
            <th style="width: 15%">Parroquia</th>
            <th style="width: 15%">Fecha Inicio</th>
        </tr>
        </thead>
    </table>

    <div id="divTablaOrganizacion">

    </div>
</g:form>

<script type="text/javascript">

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode === 13) {
            $("#btnBuscadorConvenio").click();
            return false;
        }
        return true;
    });

    $("#btnLimpiarConvenio").click(function () {
        $("#txtBuscarConvenio").val('')
    });

    cargarTablaOrganizaciones($("#buscarC").val(), $("#txtBuscarConvenio").val());

    $("#btnBuscadorConvenio").click(function (){
        var operador = $("#buscarC").val();
        var texto = $("#txtBuscarConvenio").val();
        cargarTablaOrganizaciones(operador, texto);
    });

    function cargarTablaOrganizaciones(operador, texto){
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'unidadEjecutora', action: 'tablaBuscarOrga_ajax')}',
            data:{
                operador: operador,
                texto: texto,
                tipo: 1
            },
            success: function (msg) {
                dialog.modal('hide');
                $("#divTablaOrganizacion").html(msg)
            }
        });
    }

</script>