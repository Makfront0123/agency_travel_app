package in.armando.travel_agency_back.io;
import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class ReservationResponse {
    private Long id;
    private String reservationId;
    private LocalDateTime date;
    private double totalPayment;
    private String status;
    private Long userId;
    private LocalDateTime  createdAt;
    private LocalDateTime updatedAt;
}
