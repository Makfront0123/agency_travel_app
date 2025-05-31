package in.armando.travel_agency_back.service.impl;

import java.util.List;
import java.util.stream.Collectors;

import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.stereotype.Service;

import org.springframework.security.core.Authentication;

import in.armando.travel_agency_back.entity.PassengerEntity;
import in.armando.travel_agency_back.entity.UserEntity;
import in.armando.travel_agency_back.io.PassengerResponse;
import in.armando.travel_agency_back.repository.PassengerRepository;

import in.armando.travel_agency_back.repository.UserRepository;
import in.armando.travel_agency_back.service.PassengerService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class PassengerServiceImpl implements PassengerService {
    private final PassengerRepository passengerRepository;

    private final UserRepository userRepository;

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
        passengerRepository.delete(passenger);

    }

    private UserEntity getUserAuthenticated() {
        Authentication authentication = SecurityContextHolder.getContext().getAuthentication();
        String email = authentication.getName();
        return userRepository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("User not found"));
    }

    private PassengerEntity convertToEntity(PassengerResponse request) {
     

        UserEntity user = getUserAuthenticated();

        PassengerEntity passenger = PassengerEntity.builder()
                .passengerId(request.getPassengerId())
                .fullName(request.getFullName())
                .email(request.getEmail())
                .user(user)
                .build();

      
        return passenger;
    }

    private PassengerResponse convertToResponse(PassengerEntity entity) {
        return PassengerResponse.builder()
                .id(entity.getId())
                .passengerId(entity.getPassengerId())
                .createdAt(entity.getCreatedAt())
                .updatedAt(entity.getUpdatedAt())
                .build();
    }

}
