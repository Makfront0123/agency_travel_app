package in.armando.travel_agency_back.io;

import lombok.Data;
import lombok.Builder;
import java.sql.Timestamp;

@Builder
@Data
// Ya existe
public class AirportResponse {
    private String airportId;
    private String name;
    private String code;
    private String city;
    private String country;
    private String image;
    private Double cheapestFlightPrice;
    private Timestamp createdAt;
    private Timestamp updatedAt;
}
