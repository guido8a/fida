<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/10/20
  Time: 9:47
--%>


<%@ page import="parametros.proyectos.TipoElemento" %>

<g:if test="${!aseguradora}">
    <elm:notFound elem="aseguradora" genero="o" />
</g:if>
<g:else>
    <g:if test="${aseguradora?.nombre}">
        <div class="row">
            <div class="col-md-2 show-label">
                Nombre
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${aseguradora}" field="nombre"/>
            </div>
        </div>
    </g:if>
    <g:if test="${aseguradora?.telefono}">
        <div class="row">
            <div class="col-md-2 show-label">
                Teléfono
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${aseguradora}" field="telefono"/>
            </div>
        </div>
    </g:if>
    <g:if test="${aseguradora?.mail}">
        <div class="row">
            <div class="col-md-2 show-label">
                Mail
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${aseguradora}" field="mail"/>
            </div>
        </div>
    </g:if>
    <g:if test="${aseguradora?.direccion}">
        <div class="row">
            <div class="col-md-2 show-label">
                Dirección
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${aseguradora}" field="direccion"/>
            </div>
        </div>
    </g:if>
    <g:if test="${aseguradora?.responsable}">
        <div class="row">
            <div class="col-md-2 show-label">
                Responsable
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${aseguradora}" field="responsable"/>
            </div>
        </div>
    </g:if>
    <g:if test="${aseguradora?.responsable}">
        <div class="row">
            <div class="col-md-2 show-label">
                Observaciones
            </div>
            <div class="col-md-8">
                <g:fieldValue bean="${aseguradora}" field="observaciones"/>
            </div>
        </div>
    </g:if>
</g:else>