<%@ page import="java.util.UUID" %>
<%@ page import="com.example.demo6.repo.UserRepo" %>
<%@ page import="com.example.demo6.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: Farangiz
  Date: 4/20/2024
  Time: 5:15 AM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>My Info</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
    <style>
        table {
            width: 100%;
            border-collapse: collapse;
        }
        th, td {
            border: 1px solid black;
            padding: 8px;
            text-align: left;
        }
    </style>
</head>
<%
    UserRepo userRepo =  new UserRepo();
    UUID id = UUID.fromString(request.getParameter("userId"));
    User user = userRepo.findById(id);
%>
<body>
<h1>My info</h1>
<table>
    <thead>
    <tr>
        <th>Name</th>
        <th>Surname</th>
        <th>Email</th>
        <th>Age</th>
    </tr>
    </thead>
    <tbody>
    <tr>
        <td><%=user.getFirstName()%></td>
        <td><%=user.getLastName()%></td>
        <td><%=user.getEmail()%></td>
        <td><%=user.getAge()%></td>
    </tr>
    </tbody>
</table>
<a class="nav-link" href="/auth/logout">log out</a>
</body>
</html>
