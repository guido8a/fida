<%@ page import="taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js/plugins/jquery-validation-1.13.1/dist', file: 'additional-methods.min.js')}"></script>--}%
<g:if test="${!dsmbInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
            <g:hiddenField name="id" value="${dsmbInstance?.id}"/>


            <div class="row">
                <div class="col-md-3 show-label">Organización</div>
                <div class="col-md-9">${dsmbInstance?.convenio?.planesNegocio?.unidadEjecutora}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Financiamiento</div>
                <div class="col-md-9">${dsmbInstance?.financiamientoPlanNegocio?.fuente?.descripcion}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Garantía</div>
                <div class="col-md-9">${dsmbInstance?.garantia?.codigo}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">descripcion</div>
                <div class="col-md-9">${dsmbInstance?.descripcion}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Fecha</div>
                <div class="col-md-3">${dsmbInstance?.fecha?.format("dd-MM-yyyy")}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Valor</div>
                <div class="col-md-9">${dsmbInstance?.valor}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">CUR</div>
                <div class="col-md-9">${dsmbInstance?.cur}</div>
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