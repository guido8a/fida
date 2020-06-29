<%@ page import="bitacora.Tema" %>

%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
<g:if test="${!temaInstance}">
    <elm:notFound elem="Tema" genero="o" />
</g:if>
<g:else>
    <g:form class="form-horizontal" name="frmTema" role="form" action="save" method="POST" useToken="true">
        <g:hiddenField name="id" value="${temaInstance?.id}" />
        
        <div class="form-group ${hasErrors(bean: temaInstance, field: 'nombre', 'error')} ">
            <span class="grupo">
                <label for="nombre" class="col-md-2 control-label text-info">
                    Nombre
                </label>
                <div class="col-md-8">
                    %{--<g:textField name="nombre" maxlength="63" required="" class="allCaps form-control required" value="${temaInstance?.nombre}"/>--}%
                    <g:textArea name="nombre" maxlength="63" class="form-control required" value="${temaInstance?.nombre}" style="height: 75px; resize: none"/>
                </div>
                
            </span>
        </div>
        
    </g:form>

    <script type="text/javascript">
        var validator = $("#frmTema").validate({
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