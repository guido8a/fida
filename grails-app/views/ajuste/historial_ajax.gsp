<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 24/06/15
  Time: 10:22 AM
--%>

<script src="${resource(dir: 'js', file: 'ui.js')}"></script>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr style="width: 100%">
        <th style="width: 10%;">Solicita</th>
        <th style="width: 10%;">Fecha</th>
        <th style="width: 40%;">Concepto</th>
        <th style="width: 10%;">Tipo</th>
        <th style="width: 10%;">Estado</th>
        <th style="width: 10%;">Ver</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${reformas}" var="reforma">
        <tr>
            <td style="width: 10%;">${reforma.persona.unidadEjecutora} - ${reforma.persona}</td>
            <td style="width: 10%;">${reforma.fecha.format("dd-MM-yyyy")}</td>
            <td style="width: 40%;">${reforma.concepto}</td>
            <td style="width: 10%;">
                <elm:tipoReforma reforma="${reforma}"/>
            </td>
            <td style="width: 10%;" class="${reforma.estado.codigo}">${reforma.estado.descripcion}</td>
            <td style="width: 10%; text-align: center">
                <div class="btn-group-xs" role="group">
                    <elm:linkPdfReforma reforma="${reforma}"/>
                </div>
            </td>
        </tr>
    </g:each>
    </tbody>
</table>