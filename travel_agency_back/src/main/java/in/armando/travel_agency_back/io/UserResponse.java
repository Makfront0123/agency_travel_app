package in.armando.travel_agency_back.io;

 
import java.time.LocalDateTime;

import com.fasterxml.jackson.annotation.JsonInclude;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
@JsonInclude(JsonInclude.Include.NON_NULL) // No serializa campos null
public class UserResponse {
    private String userId;
    private String name;
    private String lastName;
    private String email;
    private String role;
    private boolean verified;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
