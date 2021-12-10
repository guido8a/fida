<%@ page import="seguridad.TipoInstitucion" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 22/09/20
  Time: 12:00
--%>

<span>


    <div style="margin-top: 0px; min-height: 60px" class="vertical-container">
        <p class="css-vertical-text">Buscar</p>

        <div class="linea"></div>





    %{--    <div class="col-md-12">--}%
%{--    <span style="margin-left: 30px">Buscar :</span>--}%
%{--    <div class="col-md-4">--}%
%{--        <g:select from="${[0: 'Provincia', 1: 'Código', 2 : 'Nombre']}" class="form-control" name="campo" optionValue="value" optionKey="key"/>--}%
%{--    </div>--}%
    <div class="col-md-6">
        <input id="buscar" type="search" class="form-control">
    </div>
%{--    <div class="col-md-2">--}%
        <a href="#" name="busqueda" class="btn btn-info btnBusqueda btn-ajax"><i class="fas fa-search"></i> Buscar
        </a>
%{--    </div>--}%

    %{--    </div>--}%

        </div>
</span>


<div style="margin-top: 10px; min-height: 350px" class="vertical-container">
    <p class="css-vertical-text">Resultado - Organizaciones</p>

    <div class="linea"></div>
    <table class="table table-bordered table-hover table-condensed" style="width: 1070px;background-color: #a39e9e">
        <thead>
        <tr>
%{--            <th class="alinear" style="width: 30%">Provincia</th>--}%
%{--            <th class="alinear" style="width: 15%">Código</th>--}%
            <th class="alinear" style="width: 90%">Nombre</th>
            <th class="alinear" style="width: 10%">Seleccionar</th>
        </tr>
        </thead>
    </table>

    <div id="bandeja">
    </div>
</div>

<script type="text/javascript">

    cargarOrganizaciones();

    function cargarOrganizaciones() {
        $.ajax({
            type: 'POST',
            url: '${createLink(controller: 'reportes', action: 'tablaOrganizaciones_ajax')}',
            data:{

            },
            success: function (msg) {
                $("#bandeja").html(msg)
            }
        })
    }



</script>


%{--<span>--}%
%{--    <label>--}%
%{--        Organizaciones--}%
%{--    </label>--}%
%{--<g:select name="organizacion" from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2)).sort{it.nombre}}"--}%
%{--          class="form-control" optionKey="id" optionValue="nombre"/>--}%
%{--</span>--}%