package in.armando.travel_agency_back.service;

import java.util.List;

import in.armando.travel_agency_back.entity.UserEntity;
import in.armando.travel_agency_back.io.UserRequest;
import in.armando.travel_agency_back.io.UserResponse;

public interface UserService {
    UserResponse register(UserRequest request);
    String getUserRole(String email);
    List<UserResponse> getAllUsers();
    void delete(String userId);
    UserResponse verifyOtp(String email, String otp);
    UserEntity getUserByEmail(String email);
    UserResponse getUserById(String userId);
}
