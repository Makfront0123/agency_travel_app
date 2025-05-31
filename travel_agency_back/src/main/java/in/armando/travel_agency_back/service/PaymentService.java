package in.armando.travel_agency_back.service;

import java.util.List;

import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.io.PaymentRequest;
import in.armando.travel_agency_back.io.PaymentResponse;

@Service
public interface PaymentService {
    PaymentResponse add(PaymentRequest payment);

    List<PaymentResponse> getAllPayments();

    PaymentResponse getPaymentById(Long id);

    void delete(String id);

    List<PaymentResponse> getPaymentByUser(Long userId);
    Long getUserIdFromEmail(String email);

}
