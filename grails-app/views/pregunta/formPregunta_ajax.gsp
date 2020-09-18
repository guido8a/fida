<%@ page import="planes.FinanciamientoPlanNegocio; convenio.Garantia; seguridad.TipoInstitucion; taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

<g:if test="${!pregInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmPregunta" controller="pregunta" action="savePregunta_ajax" method="POST">
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
                                  />
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
            <div class="form-group keeptogether ${hasErrors(bean: pregInstance, field: 'numero', 'error')} ">
                <span class="grupo">
                    <label class="col-md-2 control-label">
                        Número
                    </label>

                    <div class="col-md-3">
                      <g:textField name="numero" value="${pregInstance?.numero}" class="form-control required" maxlength="3"/>
                    </div>
                </span>
            </div>

        </g:form>
    </div>

    <script type="text/javascript">

        $("#numero").keydown(function (ev) {
            return validarNumero(ev)
        });


        function validarNumero(ev) {
            /*
             48-57      -> numeros
             96-105     -> teclado numerico
             188        -> , (coma)
             190        -> . (punto) teclado
             110        -> . (punto) teclado numerico
             8          -> backspace
             46         -> delete
             9          -> tab
             37         -> flecha izq
             39         -> flecha der
             */
            return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
                (ev.keyCode >= 96 && ev.keyCode <= 105) ||
                ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
                ev.keyCode == 37 || ev.keyCode == 39);
        }


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