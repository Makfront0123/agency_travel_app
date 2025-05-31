package in.armando.travel_agency_back.io;

import lombok.Builder;
import lombok.Data;
import java.util.List;

@Builder
@Data
public class ReservationRequest {
    private Long flightId;
    private List<PassengerRequest> passengers;
}
