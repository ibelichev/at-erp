package com.example.aterm.repositories;

import com.example.aterm.models.Agreement;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AgreementRepository extends JpaRepository<Agreement, Integer> {
    Agreement findBySubscriptionId(long subscriptionId);
}