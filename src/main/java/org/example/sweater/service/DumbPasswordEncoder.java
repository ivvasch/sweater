package org.example.sweater.service;

import org.springframework.security.crypto.password.PasswordEncoder;

public class DumbPasswordEncoder implements PasswordEncoder {
    @Override
    public String encode(CharSequence charSequence) {
        return String.format("Secret, '%s'", charSequence);
    }

    @Override
    public boolean matches(CharSequence charSequence, String s) {
        return false;
    }
}
