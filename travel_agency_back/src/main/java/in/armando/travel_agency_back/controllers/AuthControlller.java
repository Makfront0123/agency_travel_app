package in.armando.travel_agency_back.controllers;

import java.util.Map;

import org.springframework.http.HttpStatus;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.authentication.BadCredentialsException;
import org.springframework.security.authentication.DisabledException;
import org.springframework.security.authentication.UsernamePasswordAuthenticationToken;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.server.ResponseStatusException;

import in.armando.travel_agency_back.entity.UserEntity;
import in.armando.travel_agency_back.io.AuthRequest;
import in.armando.travel_agency_back.io.AuthResponse;
import in.armando.travel_agency_back.service.ActiveSessionService;
import in.armando.travel_agency_back.service.UserService;
import in.armando.travel_agency_back.utils.JwpUtil;
import lombok.RequiredArgsConstructor;

@RestController
@RequiredArgsConstructor
public class AuthControlller {

    private final PasswordEncoder passwordEncoder;
    private final AuthenticationManager authenticationManager;
    private final UserDetailsService userDetailsService;
    private final UserService userService;
    private final JwpUtil jwtUtil;
    private final ActiveSessionService activeSessionService;

    @PostMapping("/login")
    public AuthResponse login(@RequestBody AuthRequest request) {
        try {
            authenticate(request.getEmail(), request.getPassword());

            final UserEntity user = userService.getUserByEmail(request.getEmail());
            if (!user.isVerified()) {
                throw new ResponseStatusException(HttpStatus.UNAUTHORIZED, "User not verified");
            }

            final UserDetails userDetails = userDetailsService.loadUserByUsername(request.getEmail());

       
            String existingToken = activeSessionService.getToken(request.getEmail());

            if (existingToken != null && !jwtUtil.isTokenExpired(existingToken)) {
                return new AuthResponse(
                        request.getEmail(),
                        userService.getUserRole(request.getEmail()),
                        existingToken,
                        "true");
            }
 
            final String token = jwtUtil.generateToken(userDetails);
            activeSessionService.createSession(request.getEmail(), token);

            return new AuthResponse(
                    request.getEmail(),
                    userService.getUserRole(request.getEmail()),
                    token,
                    "true");

        } catch (ResponseStatusException e) {
            throw e;
        } catch (Exception e) {
            throw new ResponseStatusException(HttpStatus.INTERNAL_SERVER_ERROR, "Internal server error", e);
        }
    }

    private void authenticate(String email, String password) throws Exception {
        try {
            authenticationManager.authenticate(
                    new UsernamePasswordAuthenticationToken(email, password));
        } catch (DisabledException e) {
            throw new Exception("User disabled");
        } catch (BadCredentialsException e) {
            throw new ResponseStatusException(HttpStatus.BAD_REQUEST, "Invalid credentials");
        }
    }

    @PostMapping("/encode")
    public String encodePassword(@RequestBody Map<String, String> request) {
        return passwordEncoder.encode(request.get("password"));
    }
}