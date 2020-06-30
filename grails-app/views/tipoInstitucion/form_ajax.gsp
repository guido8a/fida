
<g:if test="${!tipoInstitucionInstance}">
    <elm:notFound elem="Tipo de Institución" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTpin" role="form" action="save_ajax" method="POST" useToken="true">
        <g:hiddenField name="id" value="${tipoInstitucionInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: tipoInstitucionInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="descripcion" class="col-md-2 control-label text-info">
                    Descripción
                </label>
                <div class="col-md-8">
                    <g:textArea name="descripcion" maxlength="63" class="form-control required"
                                value="${tipoInstitucionInstance?.descripcion}" style="height: 75px; resize: none"/>
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