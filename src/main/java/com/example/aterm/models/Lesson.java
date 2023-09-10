package com.example.aterm.models;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;
import org.hibernate.annotations.Subselect;

import javax.persistence.*;

@Entity
@Table(name = "lessons")
@Data
@AllArgsConstructor
@NoArgsConstructor
public class Lesson {
    @Id
    @GeneratedValue(strategy = GenerationType.AUTO)
    private int id;

    @ManyToOne
    @JoinColumn(name = "subscription_id")
    private Subscription subscription;

    @Column(name="numbOfLesson")
    private int numbOfLesson;

    @Column(name = "date")
    private String date;

    @Column(name="time")
    private String time;

    @Column(name="prepod")
    private String prepod;

    @Column(name = "status")
    private String status = "Не проведен";

}
