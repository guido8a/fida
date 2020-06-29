<%@ page import="bitacora.Base" %>

<style type="text/css">

    .texto-verde {
        color: #186063;
    }
    .texto-azul {
        color: #1d63b0;
        font-weight: bold;
    }
</style>


<g:if test="${!baseInstance}">
    <elm:notFound elem="Base" genero="o" />
</g:if>
<g:else>

    <g:if test="${baseInstance?.problema}">
        <div class="alert alert-dismissible alert-success" style="font-size: 16px;">
            <strong>Problema:</strong>
            ${baseInstance?.problema}
        </div>
    </g:if>

    <g:if test="${baseInstance?.solucion}">
        <div class="alert alert-dismissible alert-info" style="font-size: 15px;">
            <strong>Solución:</strong>
            ${baseInstance?.solucion}
        </div>
    </g:if>

    <g:if test="${lista.size() > 0}">
        <div class="alert alert-dismissible alert-warning" style="font-size: 15px;">
            <i class="fa fa-2x fa-exclamation-triangle"></i>  Este tema contiene <strong>${lista.size()}</strong> imágenes o archivos asociados.
        </div>
    </g:if>


    <div class="row" style="margin-bottom: 10px">
        <strong style="margin-left: 15px">Algoritmo:</strong>
        <div class="col-xs-12" style="background: #eeeeee; max-height: 400px; overflow: auto; padding: 20px;">
            <util:renderHTML html="${baseInstance.algoritmo}"/>
        </div>
    </div>

    <g:if test="${baseInstance?.clave}">
        <div class="row">
            <div class="col-md-12 texto-verde">
                <strong>Palabras Clave</strong>: <g:fieldValue bean="${baseInstance}" field="clave"/>
            </div>
        </div>
    </g:if>

    <g:if test="${baseInstance?.referencia}">
        <div class="row">
            <div class="col-md-1" style="font-weight: bolder">
                Referencias:
            </div>

            <div class="col-md-11 texto-azul">
                <util:separar urls="${baseInstance.referencia}"/>
            </div>

        </div>
    </g:if>
    
    <g:if test="${baseInstance?.observacion}">
        <div class="row">
            <div class="col-md-12">
                <strong>Observaciones:</strong> <g:fieldValue bean="${baseInstance}" field="observacion"/>
            </div>
            
        </div>
    </g:if>
    
    <g:if test="${baseInstance?.fecha}">
        <div class="row">
            <div class="col-md-12" style="text-align: right">
                Creado el <g:formatDate date="${baseInstance?.fecha}" format="dd-MMM-yyyy" />
                por: ${baseInstance?.persona?.nombre} ${baseInstance?.persona?.apellido},
                dentro del tema: <span class="texto-verde"> "${baseInstance?.tema?.encodeAsHTML()}"</span>
            </div>
            
        </div>
    </g:if>
    
</g:else>