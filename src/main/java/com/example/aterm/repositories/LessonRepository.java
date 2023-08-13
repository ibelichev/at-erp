package com.example.aterm.repositories;

import com.example.aterm.models.Lesson;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface LessonRepository extends JpaRepository<Lesson, Integer> {
    List<Lesson> findBySubscriptionId(Long subscriptionId);
}
