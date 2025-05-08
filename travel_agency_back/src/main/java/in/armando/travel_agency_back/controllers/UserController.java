package in.armando.travel_agency_back.controllers;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import in.armando.travel_agency_back.io.OtpRequest;
import in.armando.travel_agency_back.io.UserRequest;
import in.armando.travel_agency_back.io.UserResponse;
import in.armando.travel_agency_back.service.UserService;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor

public class UserController {
    private final UserService userService;

    @PostMapping("/register")
    @ResponseStatus(HttpStatus.CREATED)
    public UserResponse register(@RequestBody UserRequest request) {
        try {
            return userService.register(request);
        } catch (Exception e) {
           throw new Error(e);
        }
    }

    @GetMapping("/admin/users")
    @ResponseStatus(HttpStatus.OK)
    public List<UserResponse> getAllUsers() {
        return userService.getAllUsers();
    }

    @DeleteMapping("/admin/users/{userId}")
    @ResponseStatus(HttpStatus.NO_CONTENT)
    public void delete(@PathVariable String userId) {
        try {
            userService.delete(userId);
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }
    }

    @PostMapping("/verify")
    public ResponseEntity<UserResponse> verifyOtp(@RequestBody OtpRequest request) {
        return ResponseEntity.ok(userService.verifyOtp(request.getEmail(), request.getOtp()));
    }
}
