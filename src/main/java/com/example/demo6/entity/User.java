package com.example.demo6.entity;

import jakarta.persistence.*;
import jakarta.validation.constraints.Email;
import lombok.*;

import java.util.List;
import java.util.UUID;
@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "users")
public class User extends BaseEntity{
    @Email
    private String email;
    private String password;
    private Integer age;
    private String firstName;
    private String lastName;
    @ManyToMany
    private List<Role> roles;
    public boolean hasRole(Role role) {
        return roles.stream().anyMatch(item -> ((Role) item).getRole().equals(role.getRole()));
    }
}
