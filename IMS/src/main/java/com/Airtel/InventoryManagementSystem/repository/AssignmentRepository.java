package com.Airtel.InventoryManagementSystem.repository;

import com.Airtel.InventoryManagementSystem.model.Assignment;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AssignmentRepository extends JpaRepository<Assignment, Long> {
    List<Assignment> findByAssetId(Long assetId);
}
