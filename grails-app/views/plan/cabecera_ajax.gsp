<table class="table table-condensed table-bordered table-hover table-striped" id="tblCrono" style="width: 100%">
    <thead>
    <tr id="trMeses">
        <th style="width: 15%">Componentes/Actividades</th>
        <th style="width: 6%">Costo</th>
%{--
        <g:each in="${lista}" var="periodo">
            <th style="width:6%">
                ${periodo}
            </th>
        </g:each>
--}%
        <g:each in="${periodos.split('_')}" var="periodo">
            <th style="width:6%; font-size: 10px">
                ${periodo}
            </th>
        </g:each>
        <th>Total Asignado</th>
    </tr>

    </thead>
</table>

