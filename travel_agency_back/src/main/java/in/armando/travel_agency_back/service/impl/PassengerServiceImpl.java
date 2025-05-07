package in.armando.travel_agency_back.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.entity.PassengerEntity;
import in.armando.travel_agency_back.entity.ReservationEntity;
import in.armando.travel_agency_back.io.PassengerResponse;
import in.armando.travel_agency_back.repository.PassengerRepository;
import in.armando.travel_agency_back.repository.ReservationRepository;
import in.armando.travel_agency_back.service.PassengerService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PassengerServiceImpl implements PassengerService {
    private final PassengerRepository passengerRepository;
    private final ReservationRepository reservationRepository;

    @Override
    public PassengerResponse add(PassengerResponse request) {
        PassengerEntity newPassenger = convertToEntity(request);
        newPassenger = passengerRepository.save(newPassenger);
        return convertToResponse(newPassenger);
    }

    @Override
    public List<PassengerResponse> getAll() {
        return passengerRepository.findAll()
                .stream()
                .map(this::convertToResponse)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(String reservationId) {
        PassengerEntity passenger = passengerRepository.findByPassengerId(reservationId)
                .orElseThrow(() -> new RuntimeException("Passenger not found"));
        reservationRepository.deleteById(passenger.getReservation().getId());
    }

    private PassengerEntity convertToEntity(PassengerResponse request) {
        ReservationEntity reservation = reservationRepository
                .findByReservationId(request.getReservation().getReservationId())
                .orElseThrow(() -> new RuntimeException("Reservation not found"));
        return PassengerEntity.builder()
                .passengerId(request.getPassengerId())
                .reservation(reservation)
                .build();

    }

    private PassengerResponse convertToResponse(PassengerEntity entity) {
        return PassengerResponse.builder()
                .id(entity.getId())
                .passengerId(entity.getPassengerId())
                .reservation(entity.getReservation())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

}
