<%@ page import="seguridad.TipoInstitucion; seguridad.UnidadEjecutora" %>

<g:if test="${!convenioInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmConvenio" controller="convenio" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${convenioInstance?.id}"/>

            <div class="form-group keeptogether ${hasErrors(bean: convenioInstance, field: 'parroquia', 'error')} ">
                <span class="grupo">
                    <label for="parroquia" class="col-md-3 control-label">
                        Parroquia
                    </label>
                    <div class="col-md-9">
                        <g:hiddenField name="parroquia" id="parroquia" value="${convenioInstance?.parroquia?.id}"/>
                        <span class="grupo">
                            <div class="input-group input-group-sm" >
                                <input type="text" class="form-control buscarParroquia" name="parroquiaName"
                                       id="parroquiaTexto" value="${lugar}">
                                <span class="input-group-btn">
                                    <a href="#" class="btn btn-info buscarParroquia" title="Buscar Parroquia">
                                        <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                    </a>
                                </span>
                            </div>
                        </span>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: convenioInstance, field: 'unidadEjecutora', 'error')} ">
                <span class="grupo">
                    <label for="unidadEjecutora" class="col-md-3 control-label">
                        Organización
                    </label>

                    <div class="col-md-9">
                        <g:select id="unidadEjecutora" name="unidadEjecutora.id"
                                  from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2))}"
                                  optionKey="id" value="${convenioInstance?.unidadEjecutora?.id}"
                                  class="many-to-one form-control input-sm"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: convenioInstance, field: 'nombre', 'error')} ">
                <span class="grupo">
                    <label for="nombre" class="col-md-3 control-label">
                        Nombre
                    </label>

                    <div class="col-md-9">
                        <g:textField name="nombre" maxlength="63" class="form-control input-sm required"
                                     value="${convenioInstance?.nombre}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: convenioInstance, field: 'objetivo', 'error')} ">
                <span class="grupo">
                    <label for="objetivo" class="col-md-3 control-label">
                        Objetivo
                    </label>

                    <div class="col-md-9">
                        <g:textArea name="objetivo" rows="2" maxlength="1024" class="form-control input-sm required"
                                    value="${convenioInstance?.objetivo}" style="resize: none"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: convenioInstance, field: 'objetivo', 'error')} ">
                <label for="fechaInicio" class="col-md-3 control-label">
                    Fecha Inicio
                </label>
                <span class="grupo">
                    <div class="col-md-3 ">
                        <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"
                               value="${convenioInstance?.fechaInicio?.format("dd-MM-yyyy")}"/>

                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
                <label for="fechaFin" class="col-md-3 control-label">
                    Fecha Fin
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <input name="fechaFin" id='fechaFin' type='text' class="form-control"
                               value="${convenioInstance?.fechaFin?.format("dd-MM-yyyy")}"/>

                        <p class="help-block ui-helper-hidden"></p>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: convenioInstance, field: 'monto', 'error')} ">
                <span class="grupo">
                    <label for="monto" class="col-md-3 control-label">
                        Monto del convenio
                    </label>

                    <div class="col-md-4">
                        <g:textField name="monto" class="form-control input-sm required"
                                     value="${convenioInstance?.monto}"/>
                    </div>
                </span>
                <span class="grupo">
                    <label for="codigo" class="col-md-2 control-label">
                        Número:
                    </label>

                    <div class="col-md-3">
                        <g:textField name="codigo" class="form-control input-sm required allCaps"
                                     value="${convenioInstance?.codigo}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: convenioInstance, field: 'plazo', 'error')} ">
                <span class="grupo">
                    <label for="plazo" class="col-md-3 control-label">
                        Plazo
                    </label>

                    <div class="col-md-2">
                        <g:textField name="plazo" class="form-control input-sm required"
                                     value="${convenioInstance?.plazo}"/>
                    </div>
                </span>
                <span class="grupo">
                    <label for="periodo" class="col-md-3 control-label">
                        Informar cada:
                    </label>

                    <div class="col-md-2">
                        <g:textField name="periodo" class="form-control input-sm required"
                                     value="${convenioInstance?.periodo}"/>
                    </div>
                    <span style="display: inline">Días</span>
                </span>
            </div>

        </g:form>
    </div>

    <script type="text/javascript">


        $(".form-control").keydown(function (ev) {
            if (ev.keyCode == 13) {
                submitFormTaller();
                return false;
            }
            return true;
        });

        $(".buscarParroquia").click(function () {
            var dialog = cargarLoader("Cargando...");
            $(this).attr('disabled','disabled');
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'parroquia', action: 'buscarParroquia_ajax')}',
                data:{
                    tipo: 2
                },
                success:function (msg) {
                    dialog.modal('hide');
                    bp = bootbox.dialog({
                        id    : "dlgBuscarComunidad",
                        title : "Buscar Parroquia",
                        class : "modal-lg",
                        closeButton: false,
                        message : msg,
                        buttons : {
                            cancelar : {
                                label     : "Cancelar",
                                className : "btn-primary",
                                callback  : function () {
                                    $(".buscarParroquia").removeAttr('disabled');
                                }
                            }
                        }
                    }); //dialog
                }
            });
        });

        function cerrarDialogoParroquia(){
            bp.dialog().dialog('open');
            bp.modal("hide");
        }

        $('#fechaInicio').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            daysOfWeekDisabled: [0, 6],
            sideBySide: true,
            showClose: true,
        });

        $('#fechaFin').datetimepicker({
            locale: 'es',
            format: 'DD-MM-YYYY',
            daysOfWeekDisabled: [0, 6],
            sideBySide: true,
            showClose: true,
        });

/*
        if('${convenioInstance?.id}'){
            comboComunidadPrincipal('${convenioInstance?.parroquia?.id}')
        }
*/

    </script>
</g:else>