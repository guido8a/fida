
<%@ page import="parametros.convenios.TipoEvaluacion" %>

<g:if test="${!tipoEvaluacionInstance}">
    <elm:notFound elem="TipoEvaluacion" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoEvaluacionInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 show-label">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoEvaluacionInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>