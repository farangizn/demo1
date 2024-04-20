package com.example.demo6.config;

import com.example.demo6.entity.User;
import com.example.demo6.repo.RoleRepo;
import com.example.demo6.repo.UserRepo;
import jakarta.servlet.*;
import jakarta.servlet.annotation.WebFilter;
import jakarta.servlet.http.Cookie;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@WebFilter(urlPatterns = "/*")
public class MyFilter implements Filter {
    RoleRepo roleRepo = new RoleRepo();
    UserRepo userRepo = new UserRepo();
    public static List<String> openPages = new ArrayList<>(List.of(
            "/auth/login.jsp", "/", "/auth/register.jsp",
            "/auth/register", "/auth/login", "/info.jsp",
            "/auth/logout", "/index.jsp"
    ));
    @Override
    public void doFilter(ServletRequest servletRequest, ServletResponse servletResponse, FilterChain filterChain) throws IOException, ServletException {
        HttpServletRequest request = (HttpServletRequest) servletRequest;
        HttpServletResponse response = (HttpServletResponse) servletResponse;
        Object object = request.getSession().getAttribute("currentUser");
        String requestURI = request.getRequestURI();
        if (openPages.contains(requestURI)) {
            filterChain.doFilter(servletRequest, servletResponse);
            return;
        }
        if (object != null) {
            User user = (User) object;
            if (user.hasRole(roleRepo.findByName("Admin")) || user.hasRole(roleRepo.findByName("SuperAdmin"))) {
                filterChain.doFilter(request, response);
                return;
            }
        }
        for (Cookie cookie : request.getCookies()) {
            if (cookie.getName().equals("userId")) {
                UUID userId = UUID.fromString(cookie.getValue());
                User user = userRepo.findById(userId);
                if (user != null) {
                    request.getSession().setAttribute("currentUser", user);
                    if (user.hasRole(roleRepo.findByName("Admin")) || user.hasRole(roleRepo.findByName("SuperAdmin"))) {
                        filterChain.doFilter(request, response);
                        return;
                    }
                    break;
                }
            }
        }

    }
}
