<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/07/20
  Time: 13:33
--%>

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
            <g:select name="buscarP" from="${[2: 'Parroquia', 1: 'Cantón', 0: 'Provincia']}" class="form-control" optionValue="value" optionKey="key"/>
        </div>
        <div class="col-md-4">
            <g:textField name="txtBuscar" value="${''}" class="form-control" />
        </div>

        <div class="col-md-4 btn-group">
            <a href="#" class="btn btn-success" id="btnBuscarParroquia">
                <i class="fa fa-search"></i> Buscar
            </a>
            <a href="#" class="btn btn-warning" id="btnLimpiarBusqueda">
                <i class="fa fa-eraser"></i> Limpiar
            </a>
        </div>
    </div>

    <table class="table table-condensed table-bordered table-striped table-hover" style="width:100%;margin-top: 20px !important;">
        <thead style="width: 100%">
        <th style="width: 10%"><i class="fa fa-check"></i> </th>
        <th style="width: 20%">Provincia</th>
        <th style="width: 30%">Cantón</th>
        <th style="width: 40%">Parroquia</th>
        </thead>
    </table>

    <div id="divTablaParroquia">

    </div>
</g:form>

<script type="text/javascript">

    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            $("#btnBuscarParroquia").click();
            return false;
        }
        return true;
    });

    $("#btnLimpiarBusqueda").click(function () {
        $("#txtBuscar").val('')
    });

    cargarTablaParroquia($("#buscarP").val(), $("#txtBuscar").val());

    $("#btnBuscarParroquia").click(function (){
        var operador = $("#buscarP").val();
        var texto = $("#txtBuscar").val();
        cargarTablaParroquia(operador, texto);
    });

    function cargarTablaParroquia(operador, texto){
        var dialog = cargarLoader("Cargando...");
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'parroquia', action: 'tablaBuscarParroquia_ajax')}',
            data:{
                operador: operador,
                texto: texto,
                tipo: '${tipo}'
            },
            success: function (msg) {
                dialog.modal('hide');
                 $("#divTablaParroquia").html(msg)
            }
        });
    }

</script>
