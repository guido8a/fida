<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 26/01/15
  Time: 12:41 PM
--%>

<div class="fila">
    <input type="hidden" id="maxAvance">
    <input type="hidden" id="idAvance">

    <div class="form-group keeptogether">
        <span class="grupo">
            <span class="grupo">
                <label for="avance" class="col-md-1 control-label">
                    Aporte
                </label>
                <div class="col-md-2">
                    <div class="input-group input-group-sm">
                    <g:field type="text" name="avance" id="avanceAvance" maxlength="3" class="form-control input-sm unique noEspacios required"/>
                    <span class="input-group-addon"><i class="fa fa-percent"></i> </span>
                    </div>
                </div>
            </span>
        </span>
    </div>
    <div class="form-group keeptogether">
        <span class="grupo">
            <label class="col-md-1 control-label">Fecha:</label>
            <div class="col-md-2">
               <strong style="font-size: 14px; color: #5596ff">${new java.util.Date().format("dd/MM/yyyy")}</strong>
            </div>
        </span>
    </div>
</div>
<div class="form-group keeptogether">
    <span class="grupo">
        <label class="col-md-1 control-label">Descripción:</label>
        <div class="col-md-10">
            <g:textArea name="descripcionAvance" class="form-control required" style="resize: none" maxlength="255"/>
        </div>
    </span>
</div>

<fieldset style="width:95%;margin-top: 15px;">
    <legend>Avances registrados</legend>
    <table class="table table-condensed table-bordered table-striped table-hover">
        <thead>
        <tr>
            <th>
                Fecha
            </th>
            <th>
                Descripción
            </th>
            <th>
                Avance
            </th>
        </tr>
        </thead>
        <tbody>

        <g:each in="${avances}" var="a">
            <tr>
                <td style="text-align: center">
                    ${a.fecha.format("dd/MM/yyyy")}
                </td>
                <td>
                    ${a.descripcion}
                </td>
                <td style="text-align: right;">
                    <g:formatNumber number="${a.avance}" minFractionDigits="2" maxFractionDigits="2"/>%
                </td>
            </tr>
        </g:each>
        <tr>
            <td colspan="2" style="text-align: right;font-weight: bold">Avance total:</td>
            <g:if test="${avances.size() > 0}">
                <td style="text-align: right;font-weight: bold"><g:formatNumber number="${avances.pop().avance}" minFractionDigits="2" maxFractionDigits="2"/>%</td>
            </g:if>
            <g:else>
                <td style="text-align: right;font-weight: bold"><g:formatNumber number="0" minFractionDigits="2" maxFractionDigits="2"/>%</td>
            </g:else>
        </tr>
        </tbody>
    </table>
</fieldset>