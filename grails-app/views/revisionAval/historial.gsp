%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%

<table class="table table-bordered table-condensed table-hover table-striped">
    <thead>
    <tr style="width: 100%">
        <th style="width: 5%">Núm.</th>
        <th style="width: 8%">Fecha</th>
%{--        <th style="width: 90px">Proyecto</th>--}%
        <th style="width: 8%">Proceso</th>
        <th style="width: 8%">Tipo</th>
        <th style="width: 8%">Requirente</th>
        <th style="width: 11%">Concepto</th>
        <th style="width: 8%">Monto</th>
        <th style="width: 8%">Estado</th>
        <th style="width: 8%">Solicitud</th>
        <th style="width: 8%"># Aval</th>
        <th style="width: 8%">F. Emisión</th>
        <th style="width: 8%">Aval</th>
    </tr>
    </thead>
</table>


<div class="row-fluid"  style="width: 99.7%;height: 300px;overflow-y: auto;float: right; margin-top: -20px">
    <div class="span12">
        <div style="width: 100%; height: 300px;">
            <table class="table table-bordered table-condensed table-hover table-striped">
                <tbody>
                <g:each in="${datos}" var="sol">
                    <tr style="width: 100%">
                        <td style="width: 5%">${sol.numero}</td>
                        <td style="width: 8%">${sol.fecha.format("dd-MM-yyyy")}</td>
%{--                        <td style="text-align: center; width: 50px" title="${sol.proceso.proyecto.toStringCompleto()}">${sol.proceso.proyecto}</td>--}%
                        <td style="width: 8%">${sol.proceso.nombre}</td>
                        <td style="width: 8%" class="${(sol.tipo == 'A') ? 'E03' : 'E02'}">${(sol.tipo == "A") ? 'Anulación' : 'Aprobación'}</td>
                        <td style="width: 8%">${sol.unidad?.nombre}</td>
                        <td style="width: 11%">${sol.concepto}</td>
                        <td style="width: 8%">
                            <g:formatNumber number="${sol.monto}" type="currency" currencySymbol=""/>
                        </td>
                        <td style="width: 8%" class="${sol.estado?.codigo}">${sol.estado?.descripcion}</td>
                        <td style="width: 8%; text-align: center">
                            <g:if test="${sol.tipo != 'A'}">
                                <a href="#" class="btn btn-info btn-xs imprimirSolicitud" iden="${sol.id}">
                                    <i class="fa fa-print"></i>
                                </a>
                            </g:if>
                        </td>
                        <td style="width: 8%">
                            <g:if test="${sol.aval}">
                                <g:if test="${sol.aval.fechaAprobacion}">
                                    ${sol.aval.fechaAprobacion?.format("yyyy")}-GP No.<elm:imprimeNumero aval="${sol.aval.id}"/>
                                </g:if>
                                <g:else>
                                    ${sol.fecha.format("yyyy")}-GP No.<elm:imprimeNumero aval="${sol.aval.id}"/>
                                </g:else>
                            </g:if>
                        </td>
                        <td style="width: 8%">
                            <g:if test="${sol.aval}">
                                ${sol.aval.fechaAprobacion?.format("dd-MM-yyyy")}
                            </g:if>
                        </td>
                        <td style="width: 8%">
                            <g:if test="${sol.aval}">
                                <a href="#" class=" btn btn-xs btn-default imprimirAval" iden="${sol?.id}">
                                    <i class="fa fa-print"></i>
                                </a>
                            </g:if>
                        </td>
                    </tr>
                </g:each>
                </tbody>
            </table>
        </div>
    </div>
</div>

<script>
    $(".imprimirAval").click(function () {
        %{--location.href = "${createLink(controller:'avales',action:'descargaAval')}/"+$(this).attr("iden")--}%
        var url = "${g.createLink(controller: 'reportes',action: 'certificacion')}/?id=" + $(this).attr("iden");
        location.href = url + "&filename=aval.pdf";
    });
    $(".imprimirSolicitud").click(function () {
        var url = "${g.createLink(controller: 'reporteSolicitud',action: 'imprimirSolicitudAval')}/?id=" + $(this).attr("iden");
        location.href = url + "&filename=solicitud.pdf";
    });
</script>