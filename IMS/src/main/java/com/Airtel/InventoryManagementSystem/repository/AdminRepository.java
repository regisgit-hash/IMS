package com.Airtel.InventoryManagementSystem.repository;

import com.Airtel.InventoryManagementSystem.model.Admin;
import org.springframework.data.jpa.repository.JpaRepository;

public interface AdminRepository extends JpaRepository<Admin, Long> {
    Admin findByUsername(String username);
}
