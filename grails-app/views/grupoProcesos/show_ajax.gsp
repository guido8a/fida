
<%@ page import="parametros.proyectos.GrupoProcesos" %>

<g:if test="${!grupoProcesosInstance}">
    <elm:notFound elem="GrupoProcesos" genero="o" />
</g:if>
<g:else>

    <g:if test="${grupoProcesosInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 show-label">
                Descripcion
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${grupoProcesosInstance}" field="descripcion"/>
            </div>
            
        </div>
    </g:if>
    
</g:else>