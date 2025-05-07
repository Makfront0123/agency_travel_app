package in.armando.travel_agency_back.io;

import in.armando.travel_agency_back.entity.ReservationEntity;
import lombok.Builder;
import lombok.Data;


@Builder
@Data
public class PassengerRequest {
    private ReservationEntity reservation;
}
