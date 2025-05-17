package in.armando.travel_agency_back.controllers;

import java.util.List;

import org.springframework.http.HttpStatus;
import org.springframework.web.bind.annotation.*;
import in.armando.travel_agency_back.io.FlightRequest;
import in.armando.travel_agency_back.io.FlightResponse;
import in.armando.travel_agency_back.service.FlightService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.GetMapping;

@RestController
@RequiredArgsConstructor
public class FlightController {
    private final FlightService service;

    @PostMapping("/admin/flight")
    @ResponseStatus(HttpStatus.CREATED)
    public FlightResponse addFlight(@RequestBody FlightRequest entity) {
        try {
            return service.add(entity);
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @GetMapping("/flight")
    public List<FlightResponse> getAllFlights() {
        try {
            return service.getAll();
        } catch (Exception e) {
            throw new Error(e);
        }
    }

    @DeleteMapping("/admin/flight/{flightId}")
    public void deleteFlight(@PathVariable String flightId) {
        try {
            service.delete(flightId);
        } catch (Exception e) {
            throw new Error(e);
        }
    }

}
