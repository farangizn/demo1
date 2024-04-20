<%@ page import="com.example.demo6.repo.OrderRepo" %>
<%@ page import="com.example.demo6.entity.Order" %>
<%@ page import="java.util.List" %><%--
  Created by IntelliJ IDEA.
  User: Farangiz
  Date: 4/19/2024
  Time: 10:32 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <title>User Management</title>
    <link rel="stylesheet" href="/static/bootstrap.min.css">
</head>
<body>
<%
    OrderRepo orderRepo = new OrderRepo();
    List<Order> orders = orderRepo.findAll();
%>
<style>
    body {
        padding-top: 70px; /* Adjust based on your navbar height */
        font-family: Arial, sans-serif;
    }
    .sidebar {
        height: 100%;
        width: 250px;
        position: fixed;
        top: 0;
        left: 0;
        background-color: #343a40; /* Blue background color */
        padding-top: 20px;
        color: #fff; /* Text color */
    }
    .sidebar a {
        padding: 10px 15px;
        text-decoration: none;
        font-size: 18px;
        color: #fff; /* Link text color */
        display: block;
        border-bottom: 1px solid #fff; /* Thin white line between links */
    }
    .sidebar a:last-child {
        border-bottom: none; /* Remove line from last link */
    }
    .sidebar a:hover {
        background-color: #555; /* Darker blue background color on hover */
    }
    .container-fluid {
        margin-left: 250px; /* Adjust to match sidebar width */
        padding: 20px;
    }
    .role-item {
        display: block;
        font-size: 14px; /* Adjust as needed for smaller text size */
        margin-bottom: 5px; /* Add spacing between role items */
    }
</style>
<div class="container-fluid">
    <div class="row">
        <div class="sidebar">
            <a href="/superadmin/user.jsp">User</a>
            <a href="/admin/order.jsp">Order</a>
        </div>
        <!-- Main Content -->
        <div class="col-md-9">
            <div class="px-4 py-4">
                <h2>User Management</h2>
                <p>This is the main content area where user.jsp or car.jsp will be displayed.</p>
                <a href="/admin/addOrder.jsp" class="btn btn-dark text-white mb-3">Add Order</a>
                <hr>
                <table class="table table-striped">
                    <thead>
                    <tr>
                        <th>Date/Time</th>
                        <th>Status</th>
                        <th>Belongs to</th>
                        <th>#</th>
                    </tr>
                    </thead>
                    <tbody>
                    <% for (Order order : orders) { %>
                    <tr>
                        <td><%= order.getDateTime() %></td>
                        <td><%= order.getStatus().getStatus() %></td>
                        <td><%= order.getUser().getFirstName() + " " + order.getUser().getLastName()%></td>
                        <td>
                            <a href="/admin/editOrder.jsp?orderId=<%= order.getId() %>" class="btn btn-success btn-sm">Edit</a>
                            <a href="/admin/order/delete?orderId=<%= order.getId() %>" class="btn btn-danger btn-sm">Delete</a>
                        </td>
                    </tr>
                    <% } %>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>
</html>
