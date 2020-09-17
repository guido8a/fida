<%@ page import="planes.FinanciamientoPlanNegocio; convenio.Garantia; seguridad.TipoInstitucion; taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

<g:if test="${!pregInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmDesembolso" controller="desembolso" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${pregInstance?.id}"/>

                <span class="col-md-12">
                    <h4 style="color: #5596ff"> Preguntas para la Encuesta según indicadores</h4>
                </span>

%{--            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'marcoLogico', 'error')} ">--}%
%{--                <span class="grupo">--}%
%{--                    <label for="marcoLogico" class="col-md-3 control-label">--}%
%{--                        Actividad--}%
%{--                    </label>--}%

%{--                    <div class="col-md-9">--}%
%{--                        <g:select id="marcoLogico" name="marcoLogico.id" from="${marcoLogico}"--}%
%{--                                  optionKey="id" optionValue="objeto" value="${pregInstance?.indicador?.marcoLogico?.id}"--}%
%{--                                  class="many-to-one form-control input-sm required"/>--}%
%{--                    </div>--}%
%{--                </span>--}%
%{--            </div>--}%

            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'indicador', 'error')} ">
                <span class="grupo">
                    <label class="col-md-2 control-label">
                        Indicador
                    </label>

                    <div class="col-md-10" id="divIndicador">
                        <g:select from="${proyectos.Indicador.list().sort{it.descripcion}}" optionKey="id" optionValue="descripcion" name="indicador"
                                  value="${pregInstance?.indicador?.id}"
                                  class="many-to-one form-control input-sm required"
                                  noSelection="${[0:'Seleccione']}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'descripcion', 'error')} ">
                <span class="grupo">
                    <label for="descripcion" class="col-md-2 control-label">
                        Descripción
                    </label>

                    <div class="col-md-10">
                        <g:textArea name="descripcion" rows="4" maxlength="255" class="form-control input-sm required"
                                    value="${pregInstance?.descripcion}" style="resize: none"/>
                    </div>
                </span>
            </div>

        </g:form>
    </div>

    <script type="text/javascript">

        %{--cargarIndicador($("#marcoLogico option:selected").val());--}%

        %{--$("#marcoLogico").change(function () {--}%
        %{--    var marco = $("#marcoLogico option:selected").val();--}%
        %{--    cargarIndicador(marco)--}%
        %{--});--}%

        %{--function cargarIndicador(marco){--}%
        %{--    $.ajax({--}%
        %{--        type: 'POST',--}%
        %{--        url: '${createLink(controller: 'pregunta', action: 'indicador_ajax')}',--}%
        %{--        data:{--}%
        %{--            marco: marco,--}%
        %{--            id: '${pregInstance?.id}'--}%
        %{--        },--}%
        %{--        success: function (msg) {--}%
        %{--            $("#divIndicador").html(msg)--}%
        %{--        }--}%
        %{--    });--}%
        %{--}--}%

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