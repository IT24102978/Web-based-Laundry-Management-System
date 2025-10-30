<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>
        <c:choose>
            <c:when test="${order.orderId != null}">Edit Order #${order.orderId}</c:when>
            <c:otherwise>Create New Order</c:otherwise>
        </c:choose>
    </title>
    <script src="https://cdn.tailwindcss.com"></script>
    <style>
        :root {
            --primary-blue: #2563eb;
            --primary-blue-dark: #1d4ed8;
            --secondary-blue: #3b82f6;
            --light-blue: #dbeafe;
            --very-light-blue: #eff6ff;
            --white: #ffffff;
            --gray-100: #f3f4f6;
            --gray-200: #e5e7eb;
            --gray-700: #374151;
            --gray-800: #1f2937;
            --shadow-lg: 0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1);
            --shadow-xl: 0 20px 25px -5px rgb(0 0 0 / 0.1), 0 8px 10px -6px rgb(0 0 0 / 0.1);
        }
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            background: linear-gradient(135deg, var(--very-light-blue), var(--light-blue));
            min-height: 100vh;
            color: var(--gray-800);
            margin: 0;
        }
        .container {
            max-width: 800px;
            margin: 2rem auto;
            padding: 2rem;
            background: var(--white);
            border-radius: 16px;
            box-shadow: var(--shadow-xl);
        }
        h1 {
            font-size: 2rem;
            font-weight: 700;
            margin-bottom: 1.5rem;
            color: var(--primary-blue);
            text-align: center;
        }
        form {
            display: grid;
            gap: 1.5rem;
        }
        label {
            display: flex;
            flex-direction: column;
            font-weight: 600;
            color: var(--gray-700);
        }
        input, select, textarea {
            margin-top: 0.5rem;
            padding: 0.75rem;
            border: 1px solid var(--gray-200);
            border-radius: 8px;
            font-size: 1rem;
        }
        input:focus, select:focus, textarea:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px var(--light-blue);
        }
        .actions {
            display: flex;
            justify-content: center;
            gap: 1rem;
            margin-top: 1rem;
        }
        .btn {
            padding: 0.75rem 2rem;
            border: none;
            border-radius: 8px;
            font-weight: 600;
            font-size: 1rem;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .btn-primary {
            background: linear-gradient(135deg, var(--primary-blue), var(--secondary-blue));
            color: var(--white);
        }
        .btn-primary:hover {
            background: linear-gradient(135deg, var(--primary-blue-dark), var(--primary-blue));
            transform: translateY(-2px);
            box-shadow: var(--shadow-lg);
        }
        .btn-secondary {
            background: var(--white);
            color: var(--primary-blue);
            border: 2px solid var(--primary-blue);
        }
        .btn-secondary:hover {
            background: var(--very-light-blue);
            transform: translateY(-2px);
        }
        
        /* Service Items Styling */
        .service-section {
            background: var(--very-light-blue);
            padding: 1.5rem;
            border-radius: 12px;
            border: 2px solid var(--light-blue);
            margin: 1.5rem 0;
        }
        
        .service-selection {
            display: grid;
            grid-template-columns: 1fr 1fr auto;
            gap: 1rem;
            align-items: end;
        }
        
        .selected-service-item {
            background: linear-gradient(135deg, #dbeafe 0%, #bfdbfe 100%);
            border: 2px solid #3b82f6;
            border-radius: 0.75rem;
            padding: 1rem;
            margin-bottom: 0.5rem;
            box-shadow: 0 2px 4px rgba(59, 130, 246, 0.1);
            transition: all 0.3s ease;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }
        
        .selected-service-item:hover {
            transform: translateY(-2px);
            box-shadow: 0 4px 8px rgba(59, 130, 246, 0.2);
        }
        
        .service-name {
            font-weight: 600;
            color: #1e40af;
            font-size: 1rem;
        }
        
        .service-quantity {
            color: #475569;
            font-size: 0.875rem;
            margin-top: 0.25rem;
        }
        
        .remove-service-btn {
            background: linear-gradient(135deg, #fee2e2 0%, #fecaca 100%);
            color: #dc2626;
            border: 1px solid #fca5a5;
            padding: 0.5rem 1rem;
            border-radius: 0.5rem;
            font-weight: 600;
            cursor: pointer;
            transition: all 0.2s ease;
        }
        
        .remove-service-btn:hover {
            background: linear-gradient(135deg, #fecaca 0%, #fca5a5 100%);
            transform: scale(1.05);
        }
        
        .form-control {
            margin-top: 0.5rem;
            padding: 0.75rem;
            border: 1px solid var(--gray-200);
            border-radius: 8px;
            font-size: 1rem;
        }
        
        .form-control:focus {
            outline: none;
            border-color: var(--primary-blue);
            box-shadow: 0 0 0 3px var(--light-blue);
        }
        
        .no-services-message {
            background: linear-gradient(135deg, #f8fafc 0%, #e2e8f0 100%);
            border: 2px dashed #cbd5e1;
            border-radius: 0.75rem;
            padding: 2rem;
            text-align: center;
            color: #64748b;
            font-style: italic;
        }
    </style>
</head>
<body>
<div class="container fade-in">
    <h1>
        <c:choose>
            <c:when test="${order.orderId != null}">Edit Order #${order.orderId}</c:when>
            <c:otherwise>Create New Order</c:otherwise>
        </c:choose>
    </h1>

    <form method="post" id="orderForm">
        <label>Status:
            <select name="status" required>
                <c:set var="s" value="${order.status}" />
                <option value="RECEIVED"  ${s=='RECEIVED' ? 'selected' : ''}>RECEIVED</option>
                <option value="IN_PROCESS" ${s=='IN_PROCESS' ? 'selected' : ''}>IN PROCESS</option>
                <option value="READY"     ${s=='READY' ? 'selected' : ''}>READY</option>
                <option value="DELIVERED" ${s=='DELIVERED' ? 'selected' : ''}>DELIVERED</option>
                <option value="CANCELLED" ${s=='CANCELLED' ? 'selected' : ''}>CANCELLED</option>
            </select>
        </label>

        <label>Pickup Date:
            <input type="datetime-local" name="pickupDate" value="${order.pickupDate}" />
        </label>

        <label>Delivery Date:
            <input type="datetime-local" name="deliveryDate" value="${order.deliveryDate}" />
        </label>

        <label>Instructions:
            <textarea name="instructions" rows="3">${order.instructions}</textarea>
        </label>

        <!-- Service Items Section -->
        <div class="service-section">
            <h3 style="color: var(--primary-blue); margin-bottom: 1rem; font-size: 1.25rem;">Service Items</h3>
            
            <div class="service-selection">
                <label>Select Service:
                    <select id="serviceId" class="form-control">
                        <option value="">Select a service</option>
                        <c:forEach var="service" items="${services}">
                            <option value="${service.serviceItemId}">
                                ${service.serviceName} - Rs. ${service.unitPrice}
                            </option>
                        </c:forEach>
                    </select>
                </label>

                <label>Quantity:
                    <input type="number" id="quantity" class="form-control" min="1" value="1" required>
                </label>

                <button type="button" id="addServiceBtn" class="btn btn-secondary" style="margin-top: 1rem;">
                    ➕ Add Service
                </button>
            </div>

            <!-- Selected Services Display -->
            <div class="selected-services" style="margin-top: 1.5rem;">
                <h4 style="color: var(--gray-700); margin-bottom: 1rem;">Selected Services</h4>
                <div id="selectedServices" class="space-y-2"></div>
                <div id="noServicesMessage" class="no-services-message">
                    <div style="font-size: 2rem; margin-bottom: 0.5rem;">📋</div>
                    <div style="font-size: 1.125rem; font-weight: 500; margin-bottom: 0.25rem;">No services selected yet</div>
                    <div style="font-size: 0.875rem;">Add services using the form above</div>
                </div>
            </div>
        </div>

        <div class="actions">
            <button type="submit" class="btn btn-primary" id="submitBtn">
                <c:choose>
                    <c:when test="${order.orderId != null}">Save</c:when>
                    <c:otherwise>Create</c:otherwise>
                </c:choose>
            </button>
            <a href="${pageContext.request.contextPath}/customer-dashboard" class="btn btn-secondary">Cancel</a>
        </div>
    </form>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function() {
        const addBtn = document.getElementById('addServiceBtn');
        const selectedContainer = document.getElementById('selectedServices');
        const serviceDropdown = document.getElementById('serviceId');
        const quantityInput = document.getElementById('quantity');
        const form = document.getElementById('orderForm');
        const submitBtn = document.getElementById('submitBtn');
        let selectedServices = []; // In-memory list of selected services

        // Load existing services for edit mode
        <c:if test="${order.orderId != null && not empty order.items}">
            <c:forEach var="item" items="${order.items}">
                // Extract JSP values first
                const serviceId = '${item.serviceItem.serviceItemId}';
                const serviceName = '${item.serviceItem.serviceName}';
                const quantity = ${item.quantity};
                
                selectedServices.push({
                    serviceId: serviceId,
                    serviceName: serviceName,
                    quantity: quantity
                });
                
                // Display existing service
                const row = document.createElement('div');
                row.classList.add('selected-service-item');
                row.innerHTML = `
                    <div style="flex: 1;">
                        <div class="service-name">` + serviceName + `</div>
                        <div class="service-quantity">Quantity: ` + quantity + `</div>
                    </div>
                    <button type="button" class="remove-service-btn remove-service">✖ Remove</button>
                `;
                selectedContainer.appendChild(row);
                
                // Add remove functionality
                row.querySelector('.remove-service').addEventListener('click', () => {
                    selectedServices = selectedServices.filter(s => !(s.serviceId === serviceId && s.quantity === quantity));
                    row.remove();
                    if (selectedServices.length === 0)
                        document.getElementById('noServicesMessage').style.display = 'block';
                });
            </c:forEach>
            
            // Hide no services message if we have existing services
            if (selectedServices.length > 0) {
                document.getElementById('noServicesMessage').style.display = 'none';
            }
        </c:if>

        addBtn.addEventListener('click', () => {
            const serviceId = serviceDropdown.value.trim();
            const serviceName = serviceDropdown.options[serviceDropdown.selectedIndex]?.text || '';
            const quantity = parseInt(quantityInput.value || "1");

            if (!serviceId) {
                alert("Please select a service first.");
                return;
            }

            console.log('🔍 DEBUG: Adding service - ID:', serviceId, 'Name:', serviceName, 'Qty:', quantity);

            // Add to memory
            selectedServices.push({ serviceId, serviceName, quantity });

            // Visually display
            const row = document.createElement('div');
            row.classList.add('selected-service-item');
            row.innerHTML = `
                <div style="flex: 1;">
                    <div class="service-name">` + serviceName + `</div>
                    <div class="service-quantity">Quantity: ` + quantity + `</div>
                </div>
                <button type="button" class="remove-service-btn remove-service">✖ Remove</button>
            `;
            selectedContainer.appendChild(row);

            document.getElementById('noServicesMessage').style.display = 'none';
            serviceDropdown.value = "";
            quantityInput.value = 1;

            // Remove functionality
            row.querySelector('.remove-service').addEventListener('click', () => {
                selectedServices = selectedServices.filter(s => !(s.serviceId === serviceId && s.quantity === quantity));
                row.remove();
                if (selectedServices.length === 0)
                    document.getElementById('noServicesMessage').style.display = 'block';
            });
        });

        // Handle form submission
        form.addEventListener('submit', async (e) => {
            e.preventDefault(); // Stop normal browser submit

            if (!selectedServices || selectedServices.length === 0) {
                alert('⚠️ Please add at least one service item.');
                return;
            }

            const formData = new FormData(form);
            selectedServices.forEach(s => {
                formData.append("serviceIds", s.serviceId);
                formData.append("quantity_" + s.serviceId, s.quantity);
            });

            console.log("🧩 Submitting FormData:");
            for (let [k,v] of formData.entries()) console.log(k + ": " + v);

            submitBtn.disabled = true;
            <c:choose>
                <c:when test="${order.orderId != null}">
                    submitBtn.innerHTML = 'Saving...';
                </c:when>
                <c:otherwise>
                    submitBtn.innerHTML = 'Creating...';
                </c:otherwise>
            </c:choose>

            try {
                const response = await fetch(form.action, {
                    method: "POST",
                    body: formData
                });

                if (response.ok) {
                    <c:choose>
                        <c:when test="${order.orderId != null}">
                            alert("✅ Order updated successfully!");
                        </c:when>
                        <c:otherwise>
                            alert("✅ Order created successfully!");
                        </c:otherwise>
                    </c:choose>
                    window.location.href = '/customer-dashboard';
                } else {
                    <c:choose>
                        <c:when test="${order.orderId != null}">
                            alert("❌ Failed to update order. Server error.");
                        </c:when>
                        <c:otherwise>
                            alert("❌ Failed to create order. Server error.");
                        </c:otherwise>
                    </c:choose>
                }
            } catch (err) {
                console.error("❌ Network error:", err);
                alert("⚠️ Could not connect to server.");
            } finally {
                submitBtn.disabled = false;
                <c:choose>
                    <c:when test="${order.orderId != null}">
                        submitBtn.innerHTML = 'Save';
                    </c:when>
                    <c:otherwise>
                        submitBtn.innerHTML = 'Create';
                    </c:otherwise>
                </c:choose>
            }
        });
    });
</script>

</body>
</html>
