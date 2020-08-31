<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 26/08/20
  Time: 11:08
--%>

<g:form class="form-horizontal" name="fmrCategorias">
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
            <label for="categoria" class="col-md-2 control-label text-info">
                Categoría
            </label>
            <div class="col-md-8">
                <g:select from="${convenio.TipoCategoria.list().sort{it.descripcion}}" name="categoria" class="form-control input-sm"
                          value="${''}" optionKey="id" optionValue="descripcion" />
            </div>

        </span>
    </div>
    <div class="form-group">
        <span class="grupo">
            <label for="valor" class="col-md-2 control-label text-info">
                Valor
            </label>
            <div class="col-md-5">
                <g:textField name="valor" value="${''}" class="form-control number" maxlength="31"/>
            </div>
            <a href="#" class="btn btn-success" id="btnAgregarCategoria"><i class="fa fa-plus"></i> Agregar </a>
        </span>
    </div>

    <div id="divTablaCategorias">

    </div>
</g:form>

<script type="text/javascript">

    cargarTablaCategorias();

    function cargarTablaCategorias(){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'categoria', action: 'tablaCategoria_ajax')}',
            data:{
                id: '${unidad?.id}'
            },
            success: function (msg) {
                $("#divTablaCategorias").html(msg)
            }
        });
    }

    $("#btnAgregarCategoria").click(function () {
        var categoria = $("#categoria option:selected").val();
        var valor = $("#valor").val();
        agregarCategorias(categoria,valor);
    });

    function agregarCategorias(categoria,valor){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'categoria', action: 'agregarCategoria_ajax')}',
            data:{
                id: '${unidad?.id}',
                categoria: categoria,
                valor: valor
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Agregado correctamente","success");
                    cargarTablaCategorias();
                }else{
                    if(msg == 'er'){
                        bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i>  La categoria seleccionada ya se encuentra en la lista!")
                    }else{
                        log("Error al agregar la categoria","error")
                    }
                }
            }
        })
    }
</script>
