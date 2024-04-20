package com.example.demo6.repo;

import com.example.demo6.entity.Order;
import com.example.demo6.entity.Status;
import com.example.demo6.entity.User;

import java.util.List;
import java.util.Optional;
import java.util.UUID;

public class UserRepo extends BaseRepo<User, UUID> {

    public void update(User user, UUID id) {
        begin();
        User dbUser = em.find(User.class, id);
        dbUser.setEmail(user.getEmail());
        dbUser.setPassword(user.getPassword());
        commit();
    }

    public Optional<User> findUserByCredentials(String email, String password) {
        User user =
                em.createQuery("select t from User t where t.email = :email", User.class)
                        .setParameter("email", email)
                        .getSingleResult();
        if (user != null && user.getPassword().equals(password)) {
            return Optional.of(user);
        } else {
            return Optional.empty();
        }
    }
    public List<User> getAll() {
        return em.createQuery("from User ", User.class).getResultList();
    }

    public User findById(UUID userId) {
        return em.createQuery("select t from User t where t.id = :id", User.class)
                .setParameter("id", userId)
                .getSingleResult();
    }
    public void delete(User user) {
        begin();
        em.remove(user);
        commit();
    }
    public void save(User user) {
        begin();
        em.persist(user);
        commit();
    }
}
