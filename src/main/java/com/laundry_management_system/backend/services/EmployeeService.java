package com.laundry_management_system.backend.services;

import com.laundry_management_system.backend.models.Employee;
import com.laundry_management_system.backend.repositories.EmployeeRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class EmployeeService {

    private final EmployeeRepository repo;

    public EmployeeService(EmployeeRepository repo) {
        this.repo = repo;
    }

    public List<Employee> getAllEmployees() {
        return repo.findAll();
    }

    public Employee getEmployeeById(int id) {
        return repo.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Employee not found"));
    }

    public void saveEmployee(Employee employee) {
        repo.save(employee);
    }

    public void deleteEmployee(int id) {
        repo.deleteById(id);
    }
}
