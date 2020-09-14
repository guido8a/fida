<%@ page import="taller.Capacidad; taller.TipoTaller; seguridad.UnidadEjecutora; taller.Taller" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js/plugins/jquery-validation-1.13.1/dist', file: 'additional-methods.min.js')}"></script>--}%
<g:if test="${!infoInstance}">
    <elm:notFound elem="Taller" genero="o"/>
</g:if>
<g:else>

    <div class="modal-contenido">
            <g:hiddenField name="id" value="${infoInstance?.id}"/>


            <div class="row">
                <div class="col-md-3 show-label">Organización</div>
                <div class="col-md-9">${infoInstance?.administradorConvenio?.convenio?.planesNegocio?.unidadEjecutora}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Administrador del Convenio</div>
                <div class="col-md-9">${infoInstance?.administradorConvenio?.persona?.nombreCompleto}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Desembolso</div>
                <div class="col-md-9">${infoInstance?.desembolso?.descripcion}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Informe</div>
                <div class="col-md-9">${infoInstance?.informeAvance}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Dificultades</div>
                <div class="col-md-9">${infoInstance?.dificultadesAvance}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Fecha</div>
                <div class="col-md-3">${infoInstance?.fecha?.format("dd-MM-yyyy")}</div>
            </div>

            <div class="row">
                <div class="col-md-3 show-label">Valor</div>
                <div class="col-md-9">${infoInstance?.porcentaje}</div>
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


    </script>

</g:else>