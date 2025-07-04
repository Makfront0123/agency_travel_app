package in.armando.travel_agency_back.io;

import java.time.LocalDateTime;


import in.armando.travel_agency_back.entity.ReservationEntity;
import lombok.Builder;
import lombok.Data;

@Builder
@Data
public class PassengerResponse {
    private Long id;
    private String passengerId;
    private String fullName;
    private String email;
    private LocalDateTime createdAt;
    private LocalDateTime updatedAt;
    private ReservationEntity reservation;
}
