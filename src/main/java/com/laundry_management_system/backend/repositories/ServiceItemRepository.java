package com.laundry_management_system.backend.repositories;

import com.laundry_management_system.backend.models.ServiceItem;
import org.springframework.data.jpa.repository.JpaRepository;


public interface ServiceItemRepository extends JpaRepository<ServiceItem, Integer> {

}
