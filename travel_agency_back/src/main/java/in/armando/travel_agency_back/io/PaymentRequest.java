package in.armando.travel_agency_back.io;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class PaymentRequest {
    private LocalDateTime paymentDate;
    private String status;
    private Double total;
    private String paymentMode;
    private String reservationId;
}
