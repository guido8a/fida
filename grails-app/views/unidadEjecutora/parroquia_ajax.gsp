<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 19/08/20
  Time: 11:53
--%>

<g:select name="parroquia" from="${parroquias}" class="form-control" optionValue="nombre" optionKey="id" value="${unidad?.parroquia?.id}"/>