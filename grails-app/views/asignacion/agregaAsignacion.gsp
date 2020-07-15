<g:if test="${flash.message}">
    <div class="message ui-state-highlight ui-corner-all">
        <g:message code="${flash.message}" args="${flash.args}" default="${flash.defaultMessage}"/>
    </div>
</g:if>
<g:hasErrors bean="${asignacionInstance}">
    <div class="errors ui-state-error ui-corner-all">
        <g:renderErrors bean="${asignacionInstance}" as="list"/>
    </div>
</g:hasErrors>
<g:form action="agregaAsignacionMod" class="frmAsignacion form-horizontal" method="post" enctype="multipart/form-data">
    <g:hiddenField name="padre" value="${asignacionInstance?.id}"/>
%{--    <g:if test="${dist}">--}%
%{--        <g:hiddenField name="maximo" value="${dist?.getValorReal()}"/>--}%
%{--    </g:if>--}%
%{--    <g:else>--}%
    %{--        <g:if test="${asignacionInstance.reubicada=='S'}">--}%
    %{--            <g:hiddenField name="maximo" value="${asignacionInstance?.getValorReal()}"/>--}%
    %{--        </g:if>--}%
    %{--        <g:else>--}%
        <g:hiddenField name="maximo" value="${asignacionInstance?.planificado}"/>
    %{--        </g:else>--}%
%{--    </g:else>--}%

    <div class="form-group keeptogether">
        <span class="grupo">
            <label for="fuente" class="col-md-2 control-label">
                Fuente
            </label>
            <div class="col-md-7">
                <g:select class="form-control input-sm required" name="fuente"
                          title="Fuente de financiamiento" from="${fuentes}" optionKey="id"
                          value="${asignacionInstance?.fuente?.id}" />
            </div>

        </span>
    </div>
    <div class="form-group keeptogether">
        <span class="grupo">
            <label for="fuente" class="col-md-2 control-label">
                Partida
            </label>
            <div class="col-md-7">
                %{--                <bsc:buscador name="partida" id="prsp" controlador="asignacion" accion="buscarPresupuesto" tipo="search" titulo="Busque una partida" campos="${campos}"  clase="required" />--}%

                <g:hiddenField name="partida1" value="${asignacionInstance?.presupuesto?.id}"/>
                <span class="grupo">
                    <div class="input-group input-group-sm" style="width:294px;">
                        <input type="text" class="form-control buscarPartida" name="partidaName" id="partida1Texto" data-tipo="1" value="${asignacionInstance?.presupuesto}">
                        <span class="input-group-btn">
                            <a href="#" id="btn-abrir-1" class="btn btn-info buscarPartida" data-tipo="1" title="Buscar"><span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                            </a>
                        </span>
                    </div>
                </span>
            </div>
        </span>
    </div>
    <div class="form-group keeptogether">
        <span class="grupo">
            <label for="valor" class="col-md-2 control-label">
                Valor
            </label>
            <div class="col-md-7">
                <g:textField class="form-control input-sm required money number" name="valor"
                             title="Planificado" id="vlor" style="text-align:right;padding-right: 10px;"
                             value='${asignacionInstance.planificado}'/>
            </div>

        </span>
    </div>


</g:form>
<script type="text/javascript">





    var bp

    $(document).ready(function() {
        $(".buscarPartida").click(function () {
            var tipo = $(this).data("tipo");
            if($("#presupuesto1").val() != ''){
                $.ajax({
                    type: 'POST',
                    url: '${createLink(controller: 'cronograma', action: 'buscarPartida_ajax')}',
                    data:{
                        tipo: tipo
                    },
                    success:function (msg) {
                        bp = bootbox.dialog({
                            id    : "dlgBuscarPartida",
                            title : "Buscar Partida",
                            class : "modal-lg",
                            message : msg,
                            buttons : {
                                cancelar : {
                                    label     : "Cancelar",
                                    className : "btn-primary",
                                    callback  : function () {
                                    }
                                }
                            } //buttons
                        }); //dialog
                    }
                });
            }else{
                bootbox.alert('<i class="fa fa-exclamation-triangle text-danger fa-3x"></i> ' + '<strong style="font-size: 14px">' + "Ingrese un presupuesto (1)" + '</strong>');
                return false;
            }

        });
    });

    function cerrarDialogo(){
        bp.dialog().dialog('open');
        bp.modal("hide");
    }



    var validator = $(".frmAsignacion").validate({
        errorClass     : "help-block",
        errorPlacement : function (error, element) {
            if (element.parent().hasClass("input-group")) {
                error.insertAfter(element.parent());
            } else {
                error.insertAfter(element);
            }
            element.parents(".grupo").addClass('has-error');
        },
        success        : function (label) {
            label.parents(".grupo").removeClass('has-error');
            label.remove();
        }

    });
    $(".form-control").keydown(function (ev) {
        if (ev.keyCode == 13) {
            submitForm();
            return false;
        }
        return true;
    });
</script>