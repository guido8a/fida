<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 22/09/20
  Time: 11:27
--%>

<g:select name="provincia" from="${geografia.Provincia.list().sort{it.nombre}}" class="form-control" optionKey="id" optionValue="nombre"/>