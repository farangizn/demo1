package com.example.demo6.repo;

import com.example.demo6.entity.Order;
import com.example.demo6.entity.Role;
import com.example.demo6.entity.Status;
import jakarta.persistence.EntityManager;

import java.util.List;
import java.util.UUID;

public class RoleRepo extends BaseRepo<Role, UUID> {

    public Role findByName(String name) {
        return em.createQuery("select t from Role t where t.role = :role", Role.class)
                .setParameter("role", name)
                .getSingleResult();
    }

    public List<Role> getAll() {
        return em.createQuery("from Role", Role.class).getResultList();
    }
    public Role findById(UUID id) {
        return em.createQuery("select t from Role t where t.id = :id", Role.class)
                .setParameter("id", id)
                .getSingleResult();
    }

    public List<Role> getSimpleUser() {
        return em.createQuery("select t from Role t where t.role = :roleName", Role.class)
                .setParameter("roleName", "User")
                .getResultList();
    }
}
