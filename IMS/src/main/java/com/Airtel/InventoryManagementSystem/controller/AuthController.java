package com.Airtel.InventoryManagementSystem.controller;

import com.Airtel.InventoryManagementSystem.model.Admin;
import com.Airtel.InventoryManagementSystem.repository.AdminRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpSession;

@Controller
public class AuthController {

    @Autowired
    private AdminRepository adminRepository;

    @GetMapping("/login")
    public String showLoginForm() {
        return "login";
    }

    @PostMapping("/login")
    public String login(@RequestParam String username, @RequestParam String password, HttpSession session, Model model) {
        Admin admin = adminRepository.findByUsername(username);
        
        // If no admin exists yet, create a default one
        if (adminRepository.count() == 0) {
            Admin newAdmin = new Admin();
            newAdmin.setUsername("admin");
            newAdmin.setPassword("password");
            newAdmin.setFullName("System Administrator");
            adminRepository.save(newAdmin);
            admin = newAdmin;
        }

        if (admin != null && admin.getPassword().equals(password)) {
            session.setAttribute("adminId", admin.getId());
            session.setAttribute("adminName", admin.getFullName());
            return "redirect:/";
        }
        model.addAttribute("error", "Invalid username or password");
        return "login";
    }

    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/login";
    }
}
