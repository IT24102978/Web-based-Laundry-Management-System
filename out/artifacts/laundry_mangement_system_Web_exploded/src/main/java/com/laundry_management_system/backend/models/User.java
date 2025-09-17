package com.laundry_management_system.backend.models;

public class User {
    public String userName;
    public String friendlyName;

    public User(String userName, String friendlyName) {
        this.userName = userName;
        this.friendlyName = friendlyName;
    }
}
