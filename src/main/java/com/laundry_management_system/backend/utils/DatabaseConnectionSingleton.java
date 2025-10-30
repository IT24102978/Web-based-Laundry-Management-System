package com.laundry_management_system.backend.utils;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;

/**
 * This class ensures only ONE database connection instance exists
 * throughout the entire application.
 */
public class DatabaseConnectionSingleton {

    // 1️⃣ static instance (shared globally)
    private static DatabaseConnectionSingleton instance;

    // 2️⃣ single Connection object
    private Connection connection;

    // 3️⃣ private constructor (prevent direct instantiation)
    private DatabaseConnectionSingleton() {
        try {

            String url = "jdbc:sqlserver://localhost:1433;databaseName=LMS_DEV;encrypt=true;trustServerCertificate=true";
            String username = "LMS_MAIN";
            String password = "LMSPassword123#";

            connection = DriverManager.getConnection(url, username, password);
            System.out.println("✅ Database connection established successfully.");

        } catch (SQLException e) {
            e.printStackTrace();
            throw new RuntimeException("❌ Failed to connect to database: " + e.getMessage());
        }
    }

    // 4️⃣ public accessor method for global access
    public static synchronized DatabaseConnectionSingleton getInstance() {
        if (instance == null) {
            instance = new DatabaseConnectionSingleton();
        }
        return instance;
    }

    // 5️⃣ getter for Connection object
    public Connection getConnection() {
        return connection;
    }
}
