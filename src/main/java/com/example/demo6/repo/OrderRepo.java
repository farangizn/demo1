package com.example.demo6.repo;

import com.example.demo6.entity.Order;
import com.example.demo6.entity.User;

import java.util.List;
import java.util.UUID;

public class OrderRepo extends BaseRepo<Order, UUID> {
    public void update(User user, UUID id) {
        begin();
        User dbUser = em.find(User.class, id);
        dbUser.setEmail(user.getEmail());
        dbUser.setPassword(user.getPassword());
        commit();
    }
    public List<Order> findAll() {
        return entityManagerFactory.createEntityManager().createQuery(" from Order ", Order.class).getResultList();
    }
    public void save(Order order) {
        begin();
        em.persist(order);
        commit();
    }

    public Order findById(UUID id) {
        return em.createQuery("select t from Order t where t.id = :id", Order.class)
                .setParameter("id", id)
                .getSingleResult();
    }

    public void delete(Order order) {
        begin();
        em.remove(order);
        commit();
    }
}
