<%@ page import="proyectos.Supuesto; proyectos.Indicador" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 30/06/20
  Time: 16:54
--%>

<html>
<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8"/>
    <meta name="layout" content="main"/>
    <title>Ver - Marco logico: Fin y Propósito</title>

    <style type="text/css">
    .cmp {
        width      : 240px;
        margin     : 5px;
        min-height : 150px;
        float      : left;
        padding    : 5px;
        position   : relative;
    }

    .supuesto {
        width      : 205px;
        margin     : 0px;
        min-height : 150px;
        float      : left;
        padding    : 5px;
        position   : relative;
    }

    .cmpDoble {
        width      : 640px;
        margin     : 5px;
        min-height : 150px;
        float      : left;
        padding    : 5px;
        position   : relative;
    }

    .fila {
        width      : 100%;
        margin     : 0%;
        min-height : 50px;
        float      : left;
    }

    .filaMedio {
        width      : 57%;
        margin-right: 1%;
        min-height : 50px;
        float      : left;
    }

    .filaMedio2 {
        width      : 40%;
        margin-left: 2%;
        min-height : 50px;
        float      : left;
    }

    .todo {
        height : 100%;
    }

    .titulo {
        width         : 90%;
        margin        : 5%;
        margin-top    : 2px;
        height        : 30px;
        line-height   : 30px;
        text-align    : center;
        font-family   : fantasy;
        font-style    : italic;
        border-bottom : 1px solid black;

    }

    .filaCombo {
        width         : 90%;
        margin        : 5%;
        margin-top    : -10px;
        height        : 40px;
        line-height   : 40px;
        text-align    : center;
        font-family   : fantasy;
        font-style    : italic;
        border-bottom : 1px solid black;
    }

    .texto {
        width      : 90%;
        min-height : 75px;
        margin     : 5%;
        cursor     : pointer;
    }

    textarea {
        width      : 93%;
        padding    : 5px;
        min-height : 100px;
        resize     : vertical;
    }

    .agregado {
        width      : 100%;
        margin     : 1%;
        padding    : 4px;
        min-height : 20px;
        word-wrap  : break-word;
    }

    .fin {
        background : rgba(145, 192, 95, 0.2)
    }

    .proposito {
        background : rgba(110, 182, 213, 0.2)
    }

    .linea {
        width  : 95%;
        margin : 1.5%;
        height : 1px;
        border : 1px solid black;
    }
    </style>
</head>

<body>

