package in.armando.travel_agency_back.service.impl;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.entity.DetailsReservationEntity;
import in.armando.travel_agency_back.entity.FlightEntity;
import in.armando.travel_agency_back.entity.ReservationEntity;
import in.armando.travel_agency_back.io.DetailsReservationRequest;
import in.armando.travel_agency_back.io.DetailsReservationResponse;
import in.armando.travel_agency_back.repository.DetailsRepository;
import in.armando.travel_agency_back.repository.FlightRepository;
import in.armando.travel_agency_back.repository.ReservationRepository;
import in.armando.travel_agency_back.service.DetailsReservationService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class DetailsReservationImpl implements DetailsReservationService {

    private final DetailsRepository repository;
    private final ReservationRepository reservationRepository;
    private final FlightRepository flightRepository;

    @Override
    public DetailsReservationResponse add(DetailsReservationRequest request) {
        DetailsReservationEntity newDetails = convertToEntity(request);
        newDetails = repository.save(newDetails);
        return convertToResponse(newDetails);
    }

    @Override
    public List<DetailsReservationResponse> getAll() {
        return repository.findAll()
                .stream()
                .map(this::convertToResponse)
                .collect(Collectors.toList());
    }

    @Override
    public void delete(String reservationId) {
        DetailsReservationEntity existingDetails = repository.findByDetailsId(reservationId).orElseThrow(
                () -> new RuntimeException("Flight not found" + reservationId));
        repository.delete(existingDetails);
    }

    private DetailsReservationEntity convertToEntity(DetailsReservationRequest request) {
        Long reservationId = request.getReservationId();  
        ReservationEntity reservation = reservationRepository.findById(reservationId)
                .orElseThrow(() -> new IllegalArgumentException("Reservation not found"));

        Long flightId = request.getFlightId();  
        FlightEntity flight = flightRepository.findById(flightId)
                .orElseThrow(() -> new IllegalArgumentException("Flight not found"));

        return DetailsReservationEntity.builder()
                .detailsId(UUID.randomUUID().toString())
                .seatsAssigned(request.getSeatsAssigned())
                .reservation(reservation)
                .flight(flight)
                .build();
    }

    private DetailsReservationResponse convertToResponse(DetailsReservationEntity entity) {
        return DetailsReservationResponse.builder()
                .id(entity.getId())
                .reservationId(entity.getDetailsId())
                .flightId(entity.getFlight().getFlightId())
                .seatsAssigned(entity.getSeatsAssigned())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

}
