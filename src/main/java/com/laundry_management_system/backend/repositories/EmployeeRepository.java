package com.laundry_management_system.backend.repositories;

import com.laundry_management_system.backend.models.Employee;
import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface EmployeeRepository extends JpaRepository<Employee, Integer> {
    Employee findTopByOrderByEmployeeIdDesc();

}


