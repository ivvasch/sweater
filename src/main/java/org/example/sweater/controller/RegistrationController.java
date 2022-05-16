package org.example.sweater.controller;

import org.example.sweater.domain.User;
import org.example.sweater.domain.dto.CaptchaResponseDto;
import org.example.sweater.service.UserService;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.client.RestTemplate;

import javax.validation.Valid;
import java.util.Collections;
import java.util.Map;

@Controller
public class RegistrationController {
    private static final String CAPTCHA_URL = "https://www.google.com/recaptcha/api/siteverify?secret=%s&response=%s";

    @Value("${recaptcha.secret}")
    private String secret;

    private final UserService userService;
    private final RestTemplate restTemplate;

    public RegistrationController(UserService userService, RestTemplate restTemplate) {
        this.userService = userService;
        this.restTemplate = restTemplate;
    }

    @GetMapping("/registration")
    public String registration() {
        return "registration";
    }

    @PostMapping("/registration")
    public String addUser(@RequestParam("password2") String password2,
                          @RequestParam("g-recaptcha-response") String captcha,
                          @Valid User user,
                          BindingResult bindingResult,
                          Model model) {
        String url = String.format(CAPTCHA_URL, secret, captcha);

        CaptchaResponseDto captchaResponseDto =
                restTemplate.postForObject(url, Collections.emptyList(), CaptchaResponseDto.class);

        if (!captchaResponseDto.isSuccess()) {
            model.addAttribute("captchaError", "Fill captcha");
        }
        boolean password2Empty = password2.isEmpty();
        if (password2Empty) {
            model.addAttribute("password2Error", "Password2 couldn't be null");
        }

        if (user.getPassword() != null && !user.getPassword().equals(password2)) {
            model.addAttribute("passwordError", "Passwords are different!");
        }
        if (bindingResult.hasErrors() || password2Empty || !captchaResponseDto.isSuccess()) {
            Map<String, String> errors = ControllerUtil.getErrors(bindingResult);
            model.mergeAttributes(errors);

            return "registration";
        }
        if (!userService.addUser(user)) {
            model.addAttribute("usernameError", "User Exist");
            return "registration";
        }
        return "redirect:/login";
    }

    @GetMapping("/activate/{code}")
    public String activate(Model model, @PathVariable String code) {
        boolean isActivated = userService.activateUser(code);
        if (isActivated) {
            model.addAttribute("message", "User successfully activated!");
            model.addAttribute("messageType", "success");
        } else {
            model.addAttribute("message", "User unauthorized!");
            model.addAttribute("messageType", "danger");
        }
        return "login";
    }
}
