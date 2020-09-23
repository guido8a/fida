<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 23/09/20
  Time: 11:38
--%>
<span>
    <label>
        Fuente
    </label>
<g:select name="fuente" from="${parametros.proyectos.Fuente.list().sort{it.descripcion}}" class="form-control" optionKey="id" optionValue="descripcion"/>
    <label>
        Año
    </label>
    <g:select name="anio" from="${parametros.Anio.list().sort{it.anio}}" class="form-control" optionKey="id" optionValue="anio"/>
</span>