<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 08/09/20
  Time: 13:14
--%>
<%@ page import="seguridad.UnidadEjecutora"%>

<g:if test="${!beneficiario}">
    <elm:notFound elem="Nombre" genero="o"/>
</g:if>
<g:else>
    <div id="show-parroquia" class="span5 tama" role="main">

        <form class="form-horizontal">

            <g:if test="${beneficiario?.cedula}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Cédula
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.cedula}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.nombre}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Nombre
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.nombre}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.apellido}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Apellido
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.apellido}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.cargo}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Cargo
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.cargo}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.sexo}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Sexo
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.sexo == 'M' ? 'Masculino' : 'Femenino'}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.direccion}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Dirección
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.direccion}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.referencia}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Referencia
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.referencia}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.telefono}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Teléfono
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.telefono}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.mail}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Mail
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.mail}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.discapacidad}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Discapacidad
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.discapacidad == '0' ? 'NO' : 'SI'}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.fechaInicio}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Fecha Inicio
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.fechaInicio?.format("dd-MM-yyyy")}
                    </div>
                </div>
            </g:if>
            <g:if test="${beneficiario?.fechaFin}">
                <div class="row">
                    <div class="col-md-2 text-info">
                        Fecha Fin
                    </div>
                    <div class="col-md-8">
                        ${beneficiario?.fechaFin?.format("dd-MM-yyyy")}
                    </div>
                </div>
            </g:if>

        </form>
    </div>
</g:else>