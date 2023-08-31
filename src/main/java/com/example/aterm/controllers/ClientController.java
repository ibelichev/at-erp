package com.example.aterm.controllers;

import com.example.aterm.models.Subscription;
import com.example.aterm.models.User;
import com.example.aterm.repositories.LessonRepository;
import com.example.aterm.repositories.StudentRepository;
import com.example.aterm.repositories.SubscriptionReposiory;
import com.example.aterm.servieces.*;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestParam;

import java.security.Principal;
import java.util.List;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAuthority('ROLE_CLIENT')")
public class ClientController {

    private final LessonService lessonService;
    private final PrepodService prepodService;
    private final StudentRepository studentRepository;
    private final SubscriptionReposiory subscriptionReposiory;
    private final UserService userService;
    private final LessonRepository lessonRepository;

    @GetMapping("/client/lessons")
    public String clientLessons(Principal principal, Model model, @RequestParam(name = "name", required = false) String prepodName) {
        User user = userService.getUserByPrincipal(principal);
        model.addAttribute("user", user);
        System.out.println("-------- user: " + user.toString());
        Long id = (studentRepository.findByName(user.getName())).get(0).getId();
        List<Subscription> sub = subscriptionReposiory.findByStudentId(id);
        model.addAttribute("subscription", sub.get(0));
        model.addAttribute("student", studentRepository.getById(id));
        model.addAttribute("prepods", prepodService.listPrepod(prepodName));
        model.addAttribute("lessons", lessonRepository.findBySubscriptionId(sub.get(0).getId()));
        return "client_lessons";
    }
}
