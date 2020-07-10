<%@ page import="taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js/plugins/jquery-validation-1.13.1/dist', file: 'additional-methods.min.js')}"></script>--}%
<g:if test="${!prtlInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>


    <div id="show-parroquia" class="span5 tama" role="main">

        <form class="form-horizontal">

            <g:if test="${prtlInstance?.parroquia}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Parroquia
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.parroquia?.nombre}
                    </div>
                </div>
            </g:if>

            <g:if test="${prtlInstance?.comunidad}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Comunidad
                    </div>
                    <div class="col-md-3">
                        ${prtlInstance?.comunidad?.nombre}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.cedula}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Cédula
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.cedula}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.nombre}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Nombre
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.nombre}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.apellido}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Apellido
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.apellido}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.raza}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Raza
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.raza}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.sexo}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Sexo
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.sexo == 'M' ? 'Masculino' : 'Femenino'}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.direccion}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Dirección
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.direccion}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.telefono}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Teléfono
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.telefono}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.mail}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Mail
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.mail}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.cargo}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Cargo
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.cargo}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.titulo}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Título
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.titulo}
                    </div>
                </div>
            </g:if>
            <g:if test="${prtlInstance?.discapacidad}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Discapacitado
                    </div>
                    <div class="col-md-8">
                        ${prtlInstance?.discapacidad == '0' ? 'NO' : 'SI'}
                    </div>
                </div>
            </g:if>


        </form>
    </div>
</g:else>