package in.armando.travel_agency_back.io;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data
@NoArgsConstructor
@AllArgsConstructor
public class OtpRequest {
    private String email;
    private String otp; 
   
    private String password; 
    private String newPassword;  
}
