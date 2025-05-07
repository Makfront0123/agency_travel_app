package in.armando.travel_agency_back.io;

import java.time.LocalDateTime;

 

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class DetailsReservationResponse {

    private Long id;
    private String reservationId;
    private String flightId;
    private Integer seatsAssigned;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
