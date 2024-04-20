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
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "addOrder", value = "/admin/order/add")
public class AddOrder extends HttpServlet {
    UserRepo userRepo = new UserRepo();
    StatusRepo statusRepo = new StatusRepo();
    OrderRepo orderRepo = new OrderRepo();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        UUID statusId = UUID.fromString(req.getParameter("status"));
        UUID userId = UUID.fromString(req.getParameter("user"));

        Order order = new Order();
        order.setUser(userRepo.findById(userId));
        order.setStatus(statusRepo.findById(statusId));
        orderRepo.save(order);
        resp.sendRedirect("/admin/order.jsp");
    }
}