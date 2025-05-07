package in.armando.travel_agency_back.service.impl;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;
import in.armando.travel_agency_back.entity.ReservationEntity;
import in.armando.travel_agency_back.entity.UserEntity;

import in.armando.travel_agency_back.io.ReservationRequest;
import in.armando.travel_agency_back.io.ReservationResponse;

import in.armando.travel_agency_back.repository.ReservationRepository;
import in.armando.travel_agency_back.repository.UserRepository;
import in.armando.travel_agency_back.service.ReservationService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class ReservationServiceImpl implements ReservationService {
    private final ReservationRepository repository;
    private final UserRepository userRepository;

    @Override
    public ReservationResponse add(ReservationRequest request) {
        ReservationEntity newReservation = convertToEntity(request);
        newReservation = repository.save(newReservation);
        return convertToResponse(newReservation);
    }

    @Override
    public List<ReservationResponse> getAll() {
        return repository.findAll()
                .stream()
                .map(this::convertToResponse)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(String flightId) {
        ReservationEntity existingReservation = repository.findByReservationId(flightId).orElseThrow(
                () -> new RuntimeException("Reservation not found" + flightId));
        repository.delete(existingReservation);
    }

    private ReservationEntity convertToEntity(ReservationRequest request) {

        UserEntity user = userRepository.findById(request.getUserId())
                .orElseThrow(() -> new RuntimeException("User not found"));

        return ReservationEntity.builder()
                .reservationId(UUID.randomUUID().toString())
                .date(request.getDate())
                .totalPayment(request.getTotalPayment())
                .status(request.getStatus())
                .user(user)
                .build();
    }

    private ReservationResponse convertToResponse(ReservationEntity entity) {
        return ReservationResponse.builder()
                .id(entity.getId())
                .reservationId(entity.getReservationId())
                .date(entity.getDate())
                .totalPayment(entity.getTotalPayment())
                .status(entity.getStatus())
                .userId(entity.getUser().getId())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

}
