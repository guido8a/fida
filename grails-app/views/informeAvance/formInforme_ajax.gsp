<%@ page import="planes.FinanciamientoPlanNegocio; convenio.Garantia; seguridad.TipoInstitucion; taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

<g:if test="${!infoInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmInforme" controller="informeAvance" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${infoInstance?.id}"/>
            <g:hiddenField name="convenio" value="${convenio?.id}"/>

                <span class="col-md-12">
                    <h4> Informe para: ${convenio?.planesNegocio?.unidadEjecutora?.nombre}</h4>
                </span>

            <div class="form-group keeptogether ${hasErrors(bean: infoInstance, field: 'administradorConvenio', 'error')} ">
                <span class="grupo">
                    <label for="administradorConvenio" class="col-md-3 control-label">
                        Administrador del Convenio
                    </label>

                    <div class="col-md-9">
%{--
                        <g:select id="garantia" name="garantia.id" from="${convenio.Garantia.list()}"
                                  optionKey="id" value="${infoInstance?.garantia?.id}"
                                  class="many-to-one form-control input-sm required"/>
--}%
                        <g:select from="${administrador}" optionKey="id" name="administradorConvenio" value="${infoInstance?.administradorConvenio?.id}"
                                  class="many-to-one form-control input-sm required"
                                  noSelection="${[0:'Seleccione']}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: infoInstance, field: 'desembolso', 'error')} ">
                <span class="grupo">
                    <label for="administradorConvenio" class="col-md-3 control-label">
                        Desembolso
                    </label>

                    <div class="col-md-9">
                        <g:select from="${desembolso}" optionKey="id" name="desembolso" value="${infoInstance?.desembolso?.id}"
                                  class="many-to-one form-control input-sm required"
                                  noSelection="${[0:'Seleccione']}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: infoInstance, field: 'informeAvance', 'error')} ">
                <span class="grupo">
                    <label for="informeAvance" class="col-md-3 control-label">
                        Informe
                    </label>

                    <div class="col-md-9">
%{--                        <g:textField name="informeAvance" maxlength="63" class="form-control input-sm required"--}%
%{--                                     value="${infoInstance?.informeAvance}"/>--}%
                        <g:textArea name="informeAvance" rows="4" maxlength="1024" class="form-control input-sm required"
                                    value="${infoInstance?.informeAvance}" style="resize: none"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: infoInstance, field: 'dificultadesAvance', 'error')} ">
                <span class="grupo">
                    <label for="dificultadesAvance" class="col-md-3 control-label">
                        Dificultades detectadas
                    </label>

                    <div class="col-md-9">
%{--                        <g:textField name="dificultadesAvance" maxlength="63" class="form-control input-sm required"--}%
%{--                                     value="${infoInstance?.dificultadesAvance}"/>--}%
                        <g:textArea name="dificultadesAvance" rows="4" maxlength="1024" class="form-control input-sm required"
                                    value="${infoInstance?.dificultadesAvance}" style="resize: none"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: infoInstance, field: 'fecha', 'error')} ">
                <label for="fecha" class="col-md-3 control-label">
                    Fecha
                </label>
                <span class="grupo">
                    <div class="col-md-3 ">
                        <input name="fecha" id='fecha' type='text' class="form-control required"
                               value="${infoInstance?.fecha?.format("dd-MM-yyyy")}"/>

                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
%{--            </div>--}%

%{--            <div class="form-group keeptogether ${hasErrors(bean: infoInstance, field: 'porcentaje', 'error')} ">--}%
                <span class="grupo">
                    <label for="porcentaje" class="col-md-4 control-label">
                        Porcentaje de avance
                    </label>

                    <div class="col-md-2">
                        <g:textField name="porcentaje" class="form-control input-sm required"
                                     value="${infoInstance?.porcentaje}"/>
                    </div>
                </span>
            </div>
%{--
            <div class="form-group keeptogether ${hasErrors(bean: infoInstance, field: 'observaciones', 'error')} ">
                <span class="grupo">
                    <label for="observaciones" class="col-md-3 control-label">
                        Observaciones
                    </label>

                    <div class="col-md-9">
                        <g:textArea name="observaciones" rows="2" maxlength="255" class="form-control input-sm"
                                    value="${infoInstance?.observaciones}" style="resize: none"/>
                    </div>
                </span>
            </div>
--}%
        </g:form>
    </div>

    <script type="text/javascript">


        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormInforme();
                return false;
            }
            return true;
        });

        $('#fecha').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            // daysOfWeekDisabled: [0, 6],
            sideBySide: true,
            showClose: true
        });

    </script>
</g:else>