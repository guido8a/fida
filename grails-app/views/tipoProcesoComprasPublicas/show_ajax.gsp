<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/10/20
  Time: 9:47
--%>

<g:if test="${!proceso}">
    <elm:notFound elem="aseguradora" genero="o" />
</g:if>
<g:else>
    <g:if test="${proceso?.descripcion}">
        <div class="row">
            <div class="col-md-2 show-label">
                Descripción
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${proceso}" field="descripcion"/>
            </div>
        </div>
    </g:if>
    <g:if test="${proceso?.sigla}">
        <div class="row">
            <div class="col-md-2 show-label">
                Sigla
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${proceso}" field="sigla"/>
            </div>
        </div>
    </g:if>
    <g:if test="${proceso?.base}">
        <div class="row">
            <div class="col-md-2 show-label">
                Base
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${proceso}" field="base"/>
            </div>
        </div>
    </g:if>
    <g:if test="${proceso?.techo}">
        <div class="row">
            <div class="col-md-2 show-label">
                Techo
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${proceso}" field="techo"/>
            </div>
        </div>
    </g:if>
</g:else>