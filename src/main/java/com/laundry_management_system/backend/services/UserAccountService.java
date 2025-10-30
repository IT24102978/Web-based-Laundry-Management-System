package com.laundry_management_system.backend.services;

import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.repositories.UserAccountRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class UserAccountService {

    private final UserAccountRepository repo;

    public UserAccountService(UserAccountRepository repo) {
        this.repo = repo;
    }

    /**
     * ✅ Get all user accounts
     */
    public List<UserAccount> getAllUsers() {
        return repo.findAll();
    }

    /**
     * ✅ Generate next username like E001, E002, etc.
     */
    public String getNextUsername() {
        List<UserAccount> users = repo.findAll();
        int max = 0;

        for (UserAccount u : users) {
            String username = u.getUsername();
            if (username != null && username.startsWith("E")) {
                try {
                    int num = Integer.parseInt(username.substring(1));
                    if (num > max) max = num;
                } catch (NumberFormatException ignored) {}
            }
        }

        return String.format("E%03d", max + 1);
    }

    /**
     * ✅ Save or update a user account
     */
    public UserAccount saveUser(UserAccount user) {
        return repo.save(user);
    }

    /**
     * ✅ Create a new user with given username, password, and role
     */
    public UserAccount createUser(String username, String password, String role) {
        UserAccount user = new UserAccount();
        user.setUsername(username);
        user.setPasswordHash(password); // plain text for demo
        user.setRole(role);
        user.setActive(true);
        user.setCreatedAt(java.time.LocalDateTime.now());
        return repo.save(user);
    }
}
