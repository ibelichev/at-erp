package com.example.aterm.models;


import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import java.util.*;

import javax.persistence.*;

@Entity
@Table(name = "subscriptions", schema = "entities")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Subscription {
    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private long id;

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

    @ManyToOne
    @JoinColumn(name = "student_id")
    private Student student;

    @OneToMany(mappedBy = "subscription", cascade = CascadeType.ALL)
    private List<Lesson> lessons = new ArrayList<>();
}