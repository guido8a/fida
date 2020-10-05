<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/10/20
  Time: 9:47
--%>


<g:if test="${!aseguradora}">
    <elm:notFound elem="aseguradora" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmAseguradora" role="form" action="saveAseguradora_ajax" method="POST">
            <g:hiddenField name="id" value="${aseguradora?.id}" />

            <div class="form-group keeptogether ${hasErrors(bean: aseguradora, field: 'nombre', 'error')}">
                <span class="grupo">
                    <label for="nombre" class="col-md-2 control-label">
                        Nombre
                    </label>
                    <div class="col-md-8">
                        <g:textField name="nombre" maxlength="61" class="form-control input-sm required" value="${aseguradora?.nombre}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: aseguradora, field: 'telefono', 'error')}">
                <span class="grupo">
                    <label for="telefono" class="col-md-2 control-label">
                        Teléfono
                    </label>
                    <div class="col-md-8">
                        <g:textField name="telefono" maxlength="63" class="form-control input-sm number" value="${aseguradora?.telefono}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: aseguradora, field: 'mail', 'error')}">
                <span class="grupo">
                    <label for="mail" class="col-md-2 control-label">
                        Mail
                    </label>
                    <div class="col-md-8">
                        <g:textField name="mail" maxlength="63" class="form-control input-sm email" value="${aseguradora?.mail}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: aseguradora, field: 'direccion', 'error')}">
                <span class="grupo">
                    <label for="direccion" class="col-md-2 control-label">
                        Dirección
                    </label>
                    <div class="col-md-8">
                        <g:textArea name="direccion" maxlength="127" style="resize: none" class="form-control input-sm" value="${aseguradora?.direccion}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: aseguradora, field: 'responsable', 'error')}">
                <span class="grupo">
                    <label for="responsable" class="col-md-2 control-label">
                        Responsable
                    </label>
                    <div class="col-md-8">
                        <g:textField name="responsable" maxlength="63" class="form-control input-sm" value="${aseguradora?.responsable}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: aseguradora, field: 'observaciones', 'error')}">
                <span class="grupo">
                    <label for="observaciones" class="col-md-2 control-label">
                        Observaciones
                    </label>
                    <div class="col-md-8">
                        <g:textArea name="observaciones" maxlength="127" style="resize: none" class="form-control input-sm" value="${aseguradora?.observaciones}"/>
                    </div>
                </span>
            </div>
        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmTipoElemento").validate({
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

</g:else>