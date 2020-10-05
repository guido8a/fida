<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/10/20
  Time: 9:47
--%>

<g:if test="${!taller}">
    <elm:notFound elem="tipoTaller" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmTaller" role="form" action="saveTaller_ajax" method="POST">
            <g:hiddenField name="id" value="${taller?.id}" />

            <div class="form-group keeptogether ${hasErrors(bean: taller, field: 'descripcion', 'error')}">
                <span class="grupo">
                    <label for="descripcion" class="col-md-2 control-label">
                        Descripción
                    </label>
                    <div class="col-md-10">
                        <g:textField name="descripcion" maxlength="63" class="form-control input-sm required allCaps" value="${taller?.descripcion}"/>
                    </div>
                </span>
            </div>
        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmTaller").validate({
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