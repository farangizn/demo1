package com.example.demo6.servlets;

import com.example.demo6.config.MyFilter;
import com.example.demo6.entity.Role;
import com.example.demo6.entity.User;
import com.example.demo6.repo.RoleRepo;
import com.example.demo6.repo.UserRepo;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Optional;

@WebServlet(name = "login", value = "/auth/login")
public class LoginServlet extends HttpServlet {
    UserRepo userRepo = new UserRepo();
    RoleRepo roleRepo = new RoleRepo();
    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String email = req.getParameter("email");
        String password = req.getParameter("password");
        Optional<User> user = userRepo.findUserByCredentials(email, password);
//        System.out.printf(user.get().getEmail());
        String rememberMe = req.getParameter("rememberMe");

        if (user.isPresent()) {
//            System.out.printf("user is present");
            req.getSession().setAttribute("currentUser", user.get());
            if (rememberMe != null && rememberMe.equals("on"))  {
//                System.out.printf("user wants to be remembered");
                Cookie cookie = new Cookie("userId", user.get().getId().toString());
                cookie.setSecure(false);
                cookie.setMaxAge(60 * 60 * 5); // 5 hours expiration time
                cookie.setPath("/");
                resp.addCookie(cookie);
            }

            if (user.get().getRoles().contains(roleRepo.findByName("Admin"))) {
                resp.sendRedirect("/admin/order.jsp");
                MyFilter.openPages.add("/admin/order.jsp");
            } else if (user.get().getRoles().contains(roleRepo.findByName("SuperAdmin"))) {
                MyFilter.openPages.add("/admin/order.jsp");
                MyFilter.openPages.add("/superadmin/user.jsp");
                resp.sendRedirect("/superadmin/user.jsp");
            } else {
                resp.sendRedirect("/");
            }
            return;
        }
        resp.sendRedirect("/auth/login.jsp");
    }
}
