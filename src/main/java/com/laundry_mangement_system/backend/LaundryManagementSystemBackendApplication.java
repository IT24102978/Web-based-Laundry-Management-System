package com.laundry_mangement_system.backend;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;
import org.springframework.context.annotation.ComponentScan;

@SpringBootApplication
public class LaundryManagementSystemBackendApplication extends SpringBootServletInitializer {
    public static void main(String[] args) {
        SpringApplication.run(LaundryManagementSystemBackendApplication.class, args);
    }

    @Override
    protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
        return builder.sources(LaundryManagementSystemBackendApplication.class);
    }
}
