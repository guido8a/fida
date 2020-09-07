<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 20/08/20
  Time: 10:19
--%>

<table id="tblFinanciamiento" class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr>
        <th>Fuente</th>
        <th>Monto</th>
        <th>Procentaje</th>
        <th>Eliminar</th>
    </tr>
    </thead>
    <tbody id="tbFin">
    <g:set var="suma" value="${0}"/>
    <g:set var="prct" value="${0}"/>
    <g:each in="${financiamientos}" status="i" var="fin">
        <g:set var="suma" value="${suma + fin.valor}"/>
        <g:set var="finPorcentaje" value="${(fin.valor * 100) / plan?.costo}"/>
        <g:set var="prct" value="${prct + finPorcentaje}"/>
        <tr data-fuente="${fin.financiamientoPlanNegocio.fuente.id}">
            <td>
                ${fin.financiamientoPlanNegocio.fuente.descripcion}
            </td>
            <td class="text-right">
                <g:formatNumber number="${fin.valor}" type="currency" currencySymbol=""/>
            </td>
            <td class="text-right">
                <g:formatNumber number="${finPorcentaje / 100}" type="percent"
                                minFractionDigits="2"
                                maxFractionDigits="2"/>
            </td>
            <td class="text-center">
                <a id="${fin.id}" href="#" class="btn btn-xs btn-danger btnBorrarFuente">
                    <i class="fa fa-trash"></i>
                </a>
            </td>
        </tr>
    </g:each>
    </tbody>
    <tfoot>
    <tr>
        <th class="text-center">
            TOTAL
        </th>
        <th class="text-right" id="tfSuma">
            <g:formatNumber number="${suma}" type="currency" currencySymbol=""/>
        </th>
        <th class="text-right" id="tfPorc">
            <g:formatNumber number="${prct / 100}" type="percent" minFractionDigits="2"
                            maxFractionDigits="2"/>
        </th>
        <th></th>
    </tr>
    </tfoot>
</table>

<script type="text/javascript">
    var total = parseFloat("${plan?.costo}");
    var suma = parseFloat("${suma}");
    var restante = total - suma;
    $(function () {
        setSuma(suma);
        setRestante(restante);
        $(".btnBorrarFuente").click(function () {
            var id = $(this).attr("id");
            bootbox.confirm("<i class='fa fa-exclamation-triangle fa-3x pull-left text-danger text-shadow'></i> ¿Está seguro de querer eliminar esta fuente de financiamiento?", function (res) {
                if(res){
                    $.ajax({
                        type    : "POST",
                        url     : "${createLink(controller:'plan', action:'borrarFuente_ajax')}",
                        data    : {
                            id : id
                        },
                        success : function (msg) {
                            if(msg == 'ok'){
                                log("Fuente borrada correctamente","success");
                                reloadTabla();
                                cargarDisponible($("#fuente option:selected").val());
                            }else{
                                log("Error al borrar la fuente","error");
                            }
                        }
                    });
                }
            });
        });
    });
</script>