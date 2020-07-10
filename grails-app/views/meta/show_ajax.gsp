<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 10/07/20
  Time: 9:41
--%>

<div class="modal-contenido">
    <g:if test="${meta?.parroquia}">
        <div class="row">
            <div class="col-md-4 show-label">
               Parroquia
            </div>

            <div class="col-md-6">
                ${meta?.parroquia?.nombre}
            </div>

        </div>
    </g:if>

    <g:if test="${meta?.marcoLogico}">
        <div class="row">
            <div class="col-md-4 show-label">
                Actividad (Marco Lógico)
            </div>

            <div class="col-md-6">
                ${meta?.marcoLogico?.objeto}
            </div>
        </div>
    </g:if>
    <g:if test="${meta?.unidad}">
        <div class="row">
            <div class="col-md-4 show-label">
               Unidad
            </div>

            <div class="col-md-6">
                ${meta?.unidad?.descripcion}
            </div>
        </div>
    </g:if>
    <g:if test="${meta?.indicadorOrms}">
        <div class="row">
            <div class="col-md-4 show-label">
                Indicador ORMS
            </div>

            <div class="col-md-6">
                ${meta?.indicadorOrms?.descripcion}
            </div>
        </div>
    </g:if>
    <g:if test="${meta?.descripcion}">
        <div class="row">
            <div class="col-md-4 show-label">
                Descripción
            </div>

            <div class="col-md-6">
                ${meta?.descripcion}
            </div>
        </div>
    </g:if>
    <g:if test="${meta?.valor}">
        <div class="row">
            <div class="col-md-4 show-label">
                Valor
            </div>

            <div class="col-md-6">
                ${meta?.valor}
            </div>
        </div>
    </g:if>
</div>