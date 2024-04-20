package com.example.demo6.servlets;

import com.example.demo6.entity.Order;
import com.example.demo6.repo.OrderRepo;
import com.example.demo6.repo.StatusRepo;
import com.example.demo6.repo.UserRepo;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "edit order", value = "/admin/order/edit")
public class EditOrderServlet extends HttpServlet {
    OrderRepo orderRepo = new OrderRepo();
    UserRepo userRepo = new UserRepo();
    StatusRepo statusRepo = new StatusRepo();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID orderId = UUID.fromString(req.getParameter("id"));
        UUID userId = UUID.fromString(req.getParameter("user"));
        UUID statusId = UUID.fromString(req.getParameter("status"));
        Order order = orderRepo.findById(orderId);
        order.setUser(userRepo.findById(userId));
        order.setStatus(statusRepo.findById(statusId));
        orderRepo.save(order);
        resp.sendRedirect("/admin/order.jsp");
    }
}