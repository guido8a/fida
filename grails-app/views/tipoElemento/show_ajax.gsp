
<%@ page import="parametros.proyectos.TipoElemento" %>

<g:if test="${!tipoElementoInstance}">
    <elm:notFound elem="TipoElemento" genero="o" />
</g:if>
<g:else>

    <g:if test="${tipoElementoInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 show-label">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoElementoInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>