<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 05/10/20
  Time: 9:47
--%>

<g:if test="${!proceso}">
    <elm:notFound elem="tipProcesoComprasPublicas" genero="o" />
</g:if>
<g:else>
    <div class="modal-contenido">
        <g:form class="form-horizontal" name="frmProceso" role="form" action="saveProceso_ajax" method="POST">
            <g:hiddenField name="id" value="${proceso?.id}" />

            <div class="form-group keeptogether ${hasErrors(bean: proceso, field: 'descripcion', 'error')}">
                <span class="grupo">
                    <label for="descripcion" class="col-md-2 control-label">
                        Descripción
                    </label>
                    <div class="col-md-8">
                        <g:textField name="descripcion" maxlength="63" class="form-control input-sm required" value="${proceso?.descripcion}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: proceso, field: 'sigla', 'error')}">
                <span class="grupo">
                    <label for="sigla" class="col-md-2 control-label">
                        Sigla
                    </label>
                    <div class="col-md-8">
                        <g:textField name="sigla" maxlength="7" class="form-control input-sm allCaps required" value="${proceso?.sigla}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: proceso, field: 'base', 'error')}">
                <span class="grupo">
                    <label for="base" class="col-md-2 control-label">
                        Base
                    </label>
                    <div class="col-md-8">
                        <g:textField name="base" maxlength="16" class="form-control input-sm number required" value="${proceso?.base}"/>
                    </div>
                </span>
            </div>
            <div class="form-group keeptogether ${hasErrors(bean: proceso, field: 'techo', 'error')}">
                <span class="grupo">
                    <label for="techo" class="col-md-2 control-label">
                        Techo
                    </label>
                    <div class="col-md-8">
                        <g:textField name="techo" maxlength="16" class="form-control input-sm number" value="${proceso?.techo}"/>
                    </div>
                </span>
            </div>
        </g:form>
    </div>

    <script type="text/javascript">
        var validator = $("#frmProceso").validate({
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