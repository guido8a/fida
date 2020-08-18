<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 17/08/20
  Time: 15:55
--%>

<g:select name="marcoLogico" from="${actividades}" optionValue="objeto" optionKey="id" class="form-control" value="${plan?.marcoLogico?.id}"/>