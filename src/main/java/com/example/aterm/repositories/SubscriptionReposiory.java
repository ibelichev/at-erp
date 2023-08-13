package com.example.aterm.repositories;

import com.example.aterm.models.Subscription;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface SubscriptionReposiory extends JpaRepository<Subscription, Long> {
    List<Subscription> findBySubscriptionName(String name);
    List<Subscription> findByStudentId(Long id);

}
