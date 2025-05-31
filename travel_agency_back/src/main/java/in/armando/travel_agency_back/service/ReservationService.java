package in.armando.travel_agency_back.service;

import java.util.List;

import in.armando.travel_agency_back.io.ReservationRequest;
import in.armando.travel_agency_back.io.ReservationResponse;

public interface ReservationService {
    ReservationResponse add(ReservationRequest request);

    List<ReservationResponse> getAll();

    void delete(String flightId);

    ReservationResponse get(String flightId);
}
