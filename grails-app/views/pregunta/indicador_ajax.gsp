<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/09/20
  Time: 10:12
--%>

<g:select from="${indicadores}" optionKey="id" name="indicador" value="${pregunta?.indicador?.id}"
          class="many-to-one form-control input-sm required"
          noSelection="${[0:'Seleccione']}"/>