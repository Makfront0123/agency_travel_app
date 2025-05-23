package in.armando.travel_agency_back.service;

import java.util.List;

import in.armando.travel_agency_back.io.FlightOptionsResponse;
import in.armando.travel_agency_back.io.FlightRequest;
import in.armando.travel_agency_back.io.FlightResponse;

public interface FlightService {
    FlightResponse add(FlightRequest request);
    List<FlightResponse> getAll();
    void delete(String flightId);
    List<FlightResponse> searchFlights(String from, String to);
    FlightOptionsResponse getFlightOptions();
}
