<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/08/20
  Time: 15:55
--%>

<g:select name="grupoActividad" from="${actividades}" optionValue="descripcion" optionKey="id" class="form-control"
          value="${plan?.grupoActividad?.id}"/>