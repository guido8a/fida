<%@ page import="seguridad.TipoInstitucion; taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js/plugins/jquery-validation-1.13.1/dist', file: 'additional-methods.min.js')}"></script>--}%
<g:if test="${!prtlInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmTaller" controller="personaTaller" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${prtlInstance?.id}"/>


            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'parroquia', 'error')} ">
                <span class="grupo">
                    <label for="parroquia" class="col-md-3 control-label">
                        Parroquia
                    </label>
                    <div class="col-md-9">
                        <g:hiddenField name="parroquia" id="parroquia" value="${prtlInstance?.parroquia?.id}"/>
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

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'comunidad', 'error')} ">
                <span class="grupo">
                    <label class="col-md-3 control-label">
                        Comunidad
                    </label>
                    <div class="col-md-9" id="divComunidadPersona">
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'raza', 'error')} ">
                <span class="grupo">
                    <label for="raza" class="col-md-3 control-label">
                        Raza
                    </label>

                    <div class="col-md-9">
                        <g:select id="raza" name="raza.id"
                                  from="${taller.Raza.list()}"
                                  optionKey="id" value="${prtlInstance?.raza?.id}"
                                  class="many-to-one form-control input-sm"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'nombre', 'error')} ">
                <span class="grupo">
                    <label for="nombre" class="col-md-3 control-label">
                        Nombre
                    </label>

                    <div class="col-md-9">
                        <g:textField name="nombre" maxlength="63" class="form-control input-sm required"
                                     value="${prtlInstance?.nombre}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'apellido', 'error')} ">
                <span class="grupo">
                    <label for="apellido" class="col-md-3 control-label">
                        Apellido
                    </label>

                    <div class="col-md-9">
                        <g:textField name="apellido" maxlength="63" class="form-control input-sm required"
                                     value="${prtlInstance?.apellido}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'cargo', 'error')} ">
                <span class="grupo">
                    <label for="cargo" class="col-md-3 control-label">
                        Cargo
                    </label>

                    <div class="col-md-9">
                        <g:textField name="cargo" maxlength="63" class="form-control input-sm required"
                                     value="${prtlInstance?.cargo}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'direccion', 'error')} ">
                <span class="grupo">
                    <label for="direccion" class="col-md-3 control-label">
                        Dirección
                    </label>

                    <div class="col-md-9">
                        <g:textArea name="direccion" rows="2" maxlength="1024" class="form-control input-sm" style="resize: none"
                                    value="${prtlInstance?.direccion}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'titulo', 'error')} ">
                <label for="titulo" class="col-md-3 control-label">
                    Titulo
                </label>
                    <span class="grupo">
                        <div class="col-md-6">
                            <g:textField name="titulo" maxlength="63" class="form-control input-sm"
                                         value="${prtlInstance?.titulo}"/>
                        </div>
                    </span>
%{--                <label for="discapacidad" class="col-md-3 control-label">--}%
%{--                    Discapacidad--}%
%{--                </label>--}%
%{--                    <span class="grupo">--}%
%{--                        <div class="col-md-3">--}%
%{--                            <g:textField name="discapacidad" maxlength="63" class="form-control input-sm required"--}%
%{--                                         value="${prtlInstance?.discapacidad}"/>--}%
%{--                        </div>--}%
%{--                    </span>--}%
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'titulo', 'error')} ">
                <label for="discapacidad" class="col-md-3 control-label">
                    Discapacidad
                </label>
                <span class="grupo">
                    <div class="col-md-9">
                        <g:textField name="discapacidad" maxlength="63" class="form-control input-sm required"
                                     value="${prtlInstance?.discapacidad}"/>
                    </div>
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
                    tipo: 3
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

        if('${prtlInstance?.id}'){
            comboComunidadPrincipal('${prtlInstance?.parroquia?.id}')
        }

        function comboComunidadPrincipal(id){
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'taller', action: 'comunidad_ajax')}',
                data:{
                    id: id,
                    taller: '${prtlInstance?.id}'
                },
                success: function (msg) {
                    $("#divComunidadPersona").html(msg)
                }
            })
        }



    </script>

</g:else>