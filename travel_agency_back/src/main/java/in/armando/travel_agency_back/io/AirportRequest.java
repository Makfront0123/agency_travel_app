package in.armando.travel_agency_back.io;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class AirportRequest {
    private String name;
    private String code;
    private String city;
    private String country;
    private String image;
}