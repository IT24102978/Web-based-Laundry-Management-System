package com.laundry_management_system.backend.services;

import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.repositories.UserAccountRepository;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {
    private final UserAccountRepository users;
    private final PasswordEncoder encoder;

    public AuthService(UserAccountRepository users, PasswordEncoder encoder) {
        this.users = users;
        this.encoder = encoder;
    }

    public Optional<UserAccount> authenticate(String username, String rawPassword) {
        return users.findByUsername(username)
                .filter(u -> u.isActive() && encoder.matches(rawPassword, u.getPasswordHash()));
    }
}