%{--<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>--}%
%{--<script type="text/javascript" src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js', file: 'bootstrap-select.js')}"></script>--}%
%{--<link href="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/css', file: 'bootstrap-select.min.css')}" rel="stylesheet">--}%

<g:select name="asg" from="${asgs}" optionKey="id" id="asignacion" optionValue='${{
    "Monto: " + g.formatNumber(number: it.planificado, type: "currency", currencySymbol: " ") + ", Partida: " + it.presupuesto.numero + ", Fuente: " + it.fuente.codigo
}}' noSelection="['-1': 'Seleccione..']" class="form-control input-sm required requiredCombo" />


%{--
<elm:select name="asg" from="${asgs}" optionKey="id" id="asignacion"
            optionClass="${{
                it.fuente.codigo
            }}"
            optionValue='${{
                "Monto: " + g.formatNumber(number: it.priorizado, type: "currency", currencySymbol: " ") +
                        ", Partida: " + it.presupuesto.zona + ", Fuente: " + it.fuente.codigo
            }}'
            noSelection="['-1': 'Seleccione..']" class="form-control input-sm required requiredCombo"/>
--}%
<script>
    $("#asignacion").change(function () {
        var max = getMaximo($("#asignacion").val(), 0);
        $("#max").text(number_format(max, 2, '.', ',')).data("max", max);

/*
        if($(this).find("option:selected").attr("class") == "998") {
            $("#spanDevengado").removeClass("hidden");
        } else {
            $("#spanDevengado").addClass("hidden");
        }
*/
    });
</script>