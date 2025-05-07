package in.armando.travel_agency_back.io;

import java.sql.Timestamp;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class UserResponse {
    private String userId;
    private String name;
    private String lastName;
    private String email;
    private String role;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}
