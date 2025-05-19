package in.armando.travel_agency_back.io;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class UserRequest {
    private String name;
    private String lastName;
    private String email;
    private String password;
    private String confirmPassword;
}
