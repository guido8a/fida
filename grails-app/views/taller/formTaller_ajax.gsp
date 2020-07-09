<%@ page import="seguridad.TipoInstitucion; taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js/plugins/jquery-validation-1.13.1/dist', file: 'additional-methods.min.js')}"></script>--}%
<g:if test="${!tallerInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmTaller" controller="taller" action="save_ajax" method="POST">
%{--        <g:form class="form-horizontal" name="frmTaller" controller="taller" action="save_ajax" method="POST"--}%
%{--                attrs.enctype = "multipart/form-data">--}%
            <g:hiddenField name="id" value="${tallerInstance?.id}"/>


            <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'comunidad', 'error')} ">
                <span class="grupo">
                    <label for="comunidad" class="col-md-3 control-label">
                        Comunidad
                    </label>
                    <div class="col-md-9">
                        <g:hiddenField name="comunidad" id="comunidad" value="${tallerInstance?.comunidad?.id}"/>
                        <span class="grupo">
                            <div class="input-group input-group-sm" >
                                <input type="text" class="form-control buscarComunidad" name="comunidadName"
                                       id="comunidadTexto" value="${lugar}">
                                <span class="input-group-btn">
                                    <a href="#" class="btn btn-info buscarComunidad" title="Buscar Comunidad">
                                        <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                    </a>
                                </span>
                            </div>
                        </span>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: meta, field: 'parroquia', 'error')} ">
                <span class="grupo">
                    <label for="comunidad" class="col-md-3 control-label">
                        Parroquia
                    </label>
                    <div class="col-md-9">
                        <g:hiddenField name="parroquia" id="parroquia" value="${tallerInstance?.parroquia?.id}"/>
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


            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'unidadEjecutora', 'error')} ">
                <span class="grupo">
                    <label for="unidadEjecutora" class="col-md-3 control-label">
                        Organización
                    </label>

                    <div class="col-md-9">
                        <g:select id="unidadEjecutora" name="unidadEjecutora.id"
                                  from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(1))}"
                                  optionKey="id" value="${tallerInstance?.unidadEjecutora?.id}"
                                  class="many-to-one form-control input-sm"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'unidadEps', 'error')} ">
                <span class="grupo">
                    <label for="unidadEps" class="col-md-3 control-label">
                        Unidad EPS
                    </label>

                    <div class="col-md-9">
                        <g:select id="unidadEps" name="unidadEps.id"
                                  from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2))}"
                                  optionKey="id" value="${tallerInstance?.unidadEps?.id}"
                                  class="many-to-one form-control input-sm"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'institucion', 'error')} ">
                <span class="grupo">
                    <label for="institucion" class="col-md-3 control-label">
                        Institución
                    </label>

                    <div class="col-md-9">
                        <g:select id="institucion" name="institucion.id" from="${taller.Institucion.list()}"
                                  optionKey="id" value="${tallerInstance?.institucion?.id}"
                                  class="many-to-one form-control input-sm" noSelection="['null': '']"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'tipoTaller', 'error')} ">
                <span class="grupo">
                    <label for="tipoTaller" class="col-md-3 control-label">
                        Tipo de Taller
                    </label>

                    <div class="col-md-9">
                        <g:select id="tipoTaller" name="tipoTaller.id" from="${taller.TipoTaller.list()}"
                                  optionKey="id" value="${tallerInstance?.tipoTaller?.id}"
                                  class="many-to-one form-control input-sm" noSelection="['null': '']"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'capacidad', 'error')} ">
                <span class="grupo">
                    <label for="capacidad" class="col-md-3 control-label">
                        Capacidad del PFI
                    </label>

                    <div class="col-md-9">
                        <g:select id="capacidad" name="capacidad.id" from="${taller.Capacidad.list()}"
                                  optionKey="id" value="${tallerInstance?.capacidad?.id}"
                                  class="many-to-one form-control input-sm" noSelection="['null': '']"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'nombre', 'error')} ">
                <span class="grupo">
                    <label for="nombre" class="col-md-3 control-label">
                        Nombre
                    </label>

                    <div class="col-md-9">
                        <g:textField name="nombre" maxlength="63" class="form-control input-sm required"
                                     value="${tallerInstance?.nombre}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'objetivo', 'error')} ">
                <span class="grupo">
                    <label for="objetivo" class="col-md-3 control-label">
                        Objetivo
                    </label>

                    <div class="col-md-9">
                        <g:textArea name="objetivo" rows="2" maxlength="1024" class="form-control input-sm"
                                    value="${tallerInstance?.objetivo}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'objetivo', 'error')} ">
                <label for="fechaInicio" class="col-md-3 control-label">
                    Fecha Inicio
                </label>
                    <span class="grupo">
                        <div class="col-md-3 ">
                            <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"
                                   value="${tallerInstance?.fechaInicio?.format("dd-MM-yyyy")}"/>

                            <p class="help-block ui-helper-hidden"></p>
                        </div>
                    </span>
                <label for="fechaFin" class="col-md-3 control-label">
                    Fecha Fin
                </label>
                    <span class="grupo">
                        <div class="col-md-3">
                            <input name="fechaFin" id='fechaFin' type='text' class="form-control"
                                   value="${tallerInstance?.fechaFin?.format("dd-MM-yyyy")}"/>

                            <p class="help-block ui-helper-hidden"></p>
                        </div>
                    </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'valor', 'error')} ">
                <span class="grupo">
                    <label for="valor" class="col-md-3 control-label">
                        Valor del taller
                    </label>

                    <div class="col-md-4">
                        <g:textField name="valor" class="form-control input-sm required"
                                     value="${tallerInstance?.valor}"/>
                    </div>
                </span>
            </div>

            <div class="form-group keeptogether ${hasErrors(bean: tallerInstance, field: 'instructor', 'error')} ">
                <span class="grupo">
                    <label for="instructor" class="col-md-3 control-label">
                        Instructor
                    </label>

                    <div class="col-md-9">
                        <g:textField name="instructor" class="form-control input-sm required"
                                     value="${tallerInstance?.instructor}"/>
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

        $(".buscarComunidad").click(function () {
            var dialog = cargarLoader("Cargando...");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'parroquia', action: 'buscarComunidad_ajax')}',
                data:{
                },
                success:function (msg) {
                    dialog.modal('hide');
                    bp = bootbox.dialog({
                        id    : "dlgBuscarComunidad",
                        title : "Buscar Comunidad",
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
        });

        $(".buscarParroquia").click(function () {
            var dialog = cargarLoader("Cargando...");
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'parroquia', action: 'buscarParroquia_ajax')}',
                data:{
                },
                success:function (msg) {
                    dialog.modal('hide');
                    bp = bootbox.dialog({
                        id    : "dlgBuscarComunidad",
                        title : "Buscar Comunidad",
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



    </script>

</g:else>