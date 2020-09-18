<%@ page contentType="text/html;charset=UTF-8" %>

<html lang="es">
  <head>
%{--    <meta name="layout" content="main_q" />--}%
    <meta name="layout" content="main" />
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
%{--      <meta name="layout" content="main">--}%
    <title>Indicadores del ML</title>
      <style>
        .caja {
            text-align: center;
            padding: 30px;
            margin-top: 40px;
            /*margin-left: 440px;*/
            border-style:solid;
            border-width: thin;
            /*float: right;*/
        }
        .cajaProf {
            color: #116;
        }
        .cajaEstd {
            color: #055;
        }
        .cajaErr {
            color: #611;
        }

      </style>
  </head>
  <body>
  <div class="panel panel-primary col-md-12">
    <div class="ui-widget-content ui-corner-all caja" >
      <div class=" filaEntera ui-corner-all " style="font-size: 14px" >
        <div style="float: left">
            <asset:image src="apli/evaluacion.png" title="Ajustes al Plan Operativo Anual" width="80%" height="80%"
            style="margin-left: 0px;"/></div>
        Usted está a punto de inicar la Evaluación<br><br>

        Por favor lea  y entienda bien las preguntas y señale la opción de respuesta que más se aplique.<br><br>

          <div class="row izquierda" style="margin-top: 70px;">
              <div class="col-md-12 input-group">
                  <span class="col-md-3 panel panel-info" style="height: 35px; text-align: end">Selecciones la Organización</span>
                  <div class="col-md-9">
                      <span class="grupo">
                          <g:select id="unidadEjecutora" name="unidadEjecutora.id"
                                    from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2), [sort: 'nombre'])}"
                                    optionKey="id" value="${convenio?.planesNegocio?.unidadEjecutora?.id}"
                                    class="many-to-one form-control input-sm"/>
                      </span>
                  </div>
              </div>
          </div>

      </div>
        <div>
        <div class="btn-group">
            <a href="#" class="btn btn-sm btn-warning" id="btnFin" style="color: #fee">
                <i class="fa fa-plus"></i> Abandonar la Encuesta
            </a>
        </div>

        <div class="btn-group">
            <a href="#" class="btn btn-sm btn-primary" id="btnEncuesta" style="color: #fff">
                <i class="fa fa-plus"></i> Empezar
            </a>
        </div>
        </div>


    </div>
</div>
  <script type="text/javascript">
      var bm;

      $("#btnFin").click(function () {
          location.href="${createLink(controller: 'pregunta', action: 'pregunta')}"
      });

      $("#btnEncuesta").click(function () {
          location.href="${createLink(controller: 'encuesta', action: 'ponePregunta')}"
      });


  </script>
</body>
</html>



