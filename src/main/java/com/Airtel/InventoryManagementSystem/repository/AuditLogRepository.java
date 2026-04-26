package com.Airtel.InventoryManagementSystem.repository;

import com.Airtel.InventoryManagementSystem.model.AuditLog;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AuditLogRepository extends JpaRepository<AuditLog, Long> {
    List<AuditLog> findByAssetIdOrderByActionDateDesc(Long assetId);
}
