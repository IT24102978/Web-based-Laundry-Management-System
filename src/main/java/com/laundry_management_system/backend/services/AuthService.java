package com.laundry_management_system.backend.services;

import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.repositories.UserAccountRepository;
import org.springframework.stereotype.Service;

import java.util.Optional;

@Service
public class AuthService {
    private final UserAccountRepository repo;
    public AuthService(UserAccountRepository repo) { this.repo = repo; }

    public Optional<UserAccount> authenticate(String username, String rawPassword) {
        return repo.findByUsername(username)
                .filter(UserAccount::isActive)
                .filter(u -> rawPassword.equals(u.getPasswordHash())); // (replace with real hash check later)
    }
}
