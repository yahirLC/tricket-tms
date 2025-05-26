<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>Lista de Logs</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.6/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-4Q6Gf2aSP4eDXB8Miphtr37CMZZQ5oXLH2yaXMJ2w8e2ZtHTl7GptT4jmndRuHDT" crossorigin="anonymous">
</head>
<body class="bg-light">

    <div class="container mt-5">
        <h1 class="text-center mb-4">Logs</h1>
        <table class="table table-bordered table-hover table-striped">
            <thead class="table-primary">
                <tr>
                    <th>ID</th>
                    <th>TICKET_ID</th>
                    <th>USUARIO_ID</th>
                    <th>COMENTARIO</th>
                    <th>FECHA</th>
                </tr>
            </thead>
            <tbody>
                <c:forEach var="com" items="${comentarios}">
                    <tr>
                        <td>${com.id}</td>
                        <td>${com.ticket_id}</td>
                         <td>${com.usuario_id}</td>
                        <td>${com.comentario}</td>
                        <td>${com.fecha}</td>
                    </tr>
                </c:forEach>
            </tbody>
        </table>
    </div>

</body>
</html>
