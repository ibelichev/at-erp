package com.example.aterm.controllers;

import com.example.aterm.models.*;
import com.example.aterm.repositories.StudentRepository;
import com.example.aterm.repositories.SubscriptionReposiory;
import com.example.aterm.servieces.LessonService;
import com.example.aterm.servieces.PrepodService;
import com.example.aterm.servieces.StudentService;
import com.example.aterm.servieces.SubscriptionService;
import lombok.RequiredArgsConstructor;
import org.springframework.security.access.prepost.PreAuthorize;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;

import javax.servlet.http.HttpServletRequest;
import java.util.*;

@Controller
@RequiredArgsConstructor
@PreAuthorize("hasAnyAuthority('ROLE_ADMIN', 'ROLE_CLIENT')")
public class MainController {
    private User currentUser; // Поле для хранения текущего пользователя

    // Метод, который будет вызван при аутентификации пользователя
    @ModelAttribute
    public void setCurrentUser(Authentication authentication) {
        if (authentication != null && authentication.getPrincipal() instanceof User) {
            currentUser = (User) authentication.getPrincipal();
        }
    }

    @GetMapping("/")
    public String main(Model model) {
        String role = currentUser.getRoles().toString();
        System.out.println(role);
        model.addAttribute("currentUser", currentUser);
        model.addAttribute("role", role);
        return "main";
    }
}

