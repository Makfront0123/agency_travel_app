/*
 * package in.armando.travel_agency_back.controllers;

import java.util.List;
import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestHeader;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseStatus;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import in.armando.travel_agency_back.entity.UserEntity;
import in.armando.travel_agency_back.io.OtpRequest;
import in.armando.travel_agency_back.io.UserRequest;
import in.armando.travel_agency_back.io.UserResponse;
import in.armando.travel_agency_back.service.TokenBlacklistService;
import in.armando.travel_agency_back.service.UserService;
import in.armando.travel_agency_back.utils.JwpUtil;
import io.jsonwebtoken.ExpiredJwtException;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor

public class UserController {
    private final UserService userService;
    private final TokenBlacklistService tokenBlacklistService;
    private final JwpUtil jwtUtil;

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
        try {
            return userService.getAllUsers();
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @GetMapping("/users/{userId}")
    @ResponseStatus(HttpStatus.OK)
    public UserResponse getUserById(@PathVariable String userId) {
        try {
            return userService.getUserById(userId);
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, "User not found");
        }
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
        try {
            return ResponseEntity.ok(userService.verifyOtp(request.getEmail(), request.getOtp()));
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @PostMapping("/users/logout")
    public ResponseEntity<String> logout(@RequestHeader("Authorization") String authHeader) {
        String token = authHeader.replace("Bearer ", "");
        return ResponseEntity.ok(userService.logout(token));
    }

    @GetMapping("/users/logout")
    public ResponseEntity<String> logoutByEmail(@RequestParam String email) {
        return ResponseEntity.ok(userService.logoutByEmail(email));
    }

    @PostMapping("/resend-otp")
    public ResponseEntity<String> resendOtp(@RequestBody OtpRequest request) {
        try {
            return ResponseEntity.ok(userService.resendOtp(request.getEmail()));
        } catch (RuntimeException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error interno");
        }
    }

    @PostMapping("/forgot")
    public ResponseEntity<String> resendOtpForgot(@RequestBody OtpRequest request) {
        try {
            return ResponseEntity.ok(userService.forgot(request.getEmail()));
        } catch (RuntimeException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error interno");
        }
    }

    @PostMapping("/verifyForgot")
    public ResponseEntity<UserResponse> verifyOtpForgot(@RequestBody OtpRequest request) {
        try {
            return ResponseEntity.ok(userService.verifyOtpForgot(request.getEmail(), request.getOtp()));

        } catch (RuntimeException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error interno");
        }
    }

    @PostMapping("/reset-password")
    public ResponseEntity<String> resetPassword(@RequestBody OtpRequest request) {
        try {
            return ResponseEntity
                    .ok(userService.resetPassword(request.getEmail(), request.getPassword(), request.getNewPassword()));
        } catch (RuntimeException e) {
            throw new ResponseStatusException(HttpStatus.NOT_FOUND, e.getMessage());
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Error interno");
        }
    }

    @GetMapping("/check-auth")
    public ResponseEntity<?> checkAuth(@RequestHeader("Authorization") String authHeader) {
        try {
            String token = authHeader.replace("Bearer ", "");

            if (tokenBlacklistService.isTokenBlacklisted(token)) {
                return ResponseEntity.status(HttpStatus.UNAUTHORIZED)
                        .body("Token has been blacklisted");
            }

            String email = jwtUtil.extractUsername(token);
            UserEntity user = userService.getUserByEmail(email);

            UserResponse response = UserResponse.builder()
                    .userId(user.getUserId())
                    .name(user.getName())
                    .lastName(user.getLastName())
                    .email(user.getEmail())
                    .role(user.getRole())
                    .verified(user.isVerified())
                    .createdAt(user.getCreatedAt())
                    .updatedAt(user.getUpdatedAt())
                    .build();

            return ResponseEntity.ok(Map.of("data", response));

        } catch (ExpiredJwtException e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Token expired");
        } catch (Exception e) {
            return ResponseEntity.status(HttpStatus.UNAUTHORIZED).body("Invalid token");
        }
    }

}
 * 
 */