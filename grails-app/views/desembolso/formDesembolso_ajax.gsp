<%@ page import="planes.FinanciamientoPlanNegocio; convenio.Garantia; seguridad.TipoInstitucion; taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

<g:if test="${!dsmbInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmDesembolso" controller="desembolso" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${dsmbInstance?.id}"/>
            <g:hiddenField name="convenio" value="${convenio?.id}"/>

                <span class="col-md-12">
                    <h4> Desembolso para: ${convenio?.planesNegocio?.unidadEjecutora?.nombre}</h4>
                </span>

            <div class="form-group keeptogether ${hasErrors(bean: dsmbInstance, field: 'tipoTaller', 'error')} ">
                <span class="grupo">
                    <label for="garantia" class="col-md-3 control-label">
                        Garantía
                    </label>

                    <div class="col-md-9">
                        <g:select from="${garantias}" optionKey="id" name="garantia" value="${dsmbInstance?.garantia?.id}"
                                  class="many-to-one form-control input-sm required"
                                  />
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: dsmbInstance, field: 'financiamientoPlanNegocio', 'error')} ">
                <span class="grupo">
                    <label for="financiamientoPlanNegocio" class="col-md-3 control-label">
                        Fuente de financiamiento
                    </label>

                    <div class="col-md-9">
                        <g:select id="financiamientoPlanNegocio" name="financiamientoPlanNegocio.id" from="${planes.FinanciamientoPlanNegocio.list()}"
                                  optionKey="id" optionValue="fuente" value="${dsmbInstance?.financiamientoPlanNegocio?.id}"
                                  class="many-to-one form-control input-sm required"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: dsmbInstance, field: 'descripcion', 'error')} ">
                <span class="grupo">
                    <label for="descripcion" class="col-md-3 control-label">
                        Nombre
                    </label>

                    <div class="col-md-9">
                        <g:textField name="descripcion" maxlength="63" class="form-control input-sm required"
                                     value="${dsmbInstance?.descripcion}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: dsmbInstance, field: 'fecha', 'error')} ">
                <label for="fecha" class="col-md-3 control-label">
                    Fecha
                </label>
                <span class="grupo">
                    <div class="col-md-3 ">
                        <input name="fecha" id='fecha' type='text' class="form-control required"
                               value="${dsmbInstance?.fecha?.format("dd-MM-yyyy")}"/>

                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: dsmbInstance, field: 'valor', 'error')} ">
                <span class="grupo">
                    <label for="valor" class="col-md-3 control-label">
                        Valor del desembolso
                    </label>

                    <div class="col-md-4">
                        <g:textField name="valor" class="form-control input-sm required"
                                     value="${dsmbInstance?.valor}"/>
                    </div>
                    <label class="col-md-1 control-label">
                        Máximo
                    </label>
                    <div class="col-md-3" id="valorMaximo">

                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: dsmbInstance, field: 'cur', 'error')} ">
                <span class="grupo">
                    <label for="cur" class="col-md-3 control-label">
                        CUR
                    </label>

                    <div class="col-md-9">
                        <g:textField name="cur" class="form-control input-sm allCaps required"
                                     value="${dsmbInstance?.cur}" maxlength="15"/>
                    </div>
                </span>
            </div>
%{--
            <div class="form-group keeptogether ${hasErrors(bean: dsmbInstance, field: 'observaciones', 'error')} ">
                <span class="grupo">
                    <label for="observaciones" class="col-md-3 control-label">
                        Observaciones
                    </label>

                    <div class="col-md-9">
                        <g:textArea name="observaciones" rows="2" maxlength="255" class="form-control input-sm"
                                    value="${dsmbInstance?.observaciones}" style="resize: none"/>
                    </div>
                </span>
            </div>
--}%
        </g:form>
    </div>

    <script type="text/javascript">

        cargarMaximo($("#financiamientoPlanNegocio option:selected").val());

        $("#financiamientoPlanNegocio").change(function () {
            var mx = $("#financiamientoPlanNegocio option:selected").val();
            cargarMaximo(mx)
        });

        function cargarMaximo(id){
            $.ajax({
                type: 'POST',
                url:'${createLink(controller: 'desembolso', action: 'maximo_ajax')}',
                data:{
                    id:id,
                    convenio: '${convenio?.id}',
                    desembolso: '${dsmbInstance?.id}'
                },
                success: function(msg){
                    $("#valorMaximo").html(msg)
                }
            });
        }

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