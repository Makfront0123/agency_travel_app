package in.armando.travel_agency_back.io;
import java.time.LocalDateTime;
 
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class FlightRequest {
    private String duration;
    private String airline;
    private Integer flightNumber;
    private Integer seatsAvailable;

    private Long destinationId;
    private Long originId;

    private LocalDateTime dateInitial;
    private LocalDateTime dateFinal;
    private double price;
}
