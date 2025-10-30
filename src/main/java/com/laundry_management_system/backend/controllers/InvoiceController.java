package com.laundry_management_system.backend.billing.controller;

import com.laundry_management_system.backend.billing.model.Invoice;
import com.laundry_management_system.backend.billing.service.InvoiceService;
import com.laundry_management_system.backend.billing.service.ServiceException;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

/**
 * REST controller for invoice operations
 */
@RestController
@RequestMapping("/billing/invoices")
public class InvoiceController {

    private final InvoiceService invoiceService;

    public InvoiceController(InvoiceService invoiceService) {
        this.invoiceService = invoiceService;
    }

    /**
     * Generate invoice for an order
     * @param orderId Order ID
     * @return generated invoice
     */
    @GetMapping("/generate/{orderId}")
    public ResponseEntity<Invoice> generateInvoice(@PathVariable int orderId) {
        try {
            Invoice invoice = invoiceService.generateInvoice(orderId);
            return ResponseEntity.ok(invoice);
        } catch (ServiceException e) {
            return ResponseEntity.badRequest().build();
        }
    }

    /**
     * Send invoice reminder for an order
     * @param orderId Order ID
     * @return success message
     */
    @PostMapping("/send-reminder/{orderId}")
    public ResponseEntity<String> sendInvoiceReminder(@PathVariable int orderId) {
        try {
            String message = invoiceService.sendInvoiceReminder(orderId);
            return ResponseEntity.ok(message);
        } catch (ServiceException e) {
            return ResponseEntity.badRequest().body("Failed to send reminder: " + e.getMessage());
        }
    }
}