<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/10/20
  Time: 9:47
--%>


<g:if test="${!necesidad}">
    <elm:notFound elem="tipoNecesidad" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmNecesidad" role="form" action="saveNecesidad_ajax" method="POST">
            <g:hiddenField name="id" value="${necesidad?.id}" />

            <div class="form-group keeptogether ${hasErrors(bean: necesidad, field: 'descripcion', 'error')}">
                <span class="grupo">
                    <label for="descripcion" class="col-md-2 control-label">
                        Descripción
                    </label>
                    <div class="col-md-10">
                        <g:textField name="descripcion" maxlength="63" class="form-control input-sm required" value="${necesidad?.descripcion}"/>
                    </div>
                </span>
            </div>
        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmNecesidad").validate({
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