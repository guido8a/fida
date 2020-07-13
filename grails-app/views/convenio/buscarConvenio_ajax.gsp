<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 13/07/20
  Time: 12:22
--%>


<g:form class="form-horizontal" name="frmBuscarConvenio" style="overflow-y: auto">
    <div class="col-md-12" style="margin-bottom: 10px">

        <div class="col-md-1">
            <label>Buscar:</label>
        </div>
        <div class="col-md-3">
            <g:select name="buscarC" from="${[0: 'Nombre', 1: 'Código', 2: 'Organización', 3: 'Parroquia']}" class="form-control" optionValue="value" optionKey="key"/>
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
        <th style="width: 10%"><i class="fa fa-check"></i> </th>
        <th style="width: 20%">Parroquia</th>
        <th style="width: 10%">Código</th>
        <th style="width: 30%">Nombre</th>
        <th style="width: 15%">Organización</th>
        <th style="width: 15%">Fecha Inicio</th>
        </thead>
    </table>

    <div id="divTablaConvenios">

    </div>
</g:form>

<script type="text/javascript">

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            $("#btnBuscarConvenio").click();
            return false;
        }
        return true;
    });

    $("#btnLimpiarConvenio").click(function () {
        $("#txtBuscarConvenio").val('')
    });

    cargarTablaConvenio($("#buscarC").val(), $("#txtBuscarConvenio").val());

    $("#btnBuscadorConvenio").click(function (){
        var operador = $("#buscarC").val();
        var texto = $("#txtBuscarConvenio").val();
        cargarTablaConvenio(operador, texto);
    });

    function cargarTablaConvenio(operador, texto){
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'convenio', action: 'tablaBuscarConvenio_ajax')}',
            data:{
                operador: operador,
                texto: texto
            },
            success: function (msg) {
                dialog.modal('hide');
                $("#divTablaConvenios").html(msg)
            }
        });
    }

</script>