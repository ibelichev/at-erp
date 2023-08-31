package com.example.aterm.repositories;

import com.example.aterm.models.Lesson;
import com.example.aterm.models.Subscription;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LessonRepository extends JpaRepository<Lesson, Integer> {
    List<Lesson> findBySubscription(Subscription subscription);

    List<Lesson> findLessonsBySubscriptionId(Long subscriptionId);

}
