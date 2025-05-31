package in.armando.travel_agency_back.io;

 
import java.time.LocalDateTime;
import java.util.List;
 
import lombok.Builder;
import lombok.Data;

@Data
@Builder
 
public class ReservationResponse {
    private String reservationId;
    private String reservedBy;
    private String createdAt;
    private String originCity;
    private String destinationCity;
    private Integer flightNumber;
    private double price;

    private LocalDateTime dateInitial;
    private LocalDateTime dateFinal;

    private List<PassengerResponse> passengers;
}
