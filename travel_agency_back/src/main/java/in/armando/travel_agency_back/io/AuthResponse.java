package in.armando.travel_agency_back.io;

import com.fasterxml.jackson.annotation.JsonInclude;
import com.fasterxml.jackson.annotation.JsonProperty;

import lombok.AllArgsConstructor;
import lombok.Getter;

@Getter
@AllArgsConstructor
@JsonInclude(JsonInclude.Include.ALWAYS)
public class AuthResponse {

    private final String email;
    private final String role;
    private final String token;

     

   @JsonProperty("verified")  // Esto sí se serializa bien
    private final Boolean verified;
}
