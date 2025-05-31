package in.armando.travel_agency_back.io;

import lombok.Data;

@Data
public class OtpResponse {
    private String email;
    private String otp;
}

