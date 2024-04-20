package com.example.demo6.repo;

import com.example.demo6.entity.User;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityManagerFactory;
import jakarta.persistence.Persistence;

import java.lang.reflect.ParameterizedType;
import java.lang.reflect.Type;
import java.util.List;
import java.util.UUID;

public class BaseRepo<T, I> {


    public static final EntityManagerFactory entityManagerFactory = Persistence.createEntityManagerFactory("demo6");
    protected static final EntityManager em = entityManagerFactory.createEntityManager();
    private final Class<T> persistenceClass;

    public BaseRepo() {
         this.persistenceClass = (Class<T>) ((ParameterizedType) getClass().getGenericSuperclass()).getActualTypeArguments()[0].getClass();
    }

    public void begin() {
        em.getTransaction().begin();
    }
    public void commit() {
        em.getTransaction().commit();
    }
    public void save(T t) {
        begin();
        em.persist(t);
        commit();
    }

//    public List<T> findAll() {
//        return em.createQuery(" from " + persistenceClass.getSimpleName(), persistenceClass).getResultList();
//    }

    public void deleteById(I id) {
        begin();
        T t = em.find(persistenceClass, id);
        em.remove(t);
        commit();
    }
}
