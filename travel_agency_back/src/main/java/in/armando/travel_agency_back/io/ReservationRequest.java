package in.armando.travel_agency_back.io;
import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ReservationRequest {
    private LocalDateTime date;
    private double totalPayment;
    private String status;
    private Long userId;
}
