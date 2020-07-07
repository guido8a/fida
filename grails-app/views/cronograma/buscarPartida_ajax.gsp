<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 07/07/20
  Time: 11:25
--%>

<g:form class="form-horizontal" name="frmBuscarPartida" style="overflow-y: auto">
    <div class="col-md-12" style="margin-bottom: 10px">

        <div class="col-md-1">
            <label>Buscar:</label>
        </div>
        <div class="col-md-3">
            <g:select name="tipoB" from="${[0: 'Número', 1: 'Descripción']}" class="form-control" optionValue="value" optionKey="key"/>
        </div>
        <div class="col-md-4">
            <g:textField name="txtBuscar" value="${''}" class="form-control" />
        </div>

        <div class="col-md-4 btn-group">
            <a href="#" class="btn btn-success" id="btnBuscarPartida">
                <i class="fa fa-search"></i> Buscar
            </a>
            <a href="#" class="btn btn-warning">
                <i class="fa fa-eraser"></i> Limpiar
            </a>
        </div>
    </div>

    <table class="table table-condensed table-bordered table-striped table-hover" style="width:100%;margin-top: 20px !important;">
        <thead style="width: 100%">
        <th style="width: 10%"><i class="fa fa-check"></i> </th>
        <th style="width: 20%">Número</th>
        <th style="width: 70%">Descripcion</th>
        </thead>
    </table>


    <div id="divTablaPartida">

    </div>
</g:form>

<script type="text/javascript">

    cargarTablaPartida($("#tipoB").val(), $("#txtBuscar").val());

    $("#btnBuscarPartida").click(function (){
        var operador = $("#tipoB").val();
        var texto = $("#txtBuscar").val();
        cargarTablaPartida(operador, texto);
    });

    function cargarTablaPartida(operador, texto){
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'cronograma', action: 'tablaBuscarPartida_ajax')}',
            data:{
                operador: operador,
                texto: texto,
                tipo: '${tipo}'
            },
            success: function (msg) {
                dialog.modal('hide');
                $("#divTablaPartida").html(msg)
            }
        });
    }

</script>
