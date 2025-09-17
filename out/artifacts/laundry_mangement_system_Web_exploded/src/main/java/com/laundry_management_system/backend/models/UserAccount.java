package com.laundry_management_system.backend.models;


import jakarta.persistence.*;
import jakarta.validation.constraints.NotBlank;
import com.laundry_management_system.backend.enums.Role;
import lombok.*;

import java.time.LocalDateTime;

@Entity @Table(name = "UserAccount")
@Getter @Setter @NoArgsConstructor @AllArgsConstructor @Builder
public class UserAccount {
    @Id @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Integer userId;

    @Column(length = 20, nullable = false, unique = true)
    @NotBlank
    private String username; // DB enforces prefix rule; optional extra guard:
    // @Pattern(regexp = "^[ACE].*")

    @Column(length = 255, nullable = false)
    private String passwordHash;

    @Enumerated(EnumType.STRING)
    @Column(length = 20, nullable = false)
    private Role role;

    @Column(nullable = false)
    private LocalDateTime createdAt = LocalDateTime.now();

    @Column(nullable = false)
    private boolean isActive = true;
}