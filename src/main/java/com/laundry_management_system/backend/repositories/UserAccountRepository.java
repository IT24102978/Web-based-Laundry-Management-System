package com.laundry_management_system.backend.repositories;

import com.laundry_management_system.backend.models.UserAccount;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;

import java.util.List;
import java.util.Optional;

public interface UserAccountRepository extends JpaRepository<UserAccount, Integer> {

    Optional<UserAccount> findByUsername(String username);

    boolean existsByUsernameIgnoreCase(String username);

    /** Newest account whose username starts with the given prefix (e.g., "C") */
    UserAccount findTop1ByUsernameStartingWithOrderByUserIdDesc(String prefix);

    /** Fetch all usernames for customers (role = 'CUSTOMER') */
    @Query("SELECT u.username FROM UserAccount u WHERE u.role = 'CUSTOMER' ORDER BY u.username ASC")
    List<String> findAllCustomerUsernames();

    /** Find the highest numeric part of customer usernames (e.g., 001, 002) */
    @Query(value = """
        SELECT MAX(CAST(SUBSTRING(u.username, 2, LENGTH(u.username) - 1) AS INTEGER))
        FROM UserAccount u
        WHERE u.username LIKE 'C%'
    """, nativeQuery = true)
    Integer findMaxCustomerNumber();
}