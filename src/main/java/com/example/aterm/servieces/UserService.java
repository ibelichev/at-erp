package com.example.aterm.servieces;

import com.example.aterm.models.User;
import com.example.aterm.models.enums.Role;
import com.example.aterm.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Principal;


@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;

    public boolean createUser (User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
//        user.getRoles().add(Role.ROLE_ADMIN);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        log.info("Saving new User with email: {}", email);
        userRepository.save(user);
        return true;
    }


    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public void setUerRole(User user, Role role) {

    }
}