<div class="body">

    <g:form action="guardarMarco" class="marcoLogico">
        <div id="divSubmit">
            <input type="hidden" name="proyecto" value="${proyecto.id}" id="proyecto">
            <input type="hidden" name="proyectoId" value="${proyecto.id}" id="id">
            <input type="hidden" name="edicion" value="1" id="edicion">
        </div>

        <div class="dialog col-md-12 panel panel-primary" title="MARCO LOGICO">
            <div class="btn-toolbar toolbar col-md-3" style="margin-bottom: 15px">
                <div class="btn-group">
                    <g:link controller="proyecto" action="proy" id="${proyecto?.id}" class="btn btn-default" title="Regresar al proyecto">
                        <i class="fa fa-arrow-left"></i> Regresar
                    </g:link>
                    <a href="#" id="btnEditarMarcoLogico" class="btn btn-success">
                        <i class="fa fa-edit"></i> Editar
                    </a>
                </div>
            </div>
            <div class="panel-primary col-md-9" style="text-align: center; float: right; margin-left: -70px; width: 900px">
                <h4>MARCO LOGICO: <strong style="color: #5596ff">${proyecto?.nombre}</strong></h4>
            </div>


            <div style="width: 100%;float: left;border: 1px solid" class="panel panel-primary">

                <div class="matriz ui-corner-all campo cmp datos " ml="Fin" div="div_fin"
                     identificador="${fin?.id}">
                    <div class="titulo">Fin</div>

                    <div class="texto agregado ui-corner-all fin" style="min-height: 75px;" id="div_fin"
                         identificador="${fin?.id}">
                        ${fin?.objeto}
                    </div>
                </div>

                <div class="matriz ui-corner-all campo cmpDoble " id="div_indi_medios_fin">
                    <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                        <div class="titulo">Indicadores</div>
                    </div>

                    <div class="filaMedio2" style="min-height: 25px;margin-top: 0px">
                        <div class="titulo">Medios de Verificación</div>
                    </div>
                    <g:set var="band" value="0"></g:set>
                    <g:each in="${indicadores}" var="indicador" status="i">
                        <g:set var="band" value="1"></g:set>
                        <div class="matriz ui-corner-all  fila " id="ind"
                             style="${(i == 0) ? 'margin-top:-10px;' : ''}">
                            <div class="filaMedio izq ">
                                <div class="texto agregado ui-corner-all fin varios  " pref="if_"
                                     id="if_${indicador.id}" ml="Fin" tipo="1" div="if_${indicador.id}"
                                     identificador="${indicador.id}" indicador="${fin.id}">
                                    ${indicador?.descripcion}
                                </div>
                            </div>

                            <div class="filaMedio2 der">
                                <g:each in="${proyectos.MedioVerificacion.findAllByIndicador(indicador)}" var="med">
                                    <div class="texto agregado ui-corner-all md fin varios" pref="mf_"
                                         id="mf_${med.id}"
                                         ml="Fin" tipo="2" div="mf_${med.id}" indicador="${indicador.id}"
                                         identificador="${med.id}">${med.descripcion}</div>
                                </g:each>
                            </div>
                        </div>
                    </g:each>

                %{--                <div class="matriz ui-corner-all  fila " id="ind"--}%
                %{--                     style="${(band.toInteger() == 0) ? 'margin-top:-10px;' : ''}">--}%
                %{--                    <div class="filaMedio izq ">--}%
                %{--                        <div class="texto agregado ui-corner-all fin varios edicion  " pref="if_" id="if_0"--}%
                %{--                             ml="Fin"--}%
                %{--                             div="if_0" tipo="1" identificador="0" indicador="${fin?.id}">--}%
                %{--                            Agregar--}%
                %{--                        </div>--}%
                %{--                    </div>--}%

                %{--                    <div class="filaMedio der">--}%
                %{--                        <div class=" texto agregado ui-corner-all md fin varios edicion" pref="mf_"--}%
                %{--                             id="mf_0"--}%
                %{--                             ml="Fin" div="mf_0" indicador="0" tipo="2" identificador="0">Agregar</div>--}%
                %{--                    </div>--}%
                %{--                </div>--}%

                </div>


                <div class="matriz ui-corner-all campo supuesto">
                    <div class="titulo">Supuestos</div>

                    <div class="texto" style=" min-height: 75px;" id="supuestos">
                        <g:each in="${sup}" var="su">
                            <div class="agregado ui-corner-all fin varios" id="sf_${su.id}" ml="Fin"
                                 div="sf_${su.id}"
                                 identificador="${su.id}" tipo="3"
                                 indicador="${fin?.id}">${su.descripcion}</div>
                        </g:each>
                    %{--                    <div class="agregado ui-corner-all md fin varios editar edicion" id="sf_0" ml="Fin"--}%
                    %{--                         div="sf_0"--}%
                    %{--                         identificador="0" tipo="3" indicador="${fin?.id}">Agregar</div>--}%
                    </div>
                </div>

            </div>%{--end del fin--}%

            <div style="width: 100%;float: left;border: 1px solid  rgba(110, 182, 213,0.6);margin-top: 5px; margin-bottom: 30px"
                 class="ui-corner-all">
                <div class="matriz ui-corner-all campoProp cmp datos" ml="Proposito" div="div_prop"
                     identificador="${proposito?.id}">
                    <div class="titulo">Propósito</div>

                    <div class="texto agregado ui-corner-all proposito" style="min-height: 115px;" id="div_prop"
                         identificador="${proposito?.id}">
                        ${proposito?.objeto}
                    </div>

                </div>


                <div class="matriz ui-corner-all  cmpDoble  campoProp" id="div_indi_medios_prop">
                    <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                        <div class="titulo">Indicadores</div>
                    </div>

                    <div class="filaMedio2" style="min-height: 25px;margin-top: 0px">
                        <div class="titulo">Medios de Verificación</div>
                    </div>
                    <g:set var="band" value="0"/>
                    <g:each in="${indiProps}" var="indiProp" status="i">
                        <g:set var="band" value="1"/>
                        <div class="matriz ui-corner-all  fila " id="ind"
                             style="${(i == 0) ? 'margin-top:-10px;' : ''}">
                            <div class="filaMedio izq ">
                                <div class="texto agregado ui-corner-all proposito varios"
                                     pref="div_indicador_prop_"
                                     id="div_indicador_prop_${indiProp.id}" ml="Proposito" tipo="1"
                                     div="div_indicador_prop_${indiProp.id}" identificador="${indiProp.id}"
                                     indicador="${proposito?.id}">
                                    ${indiProp?.descripcion}
                                </div>
                            </div>

                            <div class="filaMedio2 der">
                                <g:each in="${proyectos.MedioVerificacion.findAllByIndicador(indiProp)}" var="med">
                                    <div class="texto agregado ui-corner-all md proposito varios" pref="mp_"
                                         id="mp_${med.id}" ml="Proposito" div="mp_${med.id}"
                                         indicador="${indiProp.id}"
                                         tipo="2" identificador="${med.id}">${med.descripcion}</div>
                                </g:each>
                            %{--                            <div class=" texto agregado ui-corner-all md proposito varios edicion"--}%
                            %{--                                 pref="mp_"--}%
                            %{--                                 id="mp_0${i + 1}" ml="Proposito" div="mp_0${i + 1}" tipo="2"--}%
                            %{--                                 indicador="${indiProp.id}" identificador="0">Agregar</div>--}%
                            </div>
                        </div>
                    </g:each>

                %{--                <div class="matriz ui-corner-all  fila " id="ind"--}%
                %{--                     style="${(band.toInteger() == 0) ? 'margin-top:-10px;' : ''}">--}%
                %{--                    <div class="filaMedio izq ">--}%
                %{--                        <div class="texto agregado ui-corner-all proposito varios edicion  "--}%
                %{--                             pref="div_indicador_prop_" id="div_indicador_prop_0" ml="Proposito"--}%
                %{--                             div="div_indicador_prop_0" identificador="0" tipo="1"--}%
                %{--                             indicador="${proposito?.id}">--}%
                %{--                            Agregar--}%
                %{--                        </div>--}%
                %{--                    </div>--}%
                %{--                </div>--}%
                </div>


                <div class="matriz ui-corner-all campoProp supuesto">
                    <div class="titulo">Supuestos</div>

                    <div class="texto" style=" min-height: 115px;" id="div_sup_prop">
                        <g:each in="${supProp}" var="su">
                            <div class="agregado ui-corner-all proposito varios" id="sp_${su.id}" ml="Proposito"
                                 div="sp_${su.id}" identificador="${su.id}" tipo="3"
                                 indicador="${proposito?.id}">${su.descripcion}</div>
                        </g:each>
                    </div>
                </div>

            </div>%{--end del proposito--}%


        %{--      inicio Componente--}%

        <g:each in="${componentes}" var="componente">
            <div style="width: 100%;float: left;border: 1px solid" class="panel panel-primary">

                <div class="matriz ui-corner-all campo cmp datos " ml="Componente" div="div_componente"
                     identificador="${componente?.id}">
                    <div class="titulo">Componente</div>

                    <div class="texto agregado ui-corner-all fin" style="min-height: 75px;" id="div_componente"
                         identificador="${componente?.id}">
                        ${componente?.objeto}
                    </div>
                </div>

                <div class="matriz ui-corner-all campo cmpDoble " id="div_indi_medios_componente">
                    <div class="filaMedio" style="min-height: 25px;margin-top: 0px">
                        <div class="titulo">Indicadores</div>
                    </div>

                    <div class="filaMedio2" style="min-height: 25px;margin-top: 0px">
                        <div class="titulo">Medios de Verificación</div>
                    </div>
                    <g:set var="band" value="0"/>
                    <g:each in="${proyectos.Indicador.findAllByMarcoLogico(componente).sort{it.descripcion}}" var="indicador" status="i">
                        <g:set var="band" value="1"/>
                        <div class="matriz ui-corner-all  fila " id="ind"
                             style="${(i == 0) ? 'margin-top:-10px;' : ''}">
                            <div class="filaMedio izq ">
                                <div class="texto agregado ui-corner-all componente varios  " pref="ic_"
                                     id="ic_${indicador.id}" ml="Componente" tipo="1" div="ic_${indicador.id}"
                                     identificador="${indicador.id}" indicador="${componente.id}">
                                    ${indicador?.descripcion}
                                </div>
                            </div>

                            <div class="filaMedio2 der">
                                <g:each in="${proyectos.MedioVerificacion.findAllByIndicador(indicador)}" var="med">
                                    <div class="texto agregado ui-corner-all md componente varios" pref="mc_"
                                         id="mc_${med.id}"
                                         ml="Componente" tipo="2" div="mc_${med.id}" indicador="${indicador.id}"
                                         identificador="${med.id}">${med.descripcion}</div>
                                </g:each>
                            </div>
                        </div>
                    </g:each>
                </div>

                <div class="matriz ui-corner-all campo supuesto">
                    <div class="titulo">Supuestos</div>

                    <div class="texto" style=" min-height: 75px;" id="div_sup_comp">
                        <g:each in="${proyectos.Supuesto.findAllByMarcoLogico(componente).sort{it.descripcion}}" var="su">
                            <div class="agregado ui-corner-all componente varios" id="sc_${su.id}" ml="Componente"
                                 div="sc_${su.id}"
                                 identificador="${su.id}" tipo="3"
                                 indicador="${fin?.id}">${su.descripcion}</div>
                        </g:each>
                    </div>
                </div>

            </div>
        </g:each>%{--end del componente--}%

        </div>
    </g:form>
</div>

<script type="text/javascript">

    $("#btnEditarMarcoLogico").click(function () {
        location.href="${createLink(controller: 'marcoLogico', action: 'showMarco')}/" + '${proyecto?.id}'
    })

</script>

</body>

</html>
