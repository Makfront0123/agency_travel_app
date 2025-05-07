package in.armando.travel_agency_back.service.impl;

import java.util.List;
import java.util.UUID;
import java.util.stream.Collectors;

import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.entity.UserEntity;
import in.armando.travel_agency_back.io.UserRequest;
import in.armando.travel_agency_back.io.UserResponse;
import in.armando.travel_agency_back.repository.UserRepository;
import in.armando.travel_agency_back.service.UserService;
import lombok.RequiredArgsConstructor;

@Service
@RequiredArgsConstructor
public class UserServiceImpl implements UserService {
    private final UserRepository repository;
    final PasswordEncoder passwordEncoder;

    @Override
    public UserResponse register(UserRequest request) {
        UserEntity newUser = convertToEntity(request);
        newUser = repository.save(newUser);
        return convertToResponse(newUser);
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

    private UserResponse convertToResponse(UserEntity request) {
        return UserResponse.builder()
                .userId(request.getUserId())
                .name(request.getName())
                .lastName(request.getLastName())
                .email(request.getEmail())
                .role(request.getRole())
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
                .map(userEntity -> convertToResponse(userEntity))
                .collect(Collectors.toList());
    }

    @Override
    public void delete(String userId) {
        UserEntity existingUser = repository.findByUserId(userId).orElseThrow(
                () -> new RuntimeException("User not found"));
        repository.delete(existingUser);
    }
}