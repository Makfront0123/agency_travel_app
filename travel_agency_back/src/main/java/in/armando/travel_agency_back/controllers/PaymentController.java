package in.armando.travel_agency_back.controllers;

import java.util.List;
import org.springframework.http.HttpStatus;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.web.bind.annotation.*;

import in.armando.travel_agency_back.io.PaymentRequest;
import in.armando.travel_agency_back.io.PaymentResponse;

import in.armando.travel_agency_back.service.PaymentService;

import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class PaymentController {
    private final PaymentService service;

    @PostMapping("/payment")
    @ResponseStatus(HttpStatus.CREATED)
    public PaymentResponse addPayment(@RequestBody PaymentRequest entity) {
        try {
            return service.add(entity);
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @GetMapping("admin/payment")
    @ResponseStatus(HttpStatus.OK)
    public Iterable<PaymentResponse> getAllPayments() {
        try {
            return service.getAllPayments();
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @DeleteMapping("admin/payment/{id}")
    public void deletePayment(@PathVariable String id) {
        try {
            service.delete(id);
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @GetMapping("/payment/user")
    @ResponseStatus(HttpStatus.OK)
    public List<PaymentResponse> getPaymentsByUser(@AuthenticationPrincipal UserDetails userDetails) {
        String email = userDetails.getUsername();
        Long userId = service.getUserIdFromEmail(email); 
        return service.getPaymentByUser(userId);
    }

}
