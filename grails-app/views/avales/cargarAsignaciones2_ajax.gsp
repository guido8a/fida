<%--
  Created by IntelliJ IDEA.
  User: luz
  Date: 07/04/15
  Time: 01:31 PM
--%>

<script type="text/javascript" src="${resource(dir: 'js', file: 'ui.js')}"></script>
<script type="text/javascript" src="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/js', file: 'bootstrap-select.js')}"></script>
<link href="${resource(dir: 'js/plugins/bootstrap-select-1.6.3/dist/css', file: 'bootstrap-select.min.css')}" rel="stylesheet">

<elm:select name="asg_dest" from="${asgs}" optionKey="id" id="asignacion_dest" optionClass="planificado"
            optionValue='${{
                "Monto: " + g.formatNumber(number: it.planificado, type: "currency", currencySymbol: " ") + ", Partida: " + it.presupuesto.numero + ", Fuente: " + it.fuente.codigo
            }}' noSelection="['-1': 'Seleccione..']" class="form-control input-sm required requiredCombo"/>
