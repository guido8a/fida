<%@ page import="taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js/plugins/jquery-validation-1.13.1/dist', file: 'additional-methods.min.js')}"></script>--}%
<g:if test="${!tallerInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
            <g:hiddenField name="id" value="${tallerInstance?.id}"/>


            <div class="row">
                <div class="col-md-3 show-label">Comunidad</div>
                <div class="col-md-9">${tallerInstance?.comunidad?.nombre}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Parroquia</div>
                <div class="col-md-9">${tallerInstance.parroquia.nombre} Cantón: ${tallerInstance.parroquia.canton.nombre}
                Provincia: ${tallerInstance.parroquia.canton.provincia.nombre}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Organización</div>
                <div class="col-md-9">${tallerInstance?.unidadEjecutora}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Unidad EPS</div>
                <div class="col-md-9">${tallerInstance?.unidadEps}</div>
            </div>

%{--
        <g:if test="${tallerInstance?.institucion}">
            <div class="row">
                <div class="col-md-3 show-label">Institución</div>
                <div class="col-md-9">${tallerInstance?.institucion?.descripcion}</div>
            </div>
        </g:if>
--}%

            <div class="row">
                <div class="col-md-3 show-label">Tipo de Taller</div>
                <div class="col-md-9">${tallerInstance?.tipoTaller?.descripcion}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Capacidad del PFI</div>
                <div class="col-md-9">${tallerInstance?.capacidad?.descripcion}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Nombre</div>
                <div class="col-md-9">${tallerInstance?.nombre}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Objetivo</div>
                <div class="col-md-9">${tallerInstance?.objetivo}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Fecha Inicio</div>
                <div class="col-md-3">${tallerInstance?.fechaInicio?.format("dd-MM-yyyy")}</div>
                <div class="col-md-3 show-label">Fecha Fin</div>
                <div class="col-md-3">${tallerInstance?.fechaFin?.format("dd-MM-yyyy")}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Valor del taller</div>
                <div class="col-md-9">${tallerInstance?.valor}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Instructor</div>
                <div class="col-md-9">${tallerInstance?.instructor}</div>
            </div>

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
            $.ajax({
                type: 'POST',
                url: '${createLink(controller: 'parroquia', action: 'buscarParroquia_ajax')}',
                data:{
                },
                success:function (msg) {
                    dialog.modal('hide');
                    bp = bootbox.dialog({
                        id    : "dlgBuscarParroquia",
                        title : "Buscar Parroquia",
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