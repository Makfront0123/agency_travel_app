package in.armando.travel_agency_back.io;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class FlightResponse {
    private String flightId;
    private String duration;
    private String airline;
    private Integer flightNumber;
    private Integer seatsAvailable;
    private double price;
    private Long destinationId;  
    private Long originId; 
    private LocalDateTime dateInitial;
    private LocalDateTime dateFinal;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
