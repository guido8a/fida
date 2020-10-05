<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/10/20
  Time: 9:47
--%>

<g:if test="${!categoria}">
    <elm:notFound elem="tipoCategoria" genero="o" />
</g:if>
<g:else>
    <g:if test="${categoria?.descripcion}">
        <div class="row">
            <div class="col-md-2 show-label">
                Descripción
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${categoria}" field="descripcion"/>
            </div>
        </div>
    </g:if>
</g:else>