

<g:if test="${!estadoAvalInstance}">
    <elm:notFound elem="Tema" genero="o" />
</g:if>
<g:else>
    <g:if test="${estadoAvalInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${estadoAvalInstance}" field="descripcion"/>
            </div>
        </div>
    </g:if>
</g:else>