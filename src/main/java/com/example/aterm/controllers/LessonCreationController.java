package com.example.aterm.controllers;

import com.example.aterm.models.*;
import com.example.aterm.repositories.SubscriptionReposiory;
import com.example.aterm.servieces.LessonService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;

@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('ROLE_ADMIN', 'ROLE_CLIENT')")
@Controller
public class LessonCreationController {

    private final LessonService lessonService;
    private final SubscriptionReposiory subscriptionReposiory;
    @PostMapping("/lesson/create")
    public String lessonsCreate(@ModelAttribute Lesson lesson, Authentication authentication) {
//        lesson.setSubscription(subscriptionReposiory.getById(id));
        lessonService.saveLesson(lesson);
        if (authentication.getAuthorities().stream().anyMatch(a -> a.getAuthority().equals("ROLE_ADMIN"))) {
            // Если пользователь имеет роль ROLE_ADMIN, выполните редирект на страницу "subscription"
            return "redirect:/subscription/" + lesson.getSubscription().getId(); // Передаем ID созданного урока
        } else {
            // В противном случае, выполните редирект на страницу "/client/lessons"
            return "redirect:/client/lessons";
        }
    }
}
