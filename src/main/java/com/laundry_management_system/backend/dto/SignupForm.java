package com.laundry_management_system.backend.dto;

public class SignupForm {
    // login
    private String password;

    // customer profile
    private String firstName;
    private String lastName;
    private String email;
    private String contactNo;
    private String street;
    private String city;
    private String postalCode;

    // suggested username (readonly in JSP)
    private String username;

    // --- getters/setters ---
    public String getPassword() { return password; }
    public void setPassword(String password) { this.password = password; }

    public String getFirstName() { return firstName; }
    public void setFirstName(String firstName) { this.firstName = firstName; }

    public String getLastName() { return lastName; }
    public void setLastName(String lastName) { this.lastName = lastName; }

    public String getEmail() { return email; }
    public void setEmail(String email) { this.email = email; }

    public String getContactNo() { return contactNo; }
    public void setContactNo(String contactNo) { this.contactNo = contactNo; }

    public String getStreet() { return street; }
    public void setStreet(String street) { this.street = street; }

    public String getCity() { return city; }
    public void setCity(String city) { this.city = city; }

    public String getPostalCode() { return postalCode; }
    public void setPostalCode(String postalCode) { this.postalCode = postalCode; }

    public String getUsername() { return username; }
    public void setUsername(String username) { this.username = username; }
}
