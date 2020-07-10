<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 10/07/20
  Time: 10:26
--%>

<g:select name="comunidad" from="${cantones}" optionValue="nombre" optionKey="id" class="form-control" value="${taller?.comunidad?.id}" noSelection="${[null:'Ninguna']}"/>