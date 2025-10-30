package com.laundry_management_system.backend.services;

import com.laundry_management_system.backend.models.ServiceItem;
import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.repositories.ServiceItemRepository;
import com.laundry_management_system.backend.repositories.UserAccountRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class AdminService {

    private final UserAccountRepository users;
    private final ServiceItemRepository services;

    public AdminService(UserAccountRepository users, ServiceItemRepository services) {
        this.users = users;
        this.services = services;
    }

    // --- UserAccount CRUD ---
    public List<UserAccount> allUsers() { return users.findAll(); }
    public UserAccount saveUser(UserAccount u) { return users.save(u); }
    public void deleteUser(Integer id) { users.deleteById(id); }

    // --- ServiceItem CRUD ---
    public List<ServiceItem> allServices() { return services.findAll(); }
    public ServiceItem saveService(ServiceItem s) { return services.save(s); }
    public void deleteService(Integer id) { services.deleteById(id); }


    public UserAccount findUserById(Integer id) {
        return users.findById(id).orElseThrow();
    }

    public void updateUser(Integer id, UserAccount updated) {
        UserAccount existing = findUserById(id);
        existing.setUsername(updated.getUsername());
        existing.setPasswordHash(updated.getPasswordHash());
        existing.setRole(updated.getRole());
        users.save(existing);
    }

    public ServiceItem findServiceById(Integer id) {
        return services.findById(id).orElseThrow();
    }

    public void updateService(Integer id, ServiceItem updated) {
        ServiceItem existing = findServiceById(id);
        existing.setServiceName(updated.getServiceName());
        existing.setDescription(updated.getDescription());
        existing.setUnitPrice(updated.getUnitPrice());
        services.save(existing);
    }


}

