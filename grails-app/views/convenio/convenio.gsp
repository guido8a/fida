<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 13/07/20
  Time: 10:30
--%>

<html>
<head>
    <meta name="layout" content="main">
    <title>Convenio</title>

    <style type="text/css">
    .mediano {
        margin-top: 5px;
        padding-top: 9px;
        height: 30px;
        font-size: inherit;
        /*font-size: medium;*/
        text-align: right;
    }

    .sobrepuesto {
        position: absolute;
        top: 3px;
        font-size: 14px;
    }

    .negrita {
        font-weight: bold;
    }

    .izquierda{
        margin-left: 4px;
    }
    </style>

</head>

<body>

<div class="panel panel-primary col-md-12">
    <div class="panel-heading" style="padding: 3px; margin-top: 2px; text-align: center">
        <a href="${createLink(controller: 'buscarBase', action: 'busquedaBase')}" id="btnConsultarBase"
           class="btn btn-sm btn-info" title="Consultar artículo">
            <i class="fas fa-clipboard-check"></i> Lista de convenios
        </a>
        <a href="${createLink(controller: 'documento', action: 'listProyecto')}" id="btnConsultar"
           class="btn btn-sm btn-info" title="Consultar artículo">
            <i class="fas fa-book-reader"></i> Nuevo convenio
        </a>
        <a href="#" id="btnFinanciamiento" class="btn btn-sm btn-info" title="Crear nuevo registro">
            <i class="fa fa-dollar-sign"></i> Administrador
        </a>
        <a href="#" id="btnEstado" class="btn btn-sm btn-info" title="Estado">
            <i class="fa fa-check"></i> Indicadores
        </a>
        <a href="#" id="btnVerMarco" class="btn btn-sm btn-info" title="Ver marco lógico">
            <i class="fa fa-search"></i> Biblioteca
        </a>
        <a href="#" id="editMrlg" class="btn btn-sm btn-info" title="Ver registro">
            <i class="fa fa-clipboard"></i> Plan de negocio solidario
        </a>
        <a href="#" id="btnGuardar" class="btn btn-sm btn-success" title="Guardar información">
            <i class="fa fa-save"></i> Guardar
        </a>
        <a href="#" id="btnEliminar" class="btn btn-sm btn-danger" title="Guardar información">
            <i class="fa fa-save"></i> Eliminar
        </a>
    </div>


    <div class="tab-content">
        <div id="home" class="tab-pane fade in active">
            <g:form class="form-horizontal" name="frmProyecto" controller="proyecto" action="save_ajax">
                <g:hiddenField name="id" value="${convenio?.id}"/>
                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Parroquia</span>
                        <div class="col-md-4">
                            <g:hiddenField name="parroquia" id="parroquia" value="${convenio?.parroquia?.id}"/>
                            <span class="grupo">
                                <div class="input-group input-group-sm" >
                                    <input type="text" class="form-control buscarParroquia" name="parroquiaName"
                                           id="parroquiaTexto" value="${convenio?.nombre}">
                                    <span class="input-group-btn">
                                        <a href="#" class="btn btn-info buscarParroquia" title="Buscar Parroquia">
                                            <span class="glyphicon glyphicon-search" aria-hidden="true"></span>
                                        </a>
                                    </span>
                                </div>
                            </span>
                        </div>
                        <span class="col-md-2 label label-primary text-info mediano">Organización</span>
                        <div class="col-md-4">
                            <span class="grupo">
                                <g:select id="unidadEjecutora" name="unidadEjecutora.id"
                                          from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2))}"
                                          optionKey="id" value="${convenio?.unidadEjecutora?.id}"
                                          class="many-to-one form-control input-sm"/>
                            </span>
                        </div>
                    </div>
                </div>

%{--                <div class="row izquierda">--}%
%{--                    <div class="col-md-12 input-group">--}%
%{--                        <span class="col-md-2 label label-primary text-info mediano">Organización</span>--}%
%{--                        <div class="col-md-10">--}%
%{--                            <span class="grupo">--}%
%{--                                <g:select id="unidadEjecutora" name="unidadEjecutora.id"--}%
%{--                                          from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2))}"--}%
%{--                                          optionKey="id" value="${convenio?.unidadEjecutora?.id}"--}%
%{--                                          class="many-to-one form-control input-sm"/>--}%
%{--                            </span>--}%
%{--                        </div>--}%
%{--                    </div>--}%
%{--                </div>--}%

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Nombre</span>

                        <div>
                            <div class="col-md-10">
                                <span class="grupo">
                                    <g:textField name="nombre" maxlength="63" class="form-control input-sm required"
                                                 value="${convenio?.nombre}"/>
                                </span>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Objetivo</span>

                        <div class="col-md-10">
                            <span class="grupo">
                                <g:textArea name="objetivo" rows="2" maxlength="1024" class="form-control input-sm required"
                                            value="${convenio?.objetivo}" style="resize: none"/>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="row izquierda">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Inicio</span>
                        <span class="grupo">
                            <div class="col-md-2 ">
                                <input name="fechaInicio" id='fechaInicio' type='text' class="form-control"
                                       value="${convenio?.fechaInicio?.format("dd-MM-yyyy")}"/>

                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
                        <span class="col-md-2 mediano"></span>
                        <span class="col-md-2 label label-primary text-info mediano">Fecha Fin</span>
                        <span class="grupo">
                            <div class="col-md-2">
                                <input name="fechaFin" id='fechaFin' type='text' class="form-control"
                                       value="${convenio?.fechaFin?.format("dd-MM-yyyy")}"/>

                                <p class="help-block ui-helper-hidden"></p>
                            </div>
                        </span>
                    </div>
                </div>

                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Monto del convenio</span>

                        <div class="col-md-2">
                            <g:textField name="monto" class="form-control input-sm required"
                                         value="${convenio?.monto}"/>
                        </div>
                        <span class="col-md-2 mediano"></span>
                        <span class="col-md-2 label label-primary text-info mediano">Número</span>

                        <div class="col-md-2">
                            <g:textField name="codigo" class="form-control input-sm required allCaps"
                                         value="${convenio?.codigo}"/>
                        </div>
                    </div>
                </div>

                <div class="row izquierda" style="margin-bottom: 20px">
                    <div class="col-md-12 input-group">
                        <span class="col-md-2 label label-primary text-info mediano">Plazo</span>

                        <div class="col-md-2">
                            <g:textField name="plazo" class="form-control input-sm required"
                                         value="${convenio?.plazo}"/>
                        </div>
                        <span class="col-md-2 mediano"></span>
                        <span class="col-md-2 label label-primary text-info mediano">Informar cada:</span>

                        <div class="col-md-2">
                            <g:textField name="periodo" class="form-control input-sm required"
                                         value="${convenio?.periodo}"/>
                        </div>
                    </div>
                </div>
            </g:form>
        </div>
    </div>
</div>
</body>
</html>