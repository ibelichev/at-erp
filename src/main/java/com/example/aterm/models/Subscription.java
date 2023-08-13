package com.example.aterm.models;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import javax.persistence.*;

@Entity
@Table(name = "subscriptions")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Subscription {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private long id;

    @Column(name = "studentId")
    private Long studentId;

    @Column(name = "studentName")
    private String studentName;

    @Column(name = "subscriptionName")
    private String subscriptionName;

    @Column(name = "amountOfLessons")
    private int amountOfLessons;

    @Column(name = "nowLesson")
    private int nowLesson;

    @Column(name = "toPay")
    private int toPay;

    @Column(name = "money")
    private int money;
}
