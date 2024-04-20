package com.example.demo6.repo;

import com.example.demo6.entity.Role;
import com.example.demo6.entity.Status;

import java.util.List;
import java.util.UUID;

public class StatusRepo extends BaseRepo<Status, UUID> {
    public Status findById(UUID id) {
        return em.createQuery("select t from Status t where t.id = :id", Status.class)
                .setParameter("id", id)
                .getSingleResult();
    }
    public List<Status> getAll() {
        return em.createQuery("from Status ", Status.class).getResultList();
    }

    public Status findByName(String name) {
        return em.createQuery("select t from Status t where t.status = :name", Status.class)
                .setParameter("name", name)
                .getSingleResult();
    }
}
