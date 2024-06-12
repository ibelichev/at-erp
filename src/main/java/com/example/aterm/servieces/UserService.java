package com.example.aterm.servieces;

import com.example.aterm.models.EmailConfirmation;
import com.example.aterm.models.User;
import com.example.aterm.models.enums.Role;
import com.example.aterm.repositories.EmailConfirmationRepository;
import com.example.aterm.repositories.UserRepository;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.security.Principal;
import java.time.LocalDateTime;
import java.util.Optional;
import java.util.UUID;


@Service
@Slf4j
@RequiredArgsConstructor
public class UserService {
    private final UserRepository userRepository;
    private final PasswordEncoder passwordEncoder;
    private final EmailService emailService;

    public boolean createUser (User user) {
        String email = user.getEmail();
        if (userRepository.findByEmail(email) != null) return false;
//        user.getRoles().add(Role.ROLE_ADMIN);
        user.setPassword(passwordEncoder.encode(user.getPassword()));
        user.setActive(false);
        user.setActivationCode(UUID.randomUUID().toString());
        log.info("Saving new User with email: {}", email);
        userRepository.save(user);
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format(
                    "Hello, %s! \n" +
                            "Welcome to AT-ERP. Please, visit next link to confirm your email: http://localhost:9090/activate/%s",
                    user.getName(),
                    user.getActivationCode()
            );

            emailService.sendSimpleMessage(user.getEmail(), "Activation code", message);
            return true;
        }
        return true;
    }


    public User getUserByPrincipal(Principal principal) {
        if (principal == null) return new User();
        return userRepository.findByEmail(principal.getName());
    }

    public boolean activateUser(String activationCode) {
        User user = userRepository.findByActivationCode(activationCode);
        if (user == null) {
            return false;
        }
        user.setActivationCode(null);
        user.setActive(true);
        userRepository.save(user);
        return true;
    }

    public void setUerRole(User user, Role role) {

    }

}