
<g:if test="${!estadoAvalInstance}">
    <elm:notFound elem="Tipo de Institución" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmOrms" role="form" action="save_ajax" method="POST" useToken="true">
        <g:hiddenField name="id" value="${estadoAvalInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: estadoAvalInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="codigo" class="col-md-2 control-label text-info">
                    Código
                </label>
                <div class="col-md-2">
                    <g:textField name="codigo" maxlength="15" class="form-control required allCaps"
                                value="${estadoAvalInstance?.codigo}"/>
                </div>
            </span>
        </div>
        
        <div class="form-group ${hasErrors(bean: estadoAvalInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-8">
                    <g:textArea name="descripcion" maxlength="63" class="form-control required"
                                value="${estadoAvalInstance?.descripcion}" style="height: 75px; resize: none"/>
                </div>

            </span>
        </div>

    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTpin").validate({
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