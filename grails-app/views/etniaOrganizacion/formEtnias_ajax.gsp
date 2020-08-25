<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 25/08/20
  Time: 11:50
--%>
<g:form class="form-horizontal" name="fmrEtnias">
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
            <label for="etnia" class="col-md-2 control-label text-info">
                Etnia
            </label>
            <div class="col-md-4">
                <g:select from="${taller.Raza.list().sort{it.descripcion}}" name="etnia" class="form-control input-sm"
                          value="${''}" optionKey="id" optionValue="descripcion" />
            </div>
        </span>
    </div>
    <div class="form-group">
        <span class="grupo">
            <label for="numero" class="col-md-7 control-label text-info">
                Número de personas de esta etnia en la organización
            </label>
            <div class="col-md-2">
                <g:textField name="numero" value="${0}" class="form-control number" maxlength="3"/>
            </div>
            <a href="#" class="btn btn-success" id="btnAgregarEtnia"><i class="fa fa-plus"></i> Agregar </a>
        </span>
    </div>

    <div id="divTablaEtnias">

    </div>
</g:form>

<script type="text/javascript">

    cargarTablaEtnias();

    function cargarTablaEtnias(){
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'etniaOrganizacion', action: 'tablaEtnias_ajax')}',
            data:{
                id: '${unidad?.id}'
            },
            success: function (msg) {
                $("#divTablaEtnias").html(msg)
            }
        });
    }

    $("#btnAgregarEtnia").click(function () {
        var raza = $("#etnia option:selected").val();
        agregarEtnia(raza);
     });

    function agregarEtnia(raza){
        $.ajax({
            type: 'GET',
            url: '${createLink(controller: 'etniaOrganizacion', action: 'agregarEtnia_ajax')}',
            data:{
                id: '${unidad?.id}',
                raza: raza,
                numero: $("#numero").val()
            },
            success: function (msg) {
                if(msg == 'ok'){
                    log("Agregado correctamente","success");
                    cargarTablaEtnias();
                }else{
                    if(msg == 'er'){
                         bootbox.alert("<i class='fa fa-exclamation-triangle fa-3x pull-left text-warning text-shadow'></i>  La etnia seleccionada ya se encuentra en la lista!")
                    }else{
                        log("Error al agregar la etnia","error")
                    }
                }
            }
        })
    }

    $("#numero").keydown(function (ev) {
        return validarNumero(ev)
    });


    function validarNumero(ev) {
        /*
         48-57      -> numeros
         96-105     -> teclado numerico
         188        -> , (coma)
         190        -> . (punto) teclado
         110        -> . (punto) teclado numerico
         8          -> backspace
         46         -> delete
         9          -> tab
         37         -> flecha izq
         39         -> flecha der
         */
        return ((ev.keyCode >= 48 && ev.keyCode <= 57) ||
            (ev.keyCode >= 96 && ev.keyCode <= 105) ||
            ev.keyCode == 8 || ev.keyCode == 46 || ev.keyCode == 9 ||
            ev.keyCode == 37 || ev.keyCode == 39);
    }


</script>
