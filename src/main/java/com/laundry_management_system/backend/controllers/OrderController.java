package com.laundry_management_system.backend.controllers;

import com.laundry_management_system.backend.models.OrderEntity;
import com.laundry_management_system.backend.repositories.OrderRepository;
import jakarta.transaction.Transactional;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
@RequestMapping("/orders")
public class OrderController {

    private final OrderRepository orders;

    public OrderController(OrderRepository orders) {
        this.orders = orders;
    }

    /** LIST + inline create form lives in order.jsp */
    @GetMapping
    public String list(Model model) {
        model.addAttribute("orders", orders.findAll());
        model.addAttribute("newOrder", new OrderEntity()); // for inline create form
        return "order"; // ✅ matches /WEB-INF/jsp/order.jsp
    }

    /** CREATE (inline form post from /order.jsp page) */
    @PostMapping
    @Transactional
    public String create(@ModelAttribute("newOrder") OrderEntity newOrder,
                         RedirectAttributes ra) {
        orders.save(newOrder);
        ra.addFlashAttribute("msg", "Order #" + newOrder.getOrderId() + " created.");
        return "redirect:/orders";
    }

    /** VIEW single */
    @GetMapping("/{id}")
    public String view(@PathVariable int id, Model model) {
        OrderEntity order = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));
        model.addAttribute("order", order);
        return "view_order"; // ✅ matches /WEB-INF/jsp/view_order.jsp
    }

    /** EDIT form page (reuses order_form.jsp) */
    @GetMapping("/{id}/edit")
    public String edit(@PathVariable int id, Model model) {
        OrderEntity order = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));
        model.addAttribute("order", order);
        model.addAttribute("mode", "edit");
        return "order_form"; // ✅ matches /WEB-INF/jsp/order_form.jsp
    }

    /** UPDATE */
    @PostMapping("/{id}")
    @Transactional
    public String update(@PathVariable int id,
                         @ModelAttribute("order") OrderEntity fromForm,
                         RedirectAttributes ra) {
        OrderEntity existing = orders.findById(id)
                .orElseThrow(() -> new IllegalArgumentException("Order not found: " + id));

        existing.setCustomerId(fromForm.getCustomerId());
        existing.setStatus(fromForm.getStatus());
        existing.setOrderDate(fromForm.getOrderDate());
        existing.setPickupDate(fromForm.getPickupDate());
        existing.setDeliveryDate(fromForm.getDeliveryDate());
        existing.setInstructions(fromForm.getInstructions());

        orders.save(existing);
        ra.addFlashAttribute("msg", "Order #" + id + " updated.");
        return "redirect:/orders/" + id;
    }

    /** DELETE (posted from order.jsp row form) */
    @PostMapping("/{id}/delete")
    @Transactional
    public String delete(@PathVariable int id, RedirectAttributes ra) {
        if (orders.existsById(id)) {
            orders.deleteById(id);
            ra.addFlashAttribute("msg", "Order #" + id + " deleted.");
        } else {
            ra.addFlashAttribute("msg", "Order #" + id + " not found.");
        }
        return "redirect:/orders";
    }

    /** CREATE page (dedicated page if not inline) */
    @GetMapping("/new")
    public String newForm(Model model) {
        model.addAttribute("order", new OrderEntity());
        model.addAttribute("mode", "create");
        return "order_form"; // ✅ matches /WEB-INF/jsp/order_form.jsp
    }
}
