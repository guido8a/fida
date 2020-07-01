

<g:if test="${!fuenteInstance}">
    <elm:notFound elem="Tema" genero="o" />
</g:if>
<g:else>
    <g:if test="${fuenteInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-10">
                <g:fieldValue bean="${fuenteInstance}" field="descripcion"/>
            </div>
        </div>
    </g:if>
</g:else>