<%@ page import="java.util.Map" %>
<%@ page import="java.util.HashMap" %>
<%@ page import="java.util.Objects" %>
<%@ page import="com.example.demo6.repo.StatusRepo" %>
<%@ page import="com.example.demo6.entity.Status" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo6.repo.UserRepo" %>
<%@ page import="com.example.demo6.entity.User" %><%--
  Created by IntelliJ IDEA.
  User: Farangiz
  Date: 4/19/2024
  Time: 10:50 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/static/bootstrap.min.css">
</head>
<%
    StatusRepo statusRepo = new StatusRepo();
    List<Status> statuses = statusRepo.getAll();
    UserRepo userRepo = new UserRepo();
    List<User> users = userRepo.getAll();
%>
<style>
    /* Custom styles for this page */
    body {
        display: flex;
        justify-content: center;
        align-items: center;
        height: 100vh;
        background-color: #343a40;
    }
    .card {
        width: 400px;
        padding: 20px;
        border-radius: 10px;
        box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    }
</style>
<body>
<div class="row mt-4">
    <div class="col-4 offset-4">
        <div class="card p-2">
            <h1>Add order</h1>
            <form method="post" action="/admin/order/add">
                <select name="status" class="form-control my-3">
                    <% for (Status status : statuses) { %>
                    <option value="<%=status.getId()%>"><%=status.getStatus()%></option>
                    <% } %>
                </select>
                <select name="user" class="form-control my-3">
                    <% for (User user : users) { %>
                    <option value="<%=user.getId()%>"><%=user.getFirstName() + " " + user.getLastName()%></option>
                    <% } %>
                </select>
                <div class="text-center">
                    <button class="btn btn-dark w-100">save</button>
                </div>
            </form>
        </div>
    </div>
</div>

</body>
</html>
