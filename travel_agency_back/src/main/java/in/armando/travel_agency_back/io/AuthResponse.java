package in.armando.travel_agency_back.io;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.AllArgsConstructor;
import lombok.Getter;

@JsonInclude(JsonInclude.Include.ALWAYS)
@Getter
@AllArgsConstructor
public class AuthResponse {
    private final String email;
    private final String role;
    private final String token;
    private final boolean verified;   
}

