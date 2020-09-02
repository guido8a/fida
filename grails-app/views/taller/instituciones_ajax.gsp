<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 01/09/20
  Time: 17:07
--%>

<g:form class="form-horizontal" name="frmInstituciones">
    <g:hiddenField name="taller" value="${taller?.id}"/>
    <div class="form-group">
        <span class="grupo">
            <label class="col-md-2 control-label text-info">
                Taller
            </label>
            <div class="col-md-8">
                <strong>${taller?.nombre}</strong>
            </div>
        </span>
    </div>
    <div class="form-group">
        <span class="grupo">
            <label for="institucion" class="col-md-2 control-label text-info">
                Institución
            </label>
            <div class="col-md-8">
                <g:select from="${taller.Institucion.list().sort{it.descripcion}}" name="institucion" class="form-control input-sm"
                          value="${''}" optionKey="id" optionValue="descripcion" />
            </div>
            <a href="#" class="btn btn-success" id="btnAgregarInstitucion"><i class="fa fa-plus"></i> Agregar </a>
        </span>
    </div>
    <div id="divTablaInstituciones">

    </div>
</g:form>

<script type="text/javascript">

    cargarTablaInstituciones();

    function cargarTablaInstituciones(){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'taller', action: 'tablaInstituciones_ajax')}',
            data:{
                id: '${taller?.id}'
            },
            success: function (msg) {
                $("#divTablaInstituciones").html(msg)
            }
        });
    }

    $("#btnAgregarInstitucion").click(function () {
        var ins = $("#institucion option:selected").val();
        agregarInstitucion(ins);
    });

    function agregarInstitucion(institucion){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'taller', action: 'agregarInstitucion_ajax')}',
            data:{
                id: '${taller?.id}',
                institucion: institucion
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Agregado correctamente","success");
                    cargarTablaInstituciones();
                }else{
                    if(msg == 'er'){
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i> La institución seleccionada ya se encuentra en la lista!")
                    }else{
                        log("Error al agregar la insitución","error")
                    }
                }
            }
        })
    }
</script>
