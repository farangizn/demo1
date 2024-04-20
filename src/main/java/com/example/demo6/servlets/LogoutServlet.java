package com.example.demo6.servlets;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet(name = "log out", value = "/auth/logout")
public class LogoutServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {

        req.getSession().invalidate();
        for (Cookie cookie : req.getCookies()) {
            cookie.setMaxAge(0);
            cookie.setPath("/");
            cookie.setSecure(false);
            resp.addCookie(cookie);
        }
        resp.sendRedirect("/");
    }
}
