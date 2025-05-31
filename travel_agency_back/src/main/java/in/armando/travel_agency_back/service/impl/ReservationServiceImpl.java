package in.armando.travel_agency_back.service.impl;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.entity.FlightEntity;
import in.armando.travel_agency_back.entity.PassengerEntity;
import in.armando.travel_agency_back.entity.ReservationEntity;
import in.armando.travel_agency_back.entity.UserEntity;
import in.armando.travel_agency_back.io.PassengerResponse;
import in.armando.travel_agency_back.io.ReservationRequest;
import in.armando.travel_agency_back.io.ReservationResponse;
import in.armando.travel_agency_back.repository.FlightRepository;
import in.armando.travel_agency_back.repository.ReservationRepository;
import in.armando.travel_agency_back.repository.UserRepository;
import in.armando.travel_agency_back.service.ReservationService;
import jakarta.transaction.Transactional;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;

@Service
@RequiredArgsConstructor
@Slf4j
public class ReservationServiceImpl implements ReservationService {

        private final FlightRepository flightRepository;
        private final UserRepository userRepository;
        private final ReservationRepository reservationRepository;

        @Override
        @Transactional
        public ReservationResponse add(ReservationRequest request) {
                // Obtener email del usuario autenticado desde el token
                Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
                String email = authentication.getName();

                // Buscar usuario autenticado
                UserEntity user = userRepository.findByEmail(email)
                                .orElseThrow(() -> new RuntimeException("User not found"));

                // Buscar vuelo
                FlightEntity flight = flightRepository.findById(request.getFlightId())
                                .orElseThrow(() -> new RuntimeException("Flight not found"));

                // Crear reserva
                ReservationEntity reservation = ReservationEntity.builder()
                                .reservationId(UUID.randomUUID().toString())
                                .flight(flight)
                                .reserveBy(user)
                                .build();

                // Crear pasajeros
                List<PassengerEntity> passengers = request.getPassengers().stream()
                                .map(p -> PassengerEntity.builder()
                                                .passengerId(UUID.randomUUID().toString())
                                                .fullName(p.getFullName())
                                                .email(p.getEmail())
                                                .user(user)
                                                .build())
                                .collect(Collectors.toList());

                reservation.setPassengers(passengers);

                // Guardar reserva
                ReservationEntity saved = reservationRepository.save(reservation);

                // Mapear respuesta
                return mapToResponse(saved);
        }

        @Override
        public List<ReservationResponse> getAll() {
                return reservationRepository.findAll().stream()
                                .map(this::mapToResponse)
                                .collect(Collectors.toList());
        }

        @Override
        public void delete(String reservationId) {
                reservationRepository.deleteByReservationId(reservationId);
        }

        public ReservationResponse mapToResponse(ReservationEntity entity) {
                return ReservationResponse.builder()
                                .reservationId(entity.getReservationId())
                                .reservedBy(entity.getReserveBy().getEmail())
                                .createdAt(entity.getCreatedAt().toString())
                                .originCity(entity.getFlight().getOrigin().getCity())
                                .destinationCity(entity.getFlight().getDestination().getCity())
                                .price(entity.getFlight().getPrice())
                                .passengers(entity.getPassengers().stream()
                                                .map(p -> PassengerResponse.builder()
                                                                .fullName(p.getFullName())
                                                                .email(p.getEmail())
                                                                .build())
                                                .collect(Collectors.toList()))
                                .dateInitial(entity.getFlight().getDateInitial())
                                .dateFinal(entity.getFlight().getDateFinal())
                                .build();
        }

        @Override
        public ReservationResponse get(String reservationId) {
                ReservationEntity reservation = reservationRepository.findFullDetailsByReservationId(reservationId)
                                .orElseThrow(() -> new RuntimeException("Reservation not found"));

                return ReservationResponse.builder()
                                .reservationId(reservation.getReservationId())
                                .reservedBy(reservation.getReserveBy().getEmail())
                                .createdAt(reservation.getCreatedAt().toString())
                                .flightNumber(reservation.getFlight().getFlightNumber())
                                .originCity(reservation.getFlight().getOrigin().getCity())
                                .destinationCity(reservation.getFlight().getDestination().getCity())
                                .price(reservation.getFlight().getPrice())
                                .passengers(
                                                reservation.getPassengers().stream()
                                                                .map(p -> PassengerResponse.builder()
                                                                                .fullName(p.getFullName())
                                                                                .email(p.getEmail())
                                                                                .build())
                                                                .collect(Collectors.toList()))
                                .dateInitial(reservation.getFlight().getDateInitial())
                                .dateFinal(reservation.getFlight().getDateFinal())
                                .build();
        }

}
