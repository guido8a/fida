<%@ page import="seguridad.TipoInstitucion" %>
<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 22/09/20
  Time: 12:00
--%>
<span>
    <label>
        Organizaciones
    </label>
<g:select name="organizacion" from="${seguridad.UnidadEjecutora.findAllByTipoInstitucion(seguridad.TipoInstitucion.get(2)).sort{it.nombre}}"
          class="form-control" optionKey="id" optionValue="nombre"/>
</span>