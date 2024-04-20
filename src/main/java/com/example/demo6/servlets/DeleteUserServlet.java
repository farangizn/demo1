package com.example.demo6.servlets;

import com.example.demo6.entity.User;
import com.example.demo6.repo.UserRepo;
import jakarta.persistence.EntityManager;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.UUID;

@WebServlet(name = "delete user", value = "/superadmin/user/delete")
public class DeleteUserServlet extends HttpServlet {
    UserRepo userRepo = new UserRepo();
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User u = userRepo.findById(UUID.fromString(req.getParameter("userId")));
        userRepo.delete(u);
        resp.sendRedirect("/superadmin/user.jsp");
    }
}