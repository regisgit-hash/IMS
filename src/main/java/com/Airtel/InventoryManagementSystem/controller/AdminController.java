package com.Airtel.InventoryManagementSystem.controller;

import com.Airtel.InventoryManagementSystem.model.*;
import com.Airtel.InventoryManagementSystem.repository.*;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import javax.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.util.List;

@Controller
public class AdminController {

    @Autowired private AssetRepository assetRepository;
    @Autowired private AssignmentRepository assignmentRepository;
    @Autowired private AuditLogRepository auditLogRepository;

    private void logAudit(Asset asset, String action, String details, HttpSession session) {
        AuditLog log = new AuditLog();
        log.setAsset(asset);
        log.setAction(action);
        log.setDetails(details);
        log.setActionDate(LocalDateTime.now());
        log.setPerformedBy((String) session.getAttribute("adminName"));
        auditLogRepository.save(log);
    }

    @GetMapping("/")
    public String dashboard(Model model) {
        model.addAttribute("totalAssets", assetRepository.count());
        model.addAttribute("totalAssignments", assignmentRepository.count());
        return "dashboard";
    }

    @GetMapping("/assets")
    public String viewAssets(@RequestParam(required = false) String search, Model model) {
        List<Asset> assets;
        if (search != null && !search.isEmpty()) {
            assets = assetRepository.findByTagNumberContainingIgnoreCase(search);
            if(assets.isEmpty()) {
                assets = assetRepository.findByDeviceTypeContainingIgnoreCaseOrBrandContainingIgnoreCaseOrModelContainingIgnoreCase(search, search, search);
            }
        } else {
            assets = assetRepository.findAll();
        }
        model.addAttribute("assets", assets);
        model.addAttribute("search", search);
        return "assets";
    }

    @GetMapping("/assets/add")
    public String showAddAssetForm(Model model) {
        model.addAttribute("asset", new Asset());
        return "asset-form";
    }

    @PostMapping("/assets/save")
    public String saveAsset(@ModelAttribute Asset asset, RedirectAttributes ra, HttpSession session) {
        boolean isNew = (asset.getId() == null);
        assetRepository.save(asset);
        logAudit(asset, isNew ? "Registered" : "Updated", "Asset details " + (isNew ? "added" : "updated"), session);
        ra.addFlashAttribute("message", "Asset saved successfully!");
        return "redirect:/assets";
    }

    @GetMapping("/assets/edit/{id}")
    public String editAsset(@PathVariable Long id, Model model) {
        Asset asset = assetRepository.findById(id).orElseThrow();
        model.addAttribute("asset", asset);
        return "asset-form";
    }

    @GetMapping("/assignments")
    public String viewAssignments(Model model) {
        model.addAttribute("assignments", assignmentRepository.findAll());
        return "assignments";
    }

    @GetMapping("/assignments/issue/{assetId}")
    public String showIssueForm(@PathVariable Long assetId, Model model) {
        Asset asset = assetRepository.findById(assetId).orElseThrow();
        Assignment assignment = new Assignment();
        assignment.setAsset(asset);
        model.addAttribute("assignment", assignment);
        return "issue-form";
    }

    @PostMapping("/assignments/save")
    public String saveAssignment(@ModelAttribute Assignment assignment,
                                 RedirectAttributes ra,
                                 HttpSession session) {

        // 🔥 FIX: get full asset from DB
        Long assetId = assignment.getAsset().getId();
        Asset asset = assetRepository.findById(assetId).orElseThrow();

        // attach full asset
        assignment.setAsset(asset);

        assignment.setAssignedDate(LocalDate.now());
        assignment.setStatus("Active");

        assignmentRepository.save(assignment);

        // update asset
        asset.setStatus("Assigned");
        assetRepository.save(asset);

        logAudit(asset, "Assigned",
            "Assigned to " + assignment.getEmployeeName() +
            " (" + assignment.getDepartment() + ")", session);

        ra.addFlashAttribute("message", "Asset assigned successfully!");
        return "redirect:/assignments";
    }
    @GetMapping("/assignments/return/{id}")
    public String returnAsset(@PathVariable Long id, RedirectAttributes ra, HttpSession session) {
        Assignment assignment = assignmentRepository.findById(id).orElseThrow();
        assignment.setReturnDate(LocalDate.now());
        assignment.setStatus("Returned");
        assignmentRepository.save(assignment);
        
        Asset asset = assignment.getAsset();
        asset.setStatus("Available");
        assetRepository.save(asset);
        
        logAudit(asset, "Returned", "Returned by " + assignment.getEmployeeName(), session);
        ra.addFlashAttribute("message", "Asset returned successfully!");
        return "redirect:/assignments";
    }
    @GetMapping("/assignments/delete/{id}")
    public String deleteAssignment(@PathVariable Long id,
                                  RedirectAttributes ra,
                                  HttpSession session) {

        Assignment assignment = assignmentRepository.findById(id).orElseThrow();
        Asset asset = assignment.getAsset();

        // 🔥 Important: reset asset status
        asset.setStatus("Available");
        assetRepository.save(asset);

        // delete assignment
        assignmentRepository.delete(assignment);

        // audit log
        logAudit(asset, "Deleted Assignment",
                "Deleted assignment for " + assignment.getEmployeeName(), session);

        ra.addFlashAttribute("message", "Assignment deleted successfully!");
        return "redirect:/assignments";
    }
    @GetMapping("/reports")
    public String viewReports(Model model) {
        model.addAttribute("auditLogs", auditLogRepository.findAll());
        return "reports";
    }
}
