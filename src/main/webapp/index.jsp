<%@ page import="com.example.demo6.repo.OrderRepo" %>
<%@ page import="com.example.demo6.entity.Order" %>
<%@ page import="java.util.List" %>
<%@ page import="com.example.demo6.entity.Status" %>
<%@ page import="com.example.demo6.repo.StatusRepo" %>
<%@ page import="java.util.UUID" %>
<%@ page import="com.example.demo6.entity.User" %>
<%@ page import="com.example.demo6.repo.UserRepo" %>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html>
<head>
    <title>JSP - Hello World</title>
    <link rel="stylesheet" href="static/bootstrap.min.css">
</head>
<%
    OrderRepo orderRepo = new OrderRepo();
    List<Order> orders = orderRepo.findAll();
    StatusRepo statusRepo = new StatusRepo();

    String statusIdParam = request.getParameter("statusId");
    UUID statusId = null;
    if (statusIdParam != null && !statusIdParam.isEmpty()) {
        try {
            statusId = UUID.fromString(statusIdParam);
        } catch (IllegalArgumentException e) {
            // Handle invalid UUID parameter if needed
            e.printStackTrace();
        }
    }

    Status status = null;
    if (statusId != null) {
        status = statusRepo.findById(statusId);
    }
    UserRepo userRepo = new UserRepo();
    Object object = request.getSession().getAttribute("currentUser");
    User cookieUser = null;
    for (Cookie cookie : request.getCookies()) {
        if (cookie.getName().equals("userId")) {
            UUID userId = UUID.fromString(cookie.getValue());
            cookieUser = userRepo.findById(userId);
        }
    }



%>
<body>

<div class="container">
    <!-- Navbar with buttons -->
    <nav class="navbar navbar-expand-lg navbar-light bg-light mb-4">
        <a class="navbar-brand" href="#">Orders Dashboard</a>
        <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
            <span class="navbar-toggler-icon"></span>
        </button>

        <div class="collapse navbar-collapse" id="navbarSupportedContent">
            <ul class="navbar-nav mr-auto">
                <li class="nav-item">
                    <a class="nav-link" href="/index.jsp">All</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/index.jsp?statusId=<%=statusRepo.findByName("Open").getId()%>">Open</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/index.jsp?statusId=<%=statusRepo.findByName("In progress").getId()%>">In Progress</a>
                </li>
                <li class="nav-item">
                    <a class="nav-link" href="/index.jsp?statusId=<%=statusRepo.findByName("Complete").getId()%>">Complete</a>
                </li>
            </ul>
        </div>
        <div>
            <% if (object != null) { %>
            <%User user = (User) object; %>
            <a class="nav-link" href="info.jsp?userId=<%=user.getId()%>">my info</a>
            <% } else if (cookieUser != null){ %>
            <a class="nav-link" href="info.jsp?userId=<%=cookieUser.getId()%>">my info</a>
            <% } else { %>
            <a class="nav-link" href="/auth/login.jsp">Login</a>
            <% } %>
<%--            <a href="/auth/login.jsp"><button>login</button></a>--%>
        </div>
    </nav>
    <table class="table table-bordered">
        <thead class="thead-dark">
        <tr>
            <th>Date/Time</th>
            <th>Status</th>
            <th>User</th>
        </tr>
        </thead>
        <tbody>
        <% for (Order order : orders) { %>
        <% if (status != null) { %>
            <% if (order.getStatus().getId().equals(status.getId())) { %>
        <tr>
            <td><%=order.getDateTime()%></td>
            <td><%=order.getStatus().getStatus()%></td>
            <td><%=order.getUser().getEmail()%></td>
        </tr>
        <% } } else { %>
        <tr>
            <td><%=order.getDateTime()%></td>
            <td><%=order.getStatus().getStatus()%></td>
            <td><%=order.getUser().getEmail()%></td>
        </tr>
        <% } } %>
        </tbody>
    </table>
</div>

</body>
</html>