<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 25/06/20
  Time: 10:02
--%>
<g:form class="form-horizontal" name="frmShowUnidad">


    <div class="row">
        <label class="col-md-3  text-info">
            Nombre
        </label>
        <div class="col-md-8">
            <strong style="color: #47b636">${unidad?.nombre}</strong>
        </div>
    </div>

    <g:if test="${unidad?.padre}">
        <div class="row">
            <label class="col-md-3  text-info">
                Unidad Padre
            </label>
            <div class="col-md-6">
                ${unidad?.padre?.nombre}
            </div>
        </div>
    </g:if>

    <div class="row">
        <label class="col-md-3  text-info">
            Tipo Institución
        </label>
        <div class="col-md-3">
            ${unidad?.tipoInstitucion?.descripcion}
        </div>

        <label class="col-md-2  text-info">
            Provincia
        </label>
        <div class="col-md-4">
            ${unidad?.provincia?.nombre}
        </div>
    </div>

    <div class="row">
        <label class="col-md-3  text-info">
            Código
        </label>
        <div class="col-md-3">
            ${unidad?.codigo}
        </div>

        <label class="col-md-2  text-info">
            Fecha Inicio
        </label>
        <div class="col-md-4">
            ${unidad?.fechaInicio?.format("dd-MM-yyyy")}
        </div>
    </div>
    <g:if test="${unidad?.sigla}">
        <div class="row">
            <label class="col-md-3  text-info">
                Sigla
            </label>
            <div class="col-md-3">
                ${unidad?.sigla}
            </div>
        </div>
    </g:if>
    <div class="row">
        <label class="col-md-3  text-info">
            Teléfono
        </label>
        <div class="col-md-3">
            ${unidad?.telefono}
        </div>

        <label class="col-md-2  text-info">
            Mail
        </label>
        <div class="col-md-4">
            ${unidad?.mail}
        </div>
    </div>

    <div class="row">
        <label class="col-md-3  text-info">
            Dirección
        </label>
        <div class="col-md-6">
            ${unidad?.direccion}
        </div>
    </div>
    <g:if test="${unidad?.objetivo}">
        <div class="row">
            <label class="col-md-3  text-info">
                Objetivo
            </label>
            <div class="col-md-6">
                ${unidad?.objetivo}
            </div>
        </div>
    </g:if>
    <div class="row">
        <label class="col-md-3  text-info">
            Observaciones
        </label>
        <div class="col-md-6">
            ${unidad?.observaciones}
        </div>
    </div>

</g:form>
