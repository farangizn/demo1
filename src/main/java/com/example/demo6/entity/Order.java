package com.example.demo6.entity;

import jakarta.persistence.*;
import lombok.*;
import java.sql.Timestamp;

@EqualsAndHashCode(callSuper = true)
@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
@Entity
@Table(name = "orders")
public class Order extends BaseEntity {
    private Timestamp dateTime;
    @ManyToOne
    private Status status;
    @ManyToOne
    private User user;
}
