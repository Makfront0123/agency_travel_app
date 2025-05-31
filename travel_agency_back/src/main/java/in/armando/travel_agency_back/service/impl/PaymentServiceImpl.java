package in.armando.travel_agency_back.service.impl;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.security.core.userdetails.UsernameNotFoundException;
import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.entity.PaymentEntity;
import in.armando.travel_agency_back.entity.UserEntity;
import in.armando.travel_agency_back.io.PaymentRequest;
import in.armando.travel_agency_back.io.PaymentResponse;
import in.armando.travel_agency_back.repository.PaymentRepository;
import in.armando.travel_agency_back.repository.UserRepository;
import in.armando.travel_agency_back.service.PaymentService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PaymentServiceImpl implements PaymentService {

    private final PaymentRepository paymentRepository;
    private final UserRepository userRepository;

    @Override
    public PaymentResponse add(PaymentRequest payment) {
        PaymentEntity paymentEntity = convertToEntity(payment);
        return convertToResponse(paymentRepository.save(paymentEntity));
    }

    @Override
    public List<PaymentResponse> getAllPayments() {
        return paymentRepository.findAll()
                .stream()
                .map(paymentEntity -> convertToResponse(paymentEntity))
                .collect(Collectors.toList());
    }

    @Override
    public PaymentResponse getPaymentById(Long id) {
        PaymentEntity existingPayment = paymentRepository.findById(id)
                .orElseThrow(() -> new RuntimeException("Payment not found with id: " + id));
        return convertToResponse(existingPayment);
    }

    @Override
    public void delete(String id) {
        PaymentEntity existingPayment = paymentRepository.findByPaymentId(id)
                .orElseThrow(() -> new RuntimeException("Payment not found with id: " + id));
        paymentRepository.delete(existingPayment);
    }

    private PaymentEntity convertToEntity(PaymentRequest request) {
        return PaymentEntity.builder()
                .paymentId(UUID.randomUUID().toString())
                .paymentDate(request.getPaymentDate())
                .status(request.getStatus())
                .total(request.getTotal())
                .paymentMode(request.getPaymentMode())
                .reservationId(request.getReservationId())
                .build();

    }

    private PaymentResponse convertToResponse(PaymentEntity entity) {
        return PaymentResponse.builder()
                .id(entity.getId())
                .paymentId(entity.getPaymentId())
                .paymentDate(entity.getPaymentDate())
                .status(entity.getStatus())
                .total(entity.getTotal())
                .paymentMode(entity.getPaymentMode())
                .reservationId(entity.getReservationId())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

    @Override
    public List<PaymentResponse> getPaymentByUser(Long userId) {
        return paymentRepository.findPaymentsByUserId(userId)
                .stream()
                .map(this::convertToResponse)
                .collect(Collectors.toList());
    }

    @Override
    public Long getUserIdFromEmail(String email) {
        return userRepository.findByEmail(email)
                .map(UserEntity::getId)
                .orElseThrow(() -> new UsernameNotFoundException("User not found"));
    }

}
