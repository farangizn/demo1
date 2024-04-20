package com.example.demo6.servlets;

import com.example.demo6.entity.Order;
import com.example.demo6.repo.OrderRepo;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "delete order", value = "/admin/order/delete")
public class DeleteOrderServlet extends HttpServlet {
    OrderRepo orderRepo = new OrderRepo();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        Order order = orderRepo.findById(UUID.fromString(req.getParameter("orderId")));
        orderRepo.delete(order);
        resp.sendRedirect("/admin/order.jsp");
    }
}
