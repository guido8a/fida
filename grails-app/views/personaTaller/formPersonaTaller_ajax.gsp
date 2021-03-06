<%@ page import="seguridad.TipoInstitucion; taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js/plugins/jquery-validation-1.13.1/dist', file: 'additional-methods.min.js')}"></script>--}%
<g:if test="${!prtlInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmPersonaTaller" controller="personaTaller" action="save_ajax" method="POST">
            <g:hiddenField name="id" value="${prtlInstance?.id}"/>
            <g:hiddenField name="taller" value="${taller?.id}"/>

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

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'cargo', 'error')} ">
                <span class="grupo">
                    <label for="cedula" class="col-md-3 control-label">
                        Cédula
                    </label>

                    <div class="col-md-3">
                        <g:textField name="cedula" maxlength="10" class="form-control input-sm required digits"
                                     value="${prtlInstance?.cedula}"/>
                    </div>
                    <label for="edad" class="col-md-2 control-label">
                        Edad
                    </label>
                    <span class="grupo">
                        <div class="col-md-2">
                            <g:textField name="edad" maxlength="10" class="form-control input-sm digits"
                                         value="${prtlInstance?.edad ?: ''}"/>
                        </div>
                    </span>
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

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'raza', 'error')} ">
                <span class="grupo">
                    <label for="raza" class="col-md-3 control-label">
                        Raza
                    </label>

                    <div class="col-md-4">
                        <g:select id="raza" name="raza.id"
                                  from="${taller.Raza.list()}"
                                  optionKey="id" value="${prtlInstance?.raza?.id}"
                                  class="many-to-one form-control input-sm"/>
                    </div>

                    <label for="titulo" class="col-md-2 control-label">
                        Sexo
                    </label>
                    <span class="grupo">
                        <div class="col-md-3">
                            <g:select from="${[M: 'Masculino', F: 'Femenino']}" optionKey="key" optionValue="value" name="sexo" class="form-control"/>
                        </div>
                    </span>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'cargo', 'error')} ">
                <span class="grupo">
                    <label for="cargo" class="col-md-3 control-label">
                        Cargo
                    </label>

                    <div class="col-md-9">
                        <g:textField name="cargo" maxlength="63" class="form-control input-sm"
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
                    Titulo (abreviatura)
                </label>
                <span class="grupo">
                    <div class="col-md-2">
                        <g:textField name="titulo" maxlength="4" class="form-control input-sm"
                                     value="${prtlInstance?.titulo}"/>
                    </div>
                </span>
                <label for="discapacidad" class="col-md-4 control-label">
                    Discapacidad
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <g:select from="${[0: 'NO', 1: 'SI']}" optionKey="key" optionValue="value" name="discapacidad" class="form-control"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'telefono', 'error')} ">
                <label for="telefono" class="col-md-3 control-label">
                    Teléfono
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <g:textField name="telefono" maxlength="31" class="form-control input-sm digits"
                                     value="${prtlInstance?.telefono}"/>
                    </div>
                </span>

                <label for="celular" class="col-md-1 control-label">
                    Celular
                </label>
                <span class="grupo">
                    <div class="col-md-3">
                        <g:textField name="celular" maxlength="15" class="form-control input-sm digits"
                                     value="${prtlInstance?.celular}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: prtlInstance, field: 'telefono', 'error')} ">
                <label for="mail" class="col-md-3 control-label">
                    Mail
                </label>
                <span class="grupo">
                    <div class="col-md-5">
                        <g:textField name="mail" maxlength="63" class="form-control input-sm email"
                                     value="${prtlInstance?.mail ?: ''}"/>
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
            comboComunidadPersonaTaller('${prtlInstance?.parroquia?.id}')
        }

        function comboComunidadPersonaTaller(id){
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'taller', action: 'comunidad_ajax')}',
                data:{
                    id: id,
                    taller: '${prtlInstance?.id}',
                    tipo: 3
                },
                success: function (msg) {
                    $("#divComunidadPersona").html(msg)
                }
            })
        }



    </script>

</g:else>