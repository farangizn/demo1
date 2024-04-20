package com.example.demo6.config;

import com.example.demo6.entity.Order;
import com.example.demo6.entity.Role;
import com.example.demo6.entity.Status;
import com.example.demo6.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;
import jakarta.servlet.ServletContextEvent;
import jakarta.servlet.ServletContextListener;
import jakarta.servlet.annotation.WebListener;

import java.util.ArrayList;
import java.util.List;

//@WebListener
public class MyListener implements ServletContextListener {
    public static EntityManagerFactory entityManagerFactory;
    public static EntityManager entityManager;
    @Override
    public void contextInitialized(ServletContextEvent sce) {
        entityManagerFactory = Persistence.createEntityManagerFactory("demo6");
        entityManager = entityManagerFactory.createEntityManager();
//        initData();
        ServletContextListener.super.contextInitialized(sce);
    }

    private void initData() {
        entityManager.getTransaction().begin();
        Role superAdmin = Role.builder().role("SuperAdmin").build();
        Role admin = Role.builder().role("Admin").build();
        Role user1 = Role.builder().role("User").build();
        entityManager.persist(superAdmin);
        entityManager.persist(admin);
        entityManager.persist(user1);
        List<Role> roles = new ArrayList<>(List.of(superAdmin, admin, user1));
        Status open = Status.builder().status("Open").build();
        Status inProgress = Status.builder().status("In progress").build();
        Status complete = Status.builder().status("Complete").build();
        entityManager.persist(open);
        entityManager.persist(inProgress);
        entityManager.persist(complete);

        User user = User.builder()
                .age(18)
                .email("eshmat@gmail.com")
                .password("root123")
                .firstName("Eshmat")
                .roles(roles)
                .lastName("Toshmatov")
                .build();
        entityManager.persist(user);

        entityManager.getTransaction().commit();
    }
}
