package in.armando.travel_agency_back.io;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PassengerRequest {
    private String fullName;
    private String email;
}
