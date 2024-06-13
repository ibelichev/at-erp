package com.example.aterm.models;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;
import lombok.RequiredArgsConstructor;

import javax.persistence.*;
import java.time.LocalDate;
import java.util.Date;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Entity
@Table(name = "agreements", schema = "entities")
public class Agreement {
    @Id
    @GeneratedValue(strategy = GenerationType.SEQUENCE, generator = "agreement_seq")
    @SequenceGenerator(name = "agreement_seq", sequenceName = "agreement_seq", allocationSize = 1)
    private long id;

    private LocalDate date;

    @OneToOne
    @JoinColumn(name = "subscription_id")
    private Subscription subscription;

    private boolean isActive;

    public Agreement(LocalDate date, Subscription subscription, boolean isActive) {
        this.date = date;
        this.subscription = subscription;
        this.isActive = isActive;
    }
}