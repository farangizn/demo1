package com.example.demo6.servlets;

import com.example.demo6.entity.Role;
import com.example.demo6.entity.User;
import com.example.demo6.repo.RoleRepo;
import com.example.demo6.repo.UserRepo;
import jakarta.persistence.EntityManager;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.validation.ConstraintViolation;
import jakarta.validation.Validation;
import jakarta.validation.Validator;
import jakarta.validation.ValidatorFactory;

import java.io.IOException;
import java.util.*;

@WebServlet(name = "edit user", value = "/superadmin/user/edit")
public class EditUserServlet extends HttpServlet {
    RoleRepo roleRepo = new RoleRepo();
    UserRepo userRepo = new UserRepo();

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String[] rolesIds = req.getParameterValues("role");
        List<Role> roles = new ArrayList<>();
        for (String role : rolesIds) {
            roles.add(roleRepo.findById(UUID.fromString(role)));
        }
        UUID id = UUID.fromString(req.getParameter("id"));
        String firstName = req.getParameter("firstName");
        String lastName = req.getParameter("lastName");
        int age = Integer.parseInt(req.getParameter("age"));
        String password = req.getParameter("password");
        String email = req.getParameter("email");
        String passwordRepeat = req.getParameter("passwordRepeat");
        if (!password.equals(passwordRepeat)) {
            resp.sendRedirect("/superadmin/editUser.jsp");
            return;
        }
        User user = userRepo.findById(id);
        user.setFirstName(firstName);
        user.setLastName(lastName);
        user.setEmail(email);
        user.setPassword(password);
        user.setAge(age);

        ValidatorFactory validatorFactory = Validation.buildDefaultValidatorFactory();
        Validator validator = validatorFactory.getValidator();
        Set<ConstraintViolation<User>> constraintViolations = validator.validate(user);

        if (constraintViolations.isEmpty()) {
            userRepo.save(user);
            resp.sendRedirect("/superadmin/user.jsp");
        } else {
            Map<String, String> map = new HashMap<>();
            for (ConstraintViolation<?> constraintViolation : constraintViolations) {
                map.put(constraintViolation.getPropertyPath().toString(), constraintViolation.getMessage());
            }
            req.setAttribute("errors", map);
            RequestDispatcher requestDispatcher = req.getRequestDispatcher("/superadmin/editUser.jsp");
            requestDispatcher.forward(req, resp);
            resp.sendRedirect("/superadmin/editUser.jsp");
        }
    }
}
