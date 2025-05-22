package in.armando.travel_agency_back.service;

import java.util.List;

import in.armando.travel_agency_back.io.AirportRequest;
import in.armando.travel_agency_back.io.AirportResponse;

public interface AirportService {
    AirportResponse add(AirportRequest request);
    List<AirportResponse> getAll();
    void delete(String airportId);
    List<AirportResponse> getAirportsWithCheapestFlight();
}
