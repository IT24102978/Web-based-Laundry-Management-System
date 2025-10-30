package com.laundry_management_system.backend.billing.controller;

import com.laundry_management_system.backend.billing.model.Invoice;
import com.laundry_management_system.backend.billing.service.InvoiceService;
import com.laundry_management_system.backend.billing.service.ServiceException;
import com.laundry_management_system.backend.billing.util.BillingHelper;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class BillingController {

    private final InvoiceService invoiceService;

    public BillingController() {
        this.invoiceService = new InvoiceService();
    }

    @GetMapping("/billing-management")
    public String billingManagement() {
        return "billing-management";
    }

    @PostMapping("/billing-management")
    public String createOrder(
            @RequestParam("action") String action,
            @RequestParam(value = "customerId", required = false) Integer customerId,
            @RequestParam(value = "orderDate", required = false) String orderDate,
            @RequestParam(value = "pickupDate", required = false) String pickupDate,
            @RequestParam(value = "deliveryDate", required = false) String deliveryDate,
            @RequestParam(value = "instructions", required = false) String instructions,
            @RequestParam(value = "discount", defaultValue = "0") double discount,
            @RequestParam(value = "total", defaultValue = "0") double total,
            @RequestParam(value = "orderItems", required = false) String orderItems,
            Model model) {

        try {
            if ("create".equals(action) && customerId != null) {
                String message = BillingHelper.createOrder(customerId, orderDate, pickupDate, deliveryDate, instructions, discount, total, orderItems);
                model.addAttribute("success", message);
            } else if ("delete".equals(action)) {
                // Handle delete action if needed
            }
        } catch (Exception e) {
            model.addAttribute("error", "Error: " + e.getMessage());
        }

        return "billing-management";
    }

    @GetMapping("/generate-invoice")
    public String generateInvoice(@RequestParam("orderId") int orderId, Model model) {
        try {
            Invoice invoice = invoiceService.generateInvoice(orderId);
            model.addAttribute("invoice", invoice);
            return "invoice-view";
        } catch (ServiceException e) {
            model.addAttribute("error", "Error generating invoice: " + e.getMessage());
            return "billing-management";
        }
    }
}