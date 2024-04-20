<%@ page import="com.example.demo6.repo.UserRepo" %>
<%@ page import="com.example.demo6.entity.User" %>
<%@ page import="com.example.demo6.repo.RoleRepo" %>
<%@ page import="com.example.demo6.entity.Role" %>
<%@ page import="java.util.*" %><%--
  Created by IntelliJ IDEA.
  User: Farangiz
  Date: 4/19/2024
  Time: 11:23 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="/static/bootstrap.min.css">
</head>
<%
    UUID userId = UUID.fromString(request.getParameter("userId"));
    UserRepo userRepo = new UserRepo();
    User user = userRepo.findById(userId);
    RoleRepo roleRepo = new RoleRepo();
    List<Role> roles = roleRepo.getAll();
%>
<%
    Map<String, String> errors = new HashMap<>();
    Object object = request.getAttribute("errors");
    if (object != null) {
        errors = (Map<String, String>) object;
    }
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
            <h1>Add user</h1>
            <form method="post" action="http://localhost:8080/superadmin/user/edit?id=<%=user.getId()%>">
                <div class="form-group">
                    <input value="<%=user.getFirstName()%>" name="firstName" class="form-control my-3" type="text" placeholder="Firstname...">
                    <div class="invalid-feedback">Please enter your first name.</div>
                    <span class="text-danger small"><%=Objects.requireNonNullElse(errors.get("firstName"), "")%></span>
                </div>
                <div class="form-group">
                    <input value="<%=user.getLastName()%>" name="lastName" class="form-control my-3" type="text" placeholder="Lastname...">
                    <div class="invalid-feedback">Please enter your last name.</div>
                    <span class="text-danger small"><%=Objects.requireNonNullElse(errors.get("lastName"), "")%></span>
                </div>
                <div class="form-group">
                    <input value="<%=user.getAge()%>" type="number" class="form-control" name="age" placeholder="Age...">
                    <div class="invalid-feedback">Please enter your last name.</div>
                    <span class="text-danger small"><%=Objects.requireNonNullElse(errors.get("age"), "")%></span>
                </div>
                <div class="form-group">
                    <input value="<%=user.getEmail()%>" type="text" class="form-control" name="email" placeholder="Email...">
                    <div class="invalid-feedback">Please enter your last name.</div>
                    <span class="text-danger small"><%=Objects.requireNonNullElse(errors.get("email"), "")%></span>
                </div>
                <div class="form-group">
                    <input value="<%=user.getPassword()%>" type="text" class="form-control" name="password" placeholder="Password...">
                    <div class="invalid-feedback">Please enter your last name.</div>
                    <span class="text-danger small"><%=Objects.requireNonNullElse(errors.get("password"), "")%></span>
                </div>
                <div class="form-group">
                    <input value="<%=user.getPassword()%>" type="text" class="form-control" name="passwordRepeat" placeholder="Repeat password...">
                    <div class="invalid-feedback">Please enter your last name.</div>
                    <span class="text-danger small"><%=Objects.requireNonNullElse(errors.get("passwordRepeat"), "")%></span>
                </div>
                <select multiple name="role" class="form-control my-3">
                    <% for (Role role : roles) { %>
                    <% if (user.getRoles().contains(role)) { %>
                    <option value="<%=role.getId()%>" selected><%=role.getRole()%></option>
                    <% } else { %>
                    <option value="<%=role.getId()%>"><%=role.getRole()%></option>
                    <% } %>
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
