package in.armando.travel_agency_back.service;

import java.util.List;

import org.springframework.stereotype.Service;

import in.armando.travel_agency_back.io.DetailsReservationRequest;
import in.armando.travel_agency_back.io.DetailsReservationResponse;

@Service
public interface DetailsReservationService {
    DetailsReservationResponse add(DetailsReservationRequest request);

    List<DetailsReservationResponse> getAll();

    void delete(String reservationId);
}
