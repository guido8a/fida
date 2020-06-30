

<g:if test="${!tipoInstitucionInstance}">
    <elm:notFound elem="Tema" genero="o" />
</g:if>
<g:else>
    <g:if test="${tipoInstitucionInstance?.descripcion}">
        <div class="row">
            <div class="col-md-2 text-info">
                Descripción
            </div>
            
            <div class="col-md-3">
                <g:fieldValue bean="${tipoInstitucionInstance}" field="descripcion"/>
            </div>
        </div>
    </g:if>
</g:else>