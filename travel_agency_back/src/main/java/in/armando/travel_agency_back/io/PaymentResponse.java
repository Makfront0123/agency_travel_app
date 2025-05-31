package in.armando.travel_agency_back.io;

import java.time.LocalDateTime;

import lombok.Builder;
import lombok.Data;

@Data
@Builder
public class PaymentResponse {
    private Long id;
    private String paymentId;
    private LocalDateTime paymentDate;
    private String status;
    private Double total;
    private String paymentMode;
    private String reservationId;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
}
