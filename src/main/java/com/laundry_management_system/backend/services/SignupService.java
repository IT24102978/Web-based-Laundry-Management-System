package com.laundry_management_system.backend.services;

import com.laundry_management_system.backend.dto.SignupForm;
import com.laundry_management_system.backend.enums.Role;
import com.laundry_management_system.backend.models.Customer;
import com.laundry_management_system.backend.models.UserAccount;
import com.laundry_management_system.backend.repositories.CustomerRepository;
import com.laundry_management_system.backend.repositories.UserAccountRepository;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

@Service
public class SignupService {

    private final UserAccountRepository users;
    private final CustomerRepository customers;

    public SignupService(UserAccountRepository users, CustomerRepository customers) {
        this.users = users;
        this.customers = customers;
    }

    private String prefixFor(Role role) {
        return switch (role) {
            case ADMIN -> "A";
            case EMPLOYEE -> "E";
            case CUSTOMER -> "C";
        };
    }

    /** NEW: convenience method for controller/JSP */
    public String nextCustomerUsername() {
        return nextUsername(Role.CUSTOMER);
    }

    /** Generate next username like C001, C002 ... */
    public String nextUsername(Role role) {
        String prefix = prefixFor(role);
        UserAccount last = users.findTop1ByUsernameStartingWithOrderByUserIdDesc(prefix);
        int nextNum = 1;

        if (last != null) {
            String lastU = last.getUsername();        // e.g. "C012"
            if (lastU != null && lastU.length() > 1) {
                try {
                    nextNum = Integer.parseInt(lastU.substring(1)) + 1;
                } catch (NumberFormatException ignored) { /* keep 1 */ }
            }
        }
        return String.format("%s%03d", prefix, nextNum);
    }

    @Transactional
    public UserAccount signup(SignupForm form) {
        // customer-only
        Role role = Role.CUSTOMER;

        // generate username
        String username = nextUsername(role);
        if (users.existsByUsernameIgnoreCase(username)) {
            username = nextUsername(role);
        }

        UserAccount ua = new UserAccount();
        ua.setUsername(username);
        ua.setPasswordHash(form.getPassword()); // plain text per your requirement
        ua.setRole(role.name());                // DB column is VARCHAR
        ua.setActive(true);

        users.save(ua);

        Customer c = new Customer();
        c.setUserAccount(ua);
        c.setFirstName(form.getFirstName());
        c.setLastName(form.getLastName());
        c.setEmail(form.getEmail());
        c.setContactNo(form.getContactNo());
        c.setStreet(form.getStreet());
        c.setCity(form.getCity());
        c.setPostalCode(form.getPostalCode());

        customers.save(c);

        return ua;
    }
}