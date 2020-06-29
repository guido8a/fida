
<%@ page import="bitacora.Tema" %>

<g:if test="${!temaInstance}">
    <elm:notFound elem="Tema" genero="o" />
</g:if>
<g:else>

    <g:if test="${temaInstance?.nombre}">
        <div class="row">
            <div class="col-md-2 text-info">
                Nombre
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${temaInstance}" field="nombre"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>