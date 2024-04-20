<%@ page import="com.example.demo6.entity.User" %>
<%@ page import="com.example.demo6.repo.UserRepo" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo6.entity.Role" %><%--
  Created by IntelliJ IDEA.
  User: Farangiz
  Date: 4/19/2024
  Time: 10:34 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/static/bootstrap.min.css">
    <style>
        /* Custom styles can be added here */
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
</head>
<body>
<%
    UserRepo userRepo = new UserRepo();
    List<User> users = userRepo.getAll();
%>
<div class="sidebar">
    <a href="/superadmin/user.jsp">User</a>
    <a href="/admin/order.jsp">Order</a>
</div>
<div class="container-fluid">
    <h2>User</h2>
    <p>This is the main content area where user.jsp or car.jsp will be displayed.</p>
    <a href="/superadmin/addUser.jsp" class="btn btn-dark text-white">Add user</a>
    <hr>
    <table class="table table-striped">
        <thead>
        <tr>
            <th>Firstname</th>
            <th>Lastname</th>
            <th>Email</th>
            <th>Password</th>
            <th>Age</th>
            <th>Role(s)</th>
            <th>Actions</th>
        </tr>
        </thead>
        <tbody>
        <% for (User user : users) { %>
        <tr>
            <td><%= user.getFirstName() %></td>
            <td><%= user.getLastName() %></td>
            <td><%= user.getEmail() %></td>
            <td><%= user.getPassword() %></td>
            <td><%= user.getAge() %></td>
            <td>
                <% for (Role role : user.getRoles()) { %>
                <span class="role-item"><%= role.getRole() %></span><br>
                <% } %>
            </td>
            <td>
                <a href="/superadmin/editUser.jsp?userId=<%= user.getId() %>" class="btn btn-success">Edit</a>
                <a href="/superadmin/user/delete?userId=<%= user.getId() %>" class="btn btn-danger">Delete</a>
            </td>
        </tr>
        <% } %>
        </tbody>
    </table>
</div>

</body>
</html>
