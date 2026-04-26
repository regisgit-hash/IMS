package com.Airtel.InventoryManagementSystem.repository;

import com.Airtel.InventoryManagementSystem.model.Asset;
import org.springframework.data.jpa.repository.JpaRepository;
import java.util.List;

public interface AssetRepository extends JpaRepository<Asset, Long> {
    List<Asset> findByDeviceTypeContainingIgnoreCaseOrBrandContainingIgnoreCaseOrModelContainingIgnoreCase(String type, String brand, String model);
    List<Asset> findByTagNumberContainingIgnoreCase(String tagNumber);
}
