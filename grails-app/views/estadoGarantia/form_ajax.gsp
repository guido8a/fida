<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/10/20
  Time: 9:47
--%>


<g:if test="${!estado}">
    <elm:notFound elem="estadoGarantia" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmEstado" role="form" action="saveEstado_ajax" method="POST">
            <g:hiddenField name="id" value="${estado?.id}" />

            <div class="form-group keeptogether ${hasErrors(bean: estado, field: 'descripcion', 'error')}">
                <span class="grupo">
                    <label for="descripcion" class="col-md-2 control-label">
                        Descripción
                    </label>
                    <div class="col-md-10">
                        <g:textField name="descripcion" maxlength="31" class="form-control input-sm required" value="${estado?.descripcion}"/>
                    </div>
                </span>
            </div>
        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmEstado").validate({
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