<%--
  Created by IntelliJ IDEA.
  User: fabricio
  Date: 15/11/21
  Time: 16:16
--%>

<table class="table table-bordered table-hover table-condensed">
    <thead>
    <tr style="width: 100%">
        <th style="width: 70%">Etnia</th>
        <th style="width: 30%">Cantidad</th>
    </tr>
    </thead>
    <tbody>
    <g:each in="${etnias}" var="etnia">
        <tr style="width: 100%">
            <td style="width: 70%">${etnia?.razadscr}</td>
            <td style="width: 30%; text-align: center">${etnia?.razacntd}</td>
        </tr>
    </g:each>
    </tbody>
</table>

