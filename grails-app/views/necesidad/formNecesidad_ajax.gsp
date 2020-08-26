<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 26/08/20
  Time: 12:01
--%>

<g:form class="form-horizontal" name="fmrNecesidad">
    <div class="form-group">
        <span class="grupo">
            <label for="unidadEjecutora" class="col-md-2 control-label text-info">
                Organización
            </label>
            <div class="col-md-8">
                <g:select from="${seguridad.UnidadEjecutora.list().sort{it.nombre}}" name="unidadEjecutora" class="form-control input-sm"
                          value="${unidad?.id}" optionKey="id" optionValue="nombre" disabled=""/>
            </div>
        </span>
    </div>
    <div class="form-group">
        <span class="grupo">
            <label for="necesidad" class="col-md-2 control-label text-info">
                Tipo de Necesidad
            </label>
            <div class="col-md-8">
                <g:select from="${convenio.TipoNecesidad.list().sort{it.descripcion}}" name="necesidad" class="form-control input-sm"
                          value="${''}" optionKey="id" optionValue="descripcion" />
            </div>
            <a href="#" class="btn btn-success" id="btnAgregarNecesidad"><i class="fa fa-plus"></i> Agregar </a>
        </span>
    </div>
    <div id="divTablaNecesidad">

    </div>
</g:form>

<script type="text/javascript">

    cargarTablaNecesidades();

    function cargarTablaNecesidades(){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'necesidad', action: 'tablaNecesidad_ajax')}',
            data:{
                id: '${unidad?.id}'
            },
            success: function (msg) {
                $("#divTablaNecesidad").html(msg)
            }
        });
    }

    $("#btnAgregarNecesidad").click(function () {
        var necesidad = $("#necesidad option:selected").val();
        agregarNecesidad(necesidad);
    });

    function agregarNecesidad(necesidad){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'necesidad', action: 'agregarNecesidad_ajax')}',
            data:{
                id: '${unidad?.id}',
                necesidad: necesidad
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Agregado correctamente","success");
                    cargarTablaNecesidades();
                }else{
                    if(msg == 'er'){
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i>  El tipo de necesidad seleccionada ya se encuentra en la lista!")
                    }else{
                        log("Error al agregar la necesidad","error")
                    }
                }
            }
        })
    }
</script>
