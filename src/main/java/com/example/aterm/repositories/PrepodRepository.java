package com.example.aterm.repositories;

import com.example.aterm.models.Prepod;
import org.springframework.data.jpa.repository.JpaRepository;

import java.util.List;

public interface PrepodRepository extends JpaRepository<Prepod, Integer> {
    List<Prepod> findByName(String name);
}
