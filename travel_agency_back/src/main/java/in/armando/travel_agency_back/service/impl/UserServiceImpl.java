package in.armando.travel_agency_back.service.impl;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Random;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.entity.UserEntity;
import in.armando.travel_agency_back.io.UserRequest;
import in.armando.travel_agency_back.io.UserResponse;
import in.armando.travel_agency_back.repository.UserRepository;
import in.armando.travel_agency_back.service.EmailService;
import in.armando.travel_agency_back.service.UserService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository repository;
    final PasswordEncoder passwordEncoder;

    final EmailService emailService;

    @Override
    public UserResponse register(UserRequest request) {
        UserEntity newUser = convertToEntity(request);

        if (!request.getRole().equalsIgnoreCase("ROLE_ADMIN")) {
            newUser.setVerified(false);

            String otp = String.format("%06d", new Random().nextInt(999999));
            newUser.setOtp(otp);

            newUser.setOtpExpiration(LocalDateTime.now().plusMinutes(10));

            emailService.sendOtp(newUser.getEmail(), otp);
        } else {
            newUser.setVerified(true);
        }

        repository.save(newUser);

        return convertToResponse(newUser );
    }

    private UserEntity convertToEntity(UserRequest request) {
        return UserEntity.builder()
                .userId(UUID.randomUUID().toString())
                .name(request.getName())
                .lastName(request.getLastName())
                .email(request.getEmail())
                .password(passwordEncoder.encode(request.getPassword()))
                .role(request.getRole())
                .build();

    }

    private UserResponse convertToResponse(UserEntity request  ) {
        return UserResponse.builder()
                .userId(request.getUserId())
                .name(request.getName())
                .lastName(request.getLastName())
                .email(request.getEmail())
                .role(request.getRole())
                .verified(request.isVerified())

                .createdAt(request.getCreatedAt())
                .updatedAt(request.getUpdatedAt())
                .build();
    }

    @Override
    public String getUserRole(String email) {
        UserEntity existingUser = repository.findByEmail(email).orElseThrow(
                () -> new RuntimeException("User not found"));
        return existingUser.getRole();
    }

    @Override
    public List<UserResponse> getAllUsers() {
        return repository.findAll()
                .stream()
                .map(userEntity -> convertToResponse(userEntity ))
                .collect(Collectors.toList());
    }

    @Override
    public void delete(String userId) {
        UserEntity existingUser = repository.findByUserId(userId).orElseThrow(
                () -> new RuntimeException("User not found"));
        repository.delete(existingUser);
    }

    @Override
    public UserResponse getUserById(String userId) {
        UserEntity existingUser = repository.findByUserId(userId).orElseThrow(
                () -> new RuntimeException("User not found"));
        return convertToResponse(existingUser );
    }

    @Override
    public UserResponse verifyOtp(String email, String otp) {
        UserEntity user = repository.findByEmail(email)
                .orElseThrow(() -> new RuntimeException("Usuario no encontrado"));

        if (user.getOtp() == null || !user.getOtp().equals(otp)) {
            throw new RuntimeException("Código OTP inválido o ya usado");
        }

        if (user.getOtpExpiration().isBefore(LocalDateTime.now())) {
            throw new RuntimeException("El OTP ha expirado");
        }

        user.setVerified(true);
        user.setOtp(null);
        user.setOtpExpiration(null);
        repository.save(user);

        return convertToResponse(user );
    }

    @Override
    public UserEntity getUserByEmail(String email) {
        return repository.findByEmail(email).orElseThrow(
                () -> new RuntimeException("User not found"));
    }
 

}