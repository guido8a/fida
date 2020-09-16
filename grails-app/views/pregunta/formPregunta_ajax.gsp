<%@ page import="planes.FinanciamientoPlanNegocio; convenio.Garantia; seguridad.TipoInstitucion; taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

<g:if test="${!pregInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmDesembolso" controller="desembolso" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${pregInstance?.id}"/>

                <span class="col-md-12">
                    <h4> Preguntas para la Encuesta del Indicadores del Marco Lógico</h4>
                </span>

            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'indicador', 'error')} ">
                <span class="grupo">
                    <label for="indicador" class="col-md-3 control-label">
                        Indicador
                    </label>

                    <div class="col-md-9">
                        <g:select from="${indicadores}" optionKey="id" name="indicador" value="${pregInstance?.indicador?.id}"
                                  class="many-to-one form-control input-sm required"
                                  noSelection="${[0:'Seleccione']}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'financiamientoPlanNegocio', 'error')} ">
                <span class="grupo">
                    <label for="financiamientoPlanNegocio" class="col-md-3 control-label">
                        Fuente de financiamiento
                    </label>

                    <div class="col-md-9">
                        <g:select id="financiamientoPlanNegocio" name="financiamientoPlanNegocio.id" from="${planes.FinanciamientoPlanNegocio.list()}"
                                  optionKey="id" optionValue="fuente" value="${pregInstance?.financiamientoPlanNegocio?.id}"
                                  class="many-to-one form-control input-sm required"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'descripcion', 'error')} ">
                <span class="grupo">
                    <label for="descripcion" class="col-md-3 control-label">
                        Nombre
                    </label>

                    <div class="col-md-9">
                        <g:textField name="descripcion" maxlength="63" class="form-control input-sm required"
                                     value="${pregInstance?.descripcion}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'fecha', 'error')} ">
                <label for="fecha" class="col-md-3 control-label">
                    Fecha
                </label>
                <span class="grupo">
                    <div class="col-md-3 ">
                        <input name="fecha" id='fecha' type='text' class="form-control required"
                               value="${pregInstance?.fecha?.format("dd-MM-yyyy")}"/>

                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'valor', 'error')} ">
                <span class="grupo">
                    <label for="valor" class="col-md-3 control-label">
                        Valor del desembolso
                    </label>

                    <div class="col-md-4">
                        <g:textField name="valor" class="form-control input-sm required"
                                     value="${pregInstance?.valor}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'cur', 'error')} ">
                <span class="grupo">
                    <label for="cur" class="col-md-3 control-label">
                        CUR
                    </label>

                    <div class="col-md-9">
                        <g:textField name="cur" class="form-control input-sm allCaps required"
                                     value="${pregInstance?.cur}" maxlength="15"/>
                    </div>
                </span>
            </div>
%{--
            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'observaciones', 'error')} ">
                <span class="grupo">
                    <label for="observaciones" class="col-md-3 control-label">
                        Observaciones
                    </label>

                    <div class="col-md-9">
                        <g:textArea name="observaciones" rows="2" maxlength="255" class="form-control input-sm"
                                    value="${pregInstance?.observaciones}" style="resize: none"/>
                    </div>
                </span>
            </div>
--}%
        </g:form>
    </div>

    <script type="text/javascript">


        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormDesembolso();
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