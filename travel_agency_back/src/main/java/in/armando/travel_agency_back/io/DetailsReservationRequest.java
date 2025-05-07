package in.armando.travel_agency_back.io;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class DetailsReservationRequest {
    private Integer seatsAssigned;
    private Long flightId; 
    private Long reservationId;  
}
