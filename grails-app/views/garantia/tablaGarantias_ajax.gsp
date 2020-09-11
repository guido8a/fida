<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 11/09/20
  Time: 11:22
--%>

<table class="table table-condensed table-hover table-striped table-bordered">
    <thead>
    <tr style="width: 100%">
        <th style="width: 25%">Tipo</th>
        <th style="width: 10%">N.Garantía</th>
        <th style="width: 20%">Aseguradora</th>
        <th style="width: 20%">Documento</th>
        <th style="width: 5%">Estado</th>
        <th style="width: 5%">Emision</th>
        <th style="width: 5%">Vencimiento</th>
        <th style="width: 5%">Monto</th>
        <th style="width: 5%"></th>
    </tr>
    </thead>
</table>
<div class="" style="width: 99.7%;height: 320px; overflow-y: auto;float: right; margin-top: -20px">
    <table class="table-bordered table-condensed table-hover" style="width: 100%">
        <tbody>
        <g:each in="${garantias}" var="garantia">
            <tr style="width: 100%">
                <td style="width:25%">${garantia?.tipoGarantia?.descripcion}</td>
                <td style="width:10%">${garantia?.codigo}</td>
                <td style="width:20%">${garantia?.aseguradora?.nombre}</td>
                <td style="width:20%">${garantia?.tipoDocumentoGarantia?.descripcion}</td>
                <td style="width:5%">${garantia?.estado?.descripcion}</td>
                <td style="width:5%">${garantia?.fechaInicio?.format("dd-MM-yyyy")}</td>
                <td style="width:5%">${garantia?.fechaFinalizacion?.format("dd-MM-yyyy")}</td>
                <td style="width:5%"><g:formatNumber number="${garantia?.monto}" minFractionDigits="2" maxFractionDigits="2"/></td>
                <td style="width:5%"></td>
            </tr>
        </g:each>
        </tbody>
    </table>
</div>