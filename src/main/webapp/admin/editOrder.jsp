<%@ page import="java.util.UUID" %>
<%@ page import="com.example.demo6.repo.OrderRepo" %>
<%@ page import="com.example.demo6.entity.Order" %>
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
<%
    UUID id = UUID.fromString(request.getParameter("orderId"));
    OrderRepo orderRepo = new OrderRepo();
    Order order = orderRepo.findById(id);
    List<Order> orders = orderRepo.findAll();
    UserRepo userRepo = new UserRepo();
    List<User> users = userRepo.getAll();
%>
<body>
<div class="card">
    <h5 class="card-title text-center mb-4">Edit order</h5>
    <form action="/admin/order/edit?id=<%=order.getId()%>" method="post">
        <div class="form-group">
            <label for="status">Status</label>
            <select name="status" id="status">
                <option value="<%=order.getStatus().getId()%>" selected><%=order.getStatus().getStatus()%></option>
                <% for (Order o : orders) { %>
                <option value="<%=o.getId()%>"><%=o.getStatus()%></option>
                <% } %>
            </select>
        </div>
        <div class="form-group">
            <label for="user">Belongs to</label>
            <select name="user" id="user">
                <option value="<%=order.getUser().getId()%>" selected><%=order.getUser().getEmail()%></option>
                <% for (User user : users) { %>
                <option value="<%=user.getId()%>"><%=user.getEmail()%></option>
                <% } %>
            </select>
        </div>
        <button type="submit" class="btn btn-primary btn-block">Edit order</button>
    </form>

</div>
</body>
</html>
