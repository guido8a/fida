<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 18/01/22
  Time: 15:44
--%>

<span>
    <label>
        Año
    </label>
   <g:select name="anioCrono" id="anioCrono" from="${parametros.Anio.list().sort{it.anio}}" optionKey="id" optionValue="anio" class="form-control"/>
</span>

<script type="text/javascript">


</script>