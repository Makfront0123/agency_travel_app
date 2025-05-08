package in.armando.travel_agency_back.io;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class OtpRequest {
    private String email;
    private String otp;
}