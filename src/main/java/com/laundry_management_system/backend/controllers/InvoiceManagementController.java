package com.laundry_management_system.backend.billing.controller;

import com.laundry_management_system.backend.billing.model.Invoice;
import com.laundry_management_system.backend.billing.service.InvoiceService;
import com.laundry_management_system.backend.billing.service.ServiceException;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class InvoiceManagementController {

    private final InvoiceService invoiceService;

    public InvoiceManagementController() {
        this.invoiceService = new InvoiceService();
    }

    /**
     * Show invoice management page
     */
    @GetMapping("/invoice-management")
    public String invoiceManagement(Model model) {
        return "invoice-management";
    }

    /**
     * Generate invoice for an order
     */
    @PostMapping("/generate-invoice")
    public String generateInvoice(@RequestParam("orderId") int orderId, Model model) {
        try {
            Invoice invoice = invoiceService.generateInvoice(orderId);
            model.addAttribute("invoice", invoice);
            return "invoice-view";
        } catch (ServiceException e) {
            model.addAttribute("message", "Error generating invoice: " + e.getMessage());
            model.addAttribute("messageType", "danger");
            return "invoice-management";
        }
    }

    /**
     * Update invoice status
     */
    @PostMapping("/update-invoice")
    public String updateInvoice(
            @RequestParam("invoiceId") int invoiceId,
            @RequestParam("status") String status,
            @RequestParam(value = "notes", required = false) String notes,
            Model model) {
        try {
            // In a real implementation, you would update the invoice in the database
            // For now, we'll just add a success message
            model.addAttribute("message", "Invoice updated successfully!");
            model.addAttribute("messageType", "success");
        } catch (Exception e) {
            model.addAttribute("message", "Error updating invoice: " + e.getMessage());
            model.addAttribute("messageType", "danger");
        }
        return "redirect:/invoice-management";
    }

    /**
     * Delete invoice
     */
    @PostMapping("/delete-invoice")
    public String deleteInvoice(@RequestParam("invoiceId") int invoiceId, Model model) {
        try {
            // In a real implementation, you would delete the invoice from the database
            // For now, we'll just add a success message
            model.addAttribute("message", "Invoice deleted successfully!");
            model.addAttribute("messageType", "success");
        } catch (Exception e) {
            model.addAttribute("message", "Error deleting invoice: " + e.getMessage());
            model.addAttribute("messageType", "danger");
        }
        return "redirect:/invoice-management";
    }

    /**
     * Send invoice reminder for an order
     */
    @PostMapping("/send-invoice-reminder")
    public String sendInvoiceReminder(@RequestParam("orderId") int orderId, Model model) {
        try {
            String message = invoiceService.sendInvoiceReminder(orderId);
            model.addAttribute("message", message);
            model.addAttribute("messageType", "success");
        } catch (ServiceException e) {
            model.addAttribute("message", "Error sending reminder: " + e.getMessage());
            model.addAttribute("messageType", "danger");
        }
        return "redirect:/invoice-management";
    }
}