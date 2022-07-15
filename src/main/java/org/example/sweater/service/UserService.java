package org.example.sweater.service;

import lombok.AllArgsConstructor;
import org.example.sweater.domain.Role;
import org.example.sweater.domain.User;
import org.example.sweater.exception.LoginException;
import org.example.sweater.repo.UserRepo;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.*;
import java.util.stream.Collectors;

@AllArgsConstructor
@Service
public class UserService implements UserDetailsService {
    private static final String CONFIRM_EMAIL_SUBJECT = "Please confirm your email address";

    private final UserRepo userRepo;
    private final MailSenderService mailSenderService;
    private final PasswordEncoder passwordEncoder;

    @Override
    public UserDetails loadUserByUsername(String userName) throws UsernameNotFoundException {
        if (userName == null || userName.isEmpty()) {
            throw new LoginException("Please fill fields");
        }
        User userByUsername = userRepo.findUserByUsername(userName);
        if (userByUsername == null) {
            throw new LoginException("User not found");
        }
        return userByUsername;
    }

    public boolean addUser(User user) {
        User userFromDB = userRepo.findUserByUsername(user.getUsername());
        if (userFromDB != null) {
            return false;
        }
        user.setActive(true);
        user.setRoleSet(Collections.singleton(Role.USER));
        String confirmEmailCode = UUID.randomUUID().toString();
        user.setActivationCode(confirmEmailCode);
        user.setPassword(passwordEncoder.encode(user.getPassword()));

        userRepo.save(user);

        sendMessage(user, confirmEmailCode);
        return true;
    }

    private void sendMessage(User user, String confirmEmailCode) {
        if (!StringUtils.isEmpty(user.getEmail())) {
            String message = String.format("Hello, %s! \n" +
                    "Welcome to Sweater. Please, visit next link:" +
                    "http://localhost:8080/activate/%s", user.getUsername(), confirmEmailCode);
            mailSenderService.send(user.getEmail(), CONFIRM_EMAIL_SUBJECT, message);

        }
    }

    public boolean activateUser(String code) {
        User user = userRepo.findByActivationCode(code);
        if (user == null) {
            return false;
        }
        user.setActivationCode(null);
        userRepo.save(user);

        return true;
    }

    public List<User> findAll() {
        return userRepo.findAll();
    }

    public void saveUser(String userName, Map<String, String> form, User user) {
        user.setUsername(userName);
        Set<String> roles = Arrays.stream(Role.values()).map(Role::name).collect(Collectors.toSet());

        user.getRoleSet().clear();

        for (String key : form.keySet()) {
            if (roles.contains(key)) {
                user.getRoleSet().add(Role.valueOf(key));
            }
        }

        userRepo.save(user);
    }

    public void updateProfile(User user, String password, String email) {
        String currentEmail = user.getEmail();
        boolean isEmailChanged = (currentEmail != null && !currentEmail.equals(email) ||
                email != null && !email.equals(currentEmail));
        if (isEmailChanged){
            user.setEmail(email);
            if (!StringUtils.isEmpty(email)) {
                user.setActivationCode(UUID.randomUUID().toString());
            }
        }
        if (!StringUtils.isEmpty(password)) {
            user.setPassword(password);
        }
        userRepo.save(user);
        if (isEmailChanged) {
            sendMessage(user, user.getActivationCode());
        }
    }

    public void subscribe(User currentUser, User user) {
        user.getSubscribers().add(currentUser);
        userRepo.save(user);
    }

    public void unSubscribe(User currentUser, User user) {
        user.getSubscribers().remove(currentUser);
        userRepo.save(user);
    }
}
