<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 11/09/20
  Time: 11:22
--%>

<style>
table
{
    table-layout: fixed;
    width: 100%;
}
</style>

<div>
    <table class="table table-condensed table-hover table-striped table-bordered">
        <thead>
        <tr style="width: 100%">
            <th style="width: 14%">Tipo</th>
            <th style="width: 18%">N.Garantía</th>
            <th style="width: 20%">Aseguradora</th>
            <th style="width: 12%">Documento</th>
            <th style="width: 7%">Estado</th>
            <th style="width: 7%">Emision</th>
            <th style="width: 7%">Vencimiento</th>
            <th style="width: 8%">Monto</th>
            <th style="width: 8%"></th>
        </tr>
        </thead>
    </table>
</div>

<div class="" style="width: 100%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${garantias}" var="garantia">
            <tr style="width: 100%">
                <td style="width:14%">${garantia?.tipoGarantia?.descripcion}</td>
                <td style="width:18%">${garantia?.codigo}</td>
                <td style="width:20%">${garantia?.aseguradora?.nombre}</td>
                <td style="width:12%">${garantia?.tipoDocumentoGarantia?.descripcion}</td>
                <td style="width:7%; background-color: ${garantia?.estado?.descripcion == 'Vigente' ? '#78B665' : garantia?.estado?.descripcion == 'Renovada' ? '#C19345' : ''}">${garantia?.estado?.descripcion}</td>
                <td style="width:7%">${garantia?.fechaInicio?.format("dd-MM-yyyy")}</td>
                <td style="width:7%">${garantia?.fechaFinalizacion?.format("dd-MM-yyyy")}</td>
                <td style="width:8%;text-align: right"><g:formatNumber number="${garantia?.monto}" minFractionDigits="2" maxFractionDigits="2"/></td>
                <td style="width:8%; text-align: center">
                    <g:if test="${garantia?.estado?.descripcion == 'Vigente'}">
                        <a href="#" class="btn btn-success btn-xs btnEditar" title="Editar garantía" data-id="${garantia?.id}"><i class="fa fa-edit"></i> </a>
                        <a href="#" class="btn btn-warning btn-xs btnRenovar" title="Renovar garantía" data-id="${garantia?.id}"><i class="fa fa-redo"></i> </a>
                    </g:if>
                </td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>

<script type="text/javascript">

    function grt(id, tipo){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'garantia', action: 'retornaGarantia')}',
            data:{
                id: id
            },
            success: function (msg) {
                var parts = msg.split("_");
                $("#tipo").val(tipo)
                $("#diasGarantizados").val(parts[0])
                $("#dg").val(parts[0])
                $("#fechaFinalizacion").val(parts[1])
                $("#fechaEmision").val(parts[2])
                $("#monto").val(parts[3])
                $("#codigo").val(parts[4])
                $("#padre").val(parts[5] != 'null' ? parts[5] : '');
                $("#estadoGarantia").val(parts[6])
                $("#aseguradora").val(parts[7])
                $("#tipoDocumentoGarantia").val(parts[8])
                $("#tipoGarantia").val(parts[9])
                $("#id").val(parts[10])
                if(tipo == 'renew'){
                    $(".btnRenovarGarantia").removeClass('hidden');
                    $(".btnEditarGarantia").addClass('hidden');
                    $(".btnAgregarGarantia").addClass('hidden');
                }else{
                    if(tipo == 'edit'){
                        $(".btnRenovarGarantia").addClass('hidden');
                        $(".btnEditarGarantia").removeClass('hidden');
                        $(".btnAgregarGarantia").addClass('hidden');
                    }else{
                        $(".btnRenovarGarantia").addClass('hidden');
                        $(".btnEditarGarantia").addClass('hidden');
                        $(".btnAgregarGarantia").removeClass('hidden');
                    }
                }

            }
        })
    }

    $(".btnEditar").click(function () {
        var id = $(this).data("id");
        grt(id,"edit")
    });

    $(".btnRenovar").click(function () {
        var id = $(this).data("id");
        grt(id,"renew")
    });



</script>